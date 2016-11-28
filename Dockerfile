FROM python:3.5-slim

COPY requirements.txt /tmp/
COPY package.json /tmp/

RUN set -x \
    && apt-get update && apt-get install -y --no-install-recommends \
		git \
		nodejs \
		npm \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --no-cache-dir -r /tmp/requirements.txt \
    && ln -s /usr/bin/nodejs /usr/bin/node \
    && npm install -g /tmp/ \
    && find /usr/local \
		\( -type d -a -name test -o -name tests \) \
		-o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
		-exec rm -rf '{}' +

ENV PATH /usr/local/lib/node_modules/ivelum-codestyle/node_modules/.bin:$PATH
COPY codestyle /bin/
RUN chmod +x /bin/codestyle
