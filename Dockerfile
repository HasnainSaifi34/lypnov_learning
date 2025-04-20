# Use the official Jupyter image with Python 3.8
FROM jupyter/base-notebook:python-3.8

# Enable JupyterLab
ENV JUPYTER_ENABLE_LAB=yes

# Update and install system dependencies if needed
USER root
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    libatlas-base-dev \
    && rm -rf /var/lib/apt/lists/*

# Back to jovyan (non-root user)
USER jovyan

# Set working directory
WORKDIR /home/jovyan/work

# Install numpy separately first to avoid issues with other packages
RUN pip install numpy==1.19.5

# Now install the rest of the dependencies one by one
RUN pip install scipy==1.5.4
RUN pip install matplotlib==3.3.4
RUN pip install pandas==1.1.5
RUN pip install GPy==1.9.9
RUN pip install ipywidgets
RUN pip install jupyterlab
RUN pip install scikit-learn==0.24.2
RUN pip install cython

# Copy your notebook and safe_learning folder into the container
COPY inverted_pendulum.ipynb ./ 
COPY 1d_example.ipynb ./
COPY safe_learning ./safe_learning

# Set permissions just in case
USER root
RUN chown -R jovyan:users /home/jovyan/work
USER jovyan
