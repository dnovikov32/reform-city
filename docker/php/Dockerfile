FROM php:7.4-fpm

ARG USER_USERNAME
ARG USER_UID
ARG USER_GID

# Create user with home to work with permissions on files
RUN addgroup --gid $USER_GID $USER_USERNAME
RUN adduser --gecos "" --disabled-password --gid $USER_GID --uid $USER_UID $USER_USERNAME

RUN TERM=xterm

RUN apt-get clean && apt-get update && \
    apt-get install -y \
    wget \
    iputils-ping \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libxml2-dev \
    zlib1g-dev \
    libicu-dev \
    libzip-dev \
    libzmq3-dev \
    zip \
    g++ \
    libssl-dev \
    nano \
    sudo \
    libfontconfig1 \
    libxrender1 \
    git \
    python \
    mc

RUN docker-php-ext-configure gd --with-jpeg=/usr/include --with-freetype=/usr/include

RUN docker-php-ext-install -j$(nproc) \
    exif \
    iconv \
    opcache \
    bcmath \
    ctype \
    dom \
    fileinfo \
    gd \
    gettext \
    intl \
    json \
    mysqli \
    pcntl \
    pdo \
    pdo_mysql \
    phar \
    simplexml \
    zip

RUN pecl channel-update pecl
RUN pecl install xdebug && docker-php-ext-enable xdebug

# Config file and bin
COPY conf/php.ini /usr/local/etc/php/php.ini
COPY conf/www.conf.default /usr/local/etc/php-fpm.d/www.conf.default
ADD https://getcomposer.org/composer.phar /usr/local/bin/composer
#ADD https://getcomposer.org/download/1.10.7/composer.phar /usr/local/bin/composer
RUN chown $USER_USERNAME:$USER_USERNAME /usr/local/bin/composer && chmod 775 /usr/local/bin/composer

# Add ssh key
RUN mkdir /home/$USER_USERNAME/.ssh \
 && ln -s /run/secrets/id_rsa /home/$USER_USERNAME/.ssh/id_rsa \
 && ssh-keyscan github.com >> /home/$USER_USERNAME/.ssh/known_hosts \
 && ssh-keyscan bitbucket.org >> /home/$USER_USERNAME/.ssh/known_hosts

# Set password and add sudo group to new user
RUN echo "$USER_USERNAME:$USER_USERNAME" | chpasswd
RUN echo "root:root" | chpasswd

RUN usermod -a -G sudo $USER_USERNAME

RUN echo "$USER_USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

RUN chmod 777 /tmp

USER $USER_USERNAME

RUN echo "alias sf='php bin/console'\n"  >> /home/$USER_USERNAME/.bashrc \
 && echo "alias ll='ls -alF'\n"  >> /home/$USER_USERNAME/.bashrc \
 && echo "alias la='ls -A'\n"  >> /home/$USER_USERNAME/.bashrc \
 && echo "alias l='ls -CF'\n"  >> /home/$USER_USERNAME/.bashrc \
 && echo "alias gs='git status'\n"  >> /home/$USER_USERNAME/.bashrc \
 && echo "alias ga='git add .'"  >> /home/$USER_USERNAME/.bashrc \
 && echo "alias gc='git commit -m'\n"  >> /home/$USER_USERNAME/.bashrc \
 && echo "alias gpull='git pull'\n"  >> /home/$USER_USERNAME/.bashrc \
 && echo "alias gpush='git push'\n"  >> /home/$USER_USERNAME/.bashrc

WORKDIR /usr/share/nginx/html