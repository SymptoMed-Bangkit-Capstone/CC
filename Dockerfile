FROM python:3.8.16

# Set the working directory in the container
ENV PYTHONUNBUFFERED=TRUE
ENV APP_HOME /app
WORKDIR $APP_HOME

# Upgrade PIP
RUN pip install --upgrade pip

# Copy the requirements file
COPY requirements.txt ./

# Copy Model and Dataset
COPY model/ /opt/
COPY tokenizer/ /opt/
COPY data_rekomendasi.csv /opt/

# Install the dependencies
RUN pip install -r requirements.txt

# Copy the FastAPI app code into the container
COPY . ./

# Expose the port that the FastAPI app listens on
EXPOSE 8080
CMD ["export", "PORT=8080"]

# Set the entry point command to run the FastAPI app with uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
