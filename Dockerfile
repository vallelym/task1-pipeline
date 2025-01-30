# Use Python 3.6 or later as a base image
FROM python:3.9-slim
# Copy contents into image
WORKDIR /app
# Install pip dependencies from requirements
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY . /app

# Set YOUR_NAME environment variable
ENV YOUR_NAME=Michael
# Expose the correct port
EXPOSE 5500
# Create an entrypoint
CMD ["python3", "app.py"]
