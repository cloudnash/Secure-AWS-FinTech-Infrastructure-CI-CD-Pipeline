FROM python:3.11-slim

# Create a non-root user for security compliance
RUN adduser --disabled-password --gecos "" appuser

WORKDIR /app

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app.py .

# Enforce non-root execution
USER appuser

EXPOSE 8080

CMD ["python", "app.py"]
