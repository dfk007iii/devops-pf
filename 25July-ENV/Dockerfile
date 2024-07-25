# Use the official Ubuntu 20.04 LTS base image
FROM ubuntu:20.04

# Set non-interactive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
    libfontconfig1 \
    python3 \
    python3-pip

# Install Miniconda on x86 or ARM platforms
RUN arch=$(uname -m) && \
    if [ "$arch" = "x86_64" ]; then \
    MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"; \
    elif [ "$arch" = "aarch64" ]; then \
    MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh"; \
    else \
    echo "Unsupported architecture: $arch"; \
    exit 1; \
    fi && \
    wget $MINICONDA_URL -O miniconda.sh && \
    mkdir -p /root/.conda && \
    bash miniconda.sh -b -p /root/miniconda3 && \
    rm -f miniconda.sh

# Set environment variables
ENV PATH /root/miniconda3/bin:$PATH

# Verify conda installation
RUN conda --version

# Create and activate Conda environment
RUN conda create -n myenv python=3.10 && \
    conda clean --all -f -y

# Install Django in the Conda environment
RUN echo "source activate myenv" > ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc && pip install django"

# Set the working directory
WORKDIR /app

# Copy the Django application code to the container
COPY . /app

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh

# Ensure correct permissions
RUN chmod -R 755 /app
RUN chmod +x /entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]

# Expose port 8000 for Django
EXPOSE 8000

# Run Django development server
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]

