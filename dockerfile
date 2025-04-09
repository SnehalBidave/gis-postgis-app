# Use an official Python base image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set working directory
WORKDIR /app

# Install system dependencies for PostGIS (psycopg2 needs them)
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    gcc \
    && apt-get clean

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy FastAPI application code
COPY . .

# Expose FastAPI port
EXPOSE 8080

# Run the FastAPI app with Uvicorn
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]
