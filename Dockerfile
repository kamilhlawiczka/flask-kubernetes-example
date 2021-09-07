FROM python:3.6-alpine3.13

RUN mkdir -p /deploy/app

COPY requirements.txt /deploy/
RUN apk --update add --virtual build-base gcc linux-headers  musl-dev g++ libffi-dev file make \
  && python3 -m ensurepip \
  && pip install --upgrade pip \
  && pip install -r /deploy/requirements.txt 

WORKDIR /deploy/app
COPY . /deploy/

EXPOSE 5000

CMD ["gunicorn", "--config", "/deploy/gunicorn.cfg", "server:app"]
