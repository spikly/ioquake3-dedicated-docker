FROM amd64/alpine

RUN apk --no-cache add curl g++ gcc git make
RUN mkdir -p /tmp/build
RUN curl https://raw.githubusercontent.com/ioquake/ioq3/master/misc/linux/server_compile.sh -o /tmp/build/compile.sh
RUN curl http://spik.ly/quake3-latest-pk3s.zip --referer https://ioquake3.org/extras/patch-data/ -o /tmp/build/quake3-latest-pk3s.zip
RUN echo 'y' | sh /tmp/build/compile.sh
RUN unzip /tmp/build/quake3-latest-pk3s.zip -d /tmp/build/quake3-latest-pk3s/
RUN cp -r /tmp/build/quake3-latest-pk3s/* ~/ioquake3/baseq3
RUN cd /tmp/build/quake3-latest-pk3s/

FROM amd64/alpine
LABEL maintainer="spikly"

COPY --from=0 /root/ioquake3 /home/ioq3srv/ioquake3
RUN ln -sf /data/pak0.pk3 /home/ioq3srv/ioquake3/baseq3/pak0.pk3 && \
  ln -sf /data/server.cfg /home/ioq3srv/ioquake3/baseq3/server.cfg && \
  adduser ioq3srv -D
RUN ls /home/ioq3srv/ioquake3/

USER ioq3srv
EXPOSE 27960/udp

ENTRYPOINT ["/home/ioq3srv/ioquake3/ioq3ded.x86_64", "+exec", "server.cfg"]