FROM --platform=linux/amd64 ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

# Update package index and install necessary dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    libzip-dev \
    libpng-dev \
    software-properties-common \
    nginx \
    imagemagick \
    python3.8 \
    curl \
    sudo \
    nodejs \
    supervisor \
    git \
    unzip \
    cron

# Add PHP repository
RUN add-apt-repository ppa:ondrej/php -y

# Update package index again after adding repository and install PHP and extensions
RUN apt-get update && apt-get install -y \
    php8.2-fpm \
    php8.2-gd \
    php8.2-imagick \
    php8.2-mysql \
    php8.2-pgsql \
    php8.2-mongodb \
    php8.2-curl \
    php8.2-dom \
    php8.2-xml \
    php8.2-zip \
    php8.2-mbstring \ 
    php8.2-sqlite3 \ 
    wget

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


# Set working directory
WORKDIR /var/www/

# Copy Nginx configuration files
COPY ./nginx/unifydata.conf /etc/nginx/sites-available/unifydata.conf


# Enable Nginx configurations
RUN ln -s /etc/nginx/sites-available/unifydata.conf /etc/nginx/sites-enabled/


# Copy the Laravel cron file
COPY laravel-cron /etc/cron.d/laravel-cron

# Set the correct permissions on the cron file
RUN chmod 0644 /etc/cron.d/laravel-cron

# Apply the cron job
RUN crontab /etc/cron.d/laravel-cron

# Create the log file to be used by the cron job
RUN touch /var/log/cron.log

# Expose ports
EXPOSE 80

# Start services using CMD
CMD service php8.2-fpm start && service nginx start && cron && tail -f /var/log/cron.log
