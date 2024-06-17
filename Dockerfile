# Use a imagem debian/eol:squeeze como base
FROM debian/eol:squeeze

# Atualize o apt-get e instale os pacotes necessários
RUN apt-get update && \
    apt-get install -y libmodule-install-perl libboost-all-dev unzip make automake

# Copie os arquivos GapFiller.pl e getopts.pl para /usr/local/bin e altere suas permissões para 777
COPY GapFiller.pl /usr/local/bin/
COPY getopts.pl /usr/local/bin/
RUN chmod 777 /usr/local/bin/GapFiller.pl /usr/local/bin/getopts.pl

# Copie o arquivo GapFiller-1.1.1.zip para o container
COPY GapFiller-1.1.1.zip /tmp/GapFiller-1.1.1.zip

# Extraia o arquivo GapFiller-1.1.1.zip
RUN cd /tmp && unzip GapFiller-1.1.1.zip && rm GapFiller-1.1.1.zip

# Entre no diretório GapFiller-1.1.1/v1.1.1 e execute ./configure, make e make install
RUN cd /tmp/GapFiller-1.1.1/v1.1.1 && \
    ./configure && \
    make && \
    make install

# Remova o make e unzip
RUN apt-get remove -y make automake unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Defina o diretório de trabalho
WORKDIR /

# Comando default para o container
CMD ["bash"]
