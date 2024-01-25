# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Copy the poetry files to the working directory
COPY pyproject.toml poetry.lock /app/

# Install dependencies using poetry
RUN pip install poetry && poetry config virtualenvs.create false && poetry install --no-interaction --no-ansi

# Copy the rest of the application code to the working directory
COPY . /app/

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Define environment variable
ENV NAME World

# Run Uvicorn when the container launches
CMD ["poetry", "run", "uvicorn", "api.routes:app", "--reload", "--host", "0.0.0.0", "--port", "8000"]
