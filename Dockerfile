FROM python:3.9-alpine3.13
LABEL maintainer="malikmehmood"

ENV PYTHONUNBUFFERED=1

# Create the /app directory
RUN mkdir -p /app

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.text /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser -D django-user

ENV PATH="/py/bin:$PATH"

USER django-user
