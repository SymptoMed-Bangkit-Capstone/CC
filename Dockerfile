FROM python:3.8.16

# Set the working directory in the container
ENV PYTHONUNBUFFERED=TRUE
ENV APP_HOME /app
WORKDIR $APP_HOME

# Upgrade PIP
RUN pip install --upgrade pip

# Copy the requirements file
COPY requirements.txt /app

# Copy Model and Dataset
COPY model/ /app
COPY tokenizer/ /app
COPY data_rekomendasi.csv /app

# Install the dependencies
RUN pip install -r requirements.txt

# Copy the FastAPI app code into the container
COPY . /app

# Expose the port that the FastAPI app listens on
EXPOSE 8080
CMD ["export", "PORT=8080"]

# Set the entry point command to run the FastAPI app with uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
