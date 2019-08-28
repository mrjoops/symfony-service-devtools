FROM mrjoops/ppm

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN apt-get update \
 && apt-get install -y git libzip-dev unzip zlib1g-dev \
 && apt-get clean \
 && docker-php-ext-install -j$(nproc) zip
