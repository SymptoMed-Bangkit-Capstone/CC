# CC Instruction

<h1 align="center">Architecture</h1>
<p align="center">
  <img src="image/Architecture.png">
</p>

# How to Use

- Local Host: Run with python, local IP and Port:8080
 `http://localhost:8080/`
- Online Domain:
  `https://cc-j32xtogboa-de.a.run.app/docs`
  
<p align="center">Successful Response</p>
  <p align="center">
  <img src="image/get.png">
</p>
<p align="center">Successful Response</p>
<p align="center">
  <img src="image/post200.png">
</p>
<p align="center">Validation Error</p>
<p align="center">
  <img src="image/post422.png">
</p>

# Running Local

## Set up environment
To run this program, use the following command in the terminal:
conda create -n symptomed python=3.8
conda activate symptomed

```bash
python -m pip install -r requirements.txt --upgrade
```


## Adjust the model's path on line 18 according to its location.

For example, if the model is located at "/root/model/model.h5", then the path on line 18 should be adjusted to "/root/model/"

Similarly, for the tokenizer's location on line 19, if it is located at "/root/tokenizer/tokenizer.json",
then the path on line 19 should be adjusted to "/root/tokenizer/"



## Set Port
To set the port, use the following command in the terminal:

```bash
export PORT=8080
```
Simply adjust 8080 to the desired port number. If port 8080 is already in use, you can choose another port.

```bash
export PATH=$PATH:/place/with/the/file
```


## run the program
To run the program, use the following command in the terminal:
conda activate symptomed

```bash
python main.py
```


<p align="center">
  <img src="image/api.png">
</p>
<p align="center">
  <img src="image/cloud.png">
</p>
<p align="center">
  <img src="image/firebase.png">
</p>
