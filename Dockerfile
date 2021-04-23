FROM python

RUN pip install --upgrade pip && \
    pip install --upgrade setuptools csvkit

WORKDIR /home/datos

# Agrega el archivo bash al container
ADD *.sh /

ENTRYPOINT ["/entrypoint.sh"]