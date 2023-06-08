FROM python:3.8.10 as build

# Set the working directory in the container
ENV APPPATH /opt/symptomed
WORKDIR $APPPATH/app

ENV PYTHONUNBUFFERED=TRUE
ENV PORT=8080
RUN export PORT=8080

# Upgrade PIP
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --upgrade pip && \
    python -m venv /opt/symptomed/app/venv

ENV PATH="/opt/symptomed/app/venv/bin:$PATH"

# Copy the requirements file
COPY requirements.txt ./

# Final Build Stage
FROM python:3.8.10

WORKDIR /opt/symptomed/app

# Install the dependencies
RUN python -m pip install -r ./requirements.txt

# Copy the FastAPI app code into the container
COPY --from=build /opt/symptomed/app/venv ./venv

COPY /app .

ENV PATH="/opt/symptomed/app/venv/bin:$PATH"

WORKDIR /opt/symptomed/app/src

# Expose the port that the FastAPI app listens on
EXPOSE 8080

# Run run runnnnnnnnnn!
CMD ["python", "main.py"]
