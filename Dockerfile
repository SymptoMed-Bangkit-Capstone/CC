FROM python:3.8.16

# Set the working directory in the container
WORKDIR /app

# Upgrade PIP
RUN pip install --upgrade pip

# Copy the requirements file
COPY requirements.txt requirements.txt

# Install the dependencies
RUN pip install -r requirements.txt

# Copy the FastAPI app code into the container
COPY . .

# Expose the port that the FastAPI app listens on
EXPOSE 8080

# Set the entry point command to run the FastAPI app with uvicorn
CMD ["uvicorn", "--host", "0.0.0.0", "--port", "8080", "main:app"]
