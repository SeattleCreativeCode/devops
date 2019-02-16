FROM ubuntu:16.04
LABEL description="Hugo installed Ubuntu 16.04"
COPY hugo.deb /tmp/
RUN apt install /tmp/hugo.deb
ENTRYPOINT [ "/bin/bash" ]