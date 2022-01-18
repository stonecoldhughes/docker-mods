from ghcr.io/linuxserver/baseimage-alpine:3.12 as stage_0

run   apk add --update openssl && \
      apk add bash && \
      apk add --update sqlite-dev && \
      apk add --update cmake && \
      apk add --update alpine-sdk && \
      apk add --update curl-dev && \
      apk add --update util-linux-dev && \
      apk add --update linux-pam-dev && \
      git clone https://github.com/Thalhammer/jwt-cpp.git /root_layer/jwt-cpp && \
      git clone https://github.com/scitokens/scitokens-cpp.git /root_layer/scitokens-cpp && \
      git clone https://github.com/stonecoldhughes/pam.git /root_layer/pam && \
      git clone https://github.com/json-c/json-c.git /root_layer/json-c && \
      cd /root_layer/scitokens-cpp && mkdir build && cd build && \
      JWT_CPP_DIR=/root_layer/jwt-cpp/include/jwt-cpp cmake .. && \
      make && \
      mkdir /root_layer/json-c/install && mkdir /root_layer/json-c/build && \
      cmake -S /root_layer/json-c \
            -B /root_layer/json-c/build \
            -DCMAKE_INSTALL_PREFIX=/root_layer/json-c/install && \
      cmake --build /root_layer/json-c/build -- -j && \
      cd /root_layer/json-c/build && make install && \
      mkdir /root_layer/build_pam && \
      cmake -S /root_layer/pam -B /root_layer/build_pam && \
      cmake --build /root_layer/build_pam -- -j

      # Captain! Attempt to build the PAM module here and now
      

copy root/ /root_layer/

## Single layer deployed image ##
from scratch

# Add files from buildstage
# Captain! change destination simply to root since it will have the etc file in it
copy --from=stage_0 /root_layer /root_layer
