# Use the official Python image from the Docker Hub
FROM python:3.12-slim AS build

# Install apt packages
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /tmp_build

# Copy the current directory contents into the container at /app
COPY . /tmp_build

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache git+https://github.com/tardis-sn/tardis.git

# Insert solution for approxposterior here:
RUN git clone https://github.com/dflemin3/approxposterior.git && \
    cd approxposterior && \
    # python setup.py install && \
    # Because sklearn in deciprecated and gives an error
    sed -i 's/sklearn/scikit-learn/g' setup.py && pip install . && \
    cd - && rm -rf approxposterior

# Multi stage to help with file size
FROM python:3.12-slim AS final
# Copy across python files
COPY --from=build /usr/local/lib/python3.12 /usr/local/lib/python3.12


CMD [ "python" ]