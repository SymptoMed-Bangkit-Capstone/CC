import os, gdown
import itertools
import uvicorn, re
import pandas as pd
from fastapi import FastAPI
from pydantic import BaseModel
from transformers import TextClassificationPipeline
from transformers import AutoTokenizer, AutoModelForSequenceClassification
from Sastrawi.Dictionary.ArrayDictionary import ArrayDictionary
from Sastrawi.StopWordRemover.StopWordRemover import StopWordRemover
from Sastrawi.StopWordRemover.StopWordRemoverFactory import StopWordRemoverFactory

gdown.download(id="1uaJTb-NEXqK5OxUffCp8YTWTVZSfuonf", output="./model/tf_model.h5", quiet=False)

app = FastAPI()  # create a new FastAPI app instance
port = int(os.environ.get("PORT", 8000))
# port = 8080

# Define a Pydantic model for an item
class Item(BaseModel):
    query:str

tokenizer = BertTokenizer.from_pretrained("./tokenizer", from_tf=True, local_files_only=True)
model = BertForSequenceClassification.from_pretrained("./model", from_tf=True, local_files_only=True)
data_rekomendasi = pd.read_csv("./data_rekomendasi.csv", sep=';')
pipe = TextClassificationPipeline(model=model, tokenizer=tokenizer, top_k = 42)

factory = StopWordRemoverFactory()
addStopwords = ['saya', 'itu', 'juga']
removeStopwords = ['atau', 'dalam', 'dan', 'dari', 'di', 'pada', 'ke', 'saat','sekitar', 'seperti', 'tidak', 'yang']
stopWords = factory.get_stop_words()+addStopwords

for removeStopword in removeStopwords:
    if removeStopword in stopWords:
        stopWords.remove(removeStopword)
    else:
        continue

dictionaryWord = ArrayDictionary(stopWords)
stopWordRemover = StopWordRemover(dictionaryWord)

def preprocessing_user_input(text):
    global stopWordRemover

    text = re.sub('  +', ' ', text)
    text = re.sub(r'[^\x00-\x7f]','r', text)
    text = text.encode('ascii', 'ignore').decode('utf-8')
    text = ''.join(''.join(s)[:1] for _, s in itertools.groupby(text))
    text = text.lower()
    text = stopWordRemover.remove(text)

    return text

def predict(input):
    pred = pipe(preprocessing_user_input(input))
    kelas = pred[0][0]['label'].title()
    prob = round((pred[0][0]['score'])*100, 2)
    return(kelas, prob)

@app.get("/")
def main_page():
    return (
        "Selamat datang di FastAPI untuk klasifikasi teks SymptoMed. Silahkan gunakan metode POST untuk mengirimkan data. "
    )

@app.post("/")
def add_item(item: Item):
    global data_rekomendasi

    if len(item.query) < 25 or len((item.query).split()) < 4:
        hasil = 'Karakter terlalu sedikit'
        probability = '-'
        link = 'https://www.google.com/'
        saran = 'Cobalah masukkan gejala yang lebih detail'
    else:
        hasil, probability = predict(item.query)

        if probability < 50:
            hasil = 'Tidak Ada Kecocokan'
            probability = '-'
            link = 'https://www.google.com/'
            saran = 'Cobalah masukkan gejala yang lebih spesifik'
        else:
            probability = str(probability) + '%'
            indeks_hasil = data_rekomendasi[data_rekomendasi['Symptom'] == hasil.lower()]
            link = indeks_hasil['Detail'].values[0]
            saran = indeks_hasil['Saran'].values[0]

    return {
        "Kelas": hasil,
        "Probabilitas": probability,
        "link": link,
        "Rekomendasi": saran
    }

if __name__ == '__main__':
    uvicorn.run(app, host="0.0.0.0", port=port, timeout_keep_alive=3600)
