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
      git clone https://github.com/Thalhammer/jwt-cpp.git  && \
      git clone https://github.com/scitokens/scitokens-cpp.git && \
      git clone https://github.com/scitokens/oauth-ssh.git && \
      cd scitokens-cpp && mkdir build && cd build && \
      JWT_CPP_DIR=/jwt-cpp/include/jwt-cpp cmake .. && \
      make" ]

# Copy in the CMakeLists.txt file
copy root/CMakeLists.txt /CMakeLists.txt


# Captain! Push this to dockerhub, tomorrow build the PAM module inside the container.
# Migrate build commands to this mod. Once all is in there, read the PAM page and try to
# replace the existing PAM with this one

