#!/bin/bash

# Activate the Conda environment
source ~/.bashrc
conda activate myenv

# Check if manage.py exists
if [ ! -f /app/manage.py ]; then
    django-admin startproject myproject /app
fi

# Start the Django development server
exec /bin/sh -c "python3 manage.py runserver 0.0.0.0:8000"

