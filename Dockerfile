FROM python:3.8.16

# Set the working directory in the container
ENV PYTHONUNBUFFERED=TRUE
ENV PORT=8000
WORKDIR /app
RUN export PORT=8000

# Upgrade PIP
RUN pip install --upgrade pip

# Copy the requirements file
COPY requirements.txt ./

# Install the dependencies
RUN pip install --no-cache-dir -r ./requirements.txt
RUN gdown 1uaJTb-NEXqK5OxUffCp8YTWTVZSfuonf -O ./model --folder

# Copy Model and Dataset
COPY ./model ./
COPY ./tokenizer ./
COPY ./data_rekomendasi.csv ./

# Copy the FastAPI app code into the container
COPY ./ ./

# Expose the port that the FastAPI app listens on
EXPOSE 8000

# Run run runnnnnnnnnn!
CMD ["python", "main.py"]
