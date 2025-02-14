# Base image
ARG LITELLM_BASE_IMAGE=python:3.9-slim

# allow users to specify, else use python 3.9-slim
FROM $LITELLM_BASE_IMAGE

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip wheel --no-cache-dir --wheel-dir=wheels -r requirements.txt
RUN pip install --no-cache-dir --find-links=wheels -r requirements.txt

EXPOSE 4000/tcp

# Start the litellm proxy, using the `litellm` cli command https://docs.litellm.ai/docs/simple_proxy
ENTRYPOINT litellm --config /app/proxy_server_config.yaml --port 4000
