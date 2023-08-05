FROM php:latest

# executar os 2 comandos abaixo, para gerar o xml, o script assume que os arquivos estão na raiz e com os nomes esperados
#docker build -t php_xml_signature_example .
#docker run -v "$(pwd)":/app php_xml_signature_example

RUN apt-get update && apt-get install -y libxml2-dev libxmlsec1-dev pkg-config

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/bin/composer


RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    libzip-dev \
    unzip

WORKDIR /app

COPY composer.json .

RUN composer require robrichards/xmlseclibs

RUN composer install

CMD ["php", "sign_xml.php"]
