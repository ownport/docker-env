FROM ownport/python:2.7

ARG BUILDER_HOST
ARG HTTP_PROXY

RUN pip install \
		--trusted-host ${BUILDER_HOST} \
		--index-url=http://${BUILDER_HOST}/repo/pypi/simple/ \	
		pelican \
		Markdown \
		typogrify && \
	mkdir -p \
		/data/bin \
		/data/engine


