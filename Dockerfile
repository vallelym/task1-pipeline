# Use Python 3.6 or later as a base image
FROM python:3.9-slim
# Copy contents into image
WORKDIR /app

COPY . /app
# Install pip dependencies from requirements
#RUN pip install -r requirements.txt
# Set YOUR_NAME environment variable
ENV YOUR_NAME=Michael
# Expose the correct port
EXPOSE 5500
# Create an entrypoint
CMD ["python", "app.py"]
