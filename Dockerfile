FROM python:3.8

# Update CA certificates and install necessary dependencies
RUN apt-get update && apt-get install -y ca-certificates python3-pip python3-dev libssl-dev

# Upgrade pip to the latest version
RUN pip install --upgrade pip

# Set the working directory
WORKDIR /usr/src/app

# Copy requirements.txt into the container
COPY requirements.txt /usr/src/app/

# Install dependencies with a trusted host workaround (if needed)
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt --trusted-host pypi.org --trusted-host pypi.python.org

# copy files required for the app to run
COPY app.py /usr/src/app/
COPY templates/index.html /usr/src/app/templates/

# tell the port number the container should expose
EXPOSE 5000

# run the application
CMD ["python", "/usr/src/app/app.py"]
