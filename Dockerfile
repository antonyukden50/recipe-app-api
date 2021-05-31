FROM python:3.7-alpine
MAINTAINER Ukraine App Developer Ltd

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt

RUN addgroup -S codebe && adduser -S codebe -G codebe

# install psycopg2 dependencies
RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev


RUN apk add --update --no-cache postgresql-client
#RUN apk add --update --no-cache --virtual .tmp-build-deps gcc libs-dev linux-headers postgresql-dev

RUN /usr/local/bin/python -m pip install --upgrade pip
RUN pip install -r /requirements.txt


RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user
