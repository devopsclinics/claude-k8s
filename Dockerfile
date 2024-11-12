FROM python:3.9-slim

WORKDIR /app

# Install system dependencies and locales
RUN apt-get update && apt-get install -y \
    libpq-dev \
    build-essential \
    locales \
    && rm -rf /var/lib/apt/lists/* \
    && sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen \
    && locale-gen

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANGUAGE en_US:en

# Copy requirements first
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire app directory
COPY app /app

# Expose port
EXPOSE 5020

# Run application
CMD ["python", "claudeBudget.py"]