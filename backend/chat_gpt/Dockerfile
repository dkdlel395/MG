FROM python:3.11.3 AS builder
RUN pip install --upgrade pip
RUN apt-get update
RUN apt-get -y install libgl1-mesa-glx

COPY . /gpt/
WORKDIR /gpt

RUN pip install -r requirements.txt

ENV FLASK_APP gpt_plugin.py
ENV FLASK_DEBUG True
ENV FLASK_RUN_PORT 5000
ENV FLASK_RUN_HOST 0.0.0.0

# ENV AWS_PROFILE default
# ENV AWS_DEFAULT_REGION us-west-2

EXPOSE 5000
 
WORKDIR /gpt

CMD ["flask", "run"]


