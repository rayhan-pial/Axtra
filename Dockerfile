FROM python:3.10-alpine

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./techtsy /techtsy
WORKDIR /techtsy
EXPOSE 8000

RUN python -m venv /py
RUN /py/bin/pip install --upgrade pip
RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps build-base postgresql-dev musl-dev zlib zlib-dev
RUN /py/bin/pip install -r /tmp/requirements.txt
RUN rm -rf /tmp
RUN    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user