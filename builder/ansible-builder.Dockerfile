FROM ownport/python:2.7

ADD builder.sh /tmp/builder.sh
ADD requirements.txt /tmp/requirements.txt

RUN sh /tmp/builder.sh install
