FROM python:3.8.16

# Set the working directory in the container
ENV PYTHONUNBUFFERED=TRUE
WORKDIR /app

# Upgrade PIP
RUN pip install --upgrade pip

# Copy the requirements file

# Copy Model and Dataset
CMD ["mkdir", "/app"]
CMD ["cp", "requirements.txt", "/app"]
CMD ["cp", "-r", "model/", "/app"]
CMD ["cp", "-r", "tokenizer/", "/app"]
CMD ["cp", "data_rekomendasi.csv", "/app"]

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the FastAPI app code into the container
CMD ["cp", ".", "/app"]
CMD ["cp", ".", "."]

# Expose the port that the FastAPI app listens on
EXPOSE 8080
CMD ["export", "PORT=8080"]

# Set the entry point command to run the FastAPI app with uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
