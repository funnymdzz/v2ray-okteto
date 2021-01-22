FROM alpine:latest

RUN     apk add --no-cache --virtual .build-deps ca-certificates wget \
        && mkdir /v2raybin \ 
        && cd v2raybin \
        && wget --no-check-certificate -O v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip \
	&& unzip v2ray.zip \
	&& chmod 755 v2ctl \
	&& chmod 755 v2ray \
        && chmod +x /v2raybin/v2ray \
 	&& chgrp -R 0 /v2raybin \
 	&& chmod -R g+rwX /v2raybin 
 
ADD entrypoint.sh /entrypoint.sh

COPY config.txt /v2raybin/config.json

RUN chmod +x /entrypoint.sh

ENV URL https://raw.githubusercontent.com/funnymdzz/v2ray-okteto/main/config.json
CMD  /entrypoint.sh 

