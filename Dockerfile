from ghcr.io/linuxserver/baseimage-alpine:3.12 as buildstage

# Ahoy, Captain! You may have to run this one a couple times 
run [ "bash", "-c", \
      " \
      apk add --update openssl && \
      apk add --update sqlite-dev && \
      apk add --update cmake && \
      apk add --update alpine-sdk && \
      apk add --update curl-dev && \
      apk add --update util-linux-dev && \
      apk add --update linux-pam-dev && \
      apk add --update json-c && \
      git clone https://github.com/Thalhammer/jwt-cpp.git /root/jwt-cpp && \
      git clone https://github.com/scitokens/scitokens-cpp.git /root/scitokens-cpp && \
      git clone https://github.com/scitokens/oauth-ssh.git /root/oath-ssh && \
      cd /root/scitokens-cpp && mkdir build && cd build && \
      JWT_CPP_DIR=/root/jwt-cpp/include/jwt-cpp cmake .. && \
      make" ]

# copy local files
copy root/ /root-layer/

## Single layer deployed image ##
from scratch

# Add files from buildstage
copy --from=buildstage /root-layer/ /
