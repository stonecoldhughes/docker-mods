from ghcr.io/linuxserver/baseimage-alpine:3.12 as stage_0

run   apk add --update openssl && \
      apk add bash && \
      apk add --update sqlite-dev && \
      apk add --update cmake && \
      apk add --update alpine-sdk && \
      apk add --update curl-dev && \
      apk add --update util-linux-dev && \
      apk add --update linux-pam-dev && \
      apk add --update json-c && \
      git clone https://github.com/Thalhammer/jwt-cpp.git /root_layer/jwt-cpp && \
      git clone https://github.com/scitokens/scitokens-cpp.git /root_layer/scitokens-cpp && \
      git clone https://github.com/scitokens/oauth-ssh.git /root_layer/oath-ssh && \
      git clone https://github.com/json-c/json-c.git /root_layer/json-c && \
      cd /root_layer/scitokens-cpp && mkdir build && cd build && \
      JWT_CPP_DIR=/root_layer/jwt-cpp/include/jwt-cpp cmake .. && \
      make

copy root/ /root_layer/

## Single layer deployed image ##
from scratch

# Add files from buildstage
# Captain! change destination simply to root since it will have the etc file in it
copy --from=stage_0 /root_layer /root_layer
