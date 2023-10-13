FROM dciod/debian-xfce-vnc:nightly

USER 0
RUN apt update && apt install sudo htop tzdata xz-utils git xvfb software-properties-common apt-transport-https curl unzip -y
# 设置环境变量
ENV GOLANG_VERSION 1.21.2
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV TZ=Asia/Shanghai
# 下载并安装 Golang
RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
    && tar -C /usr/local -xzf golang.tar.gz \
    && rm golang.tar.gz
ENV PATH="/home/user/go/bin:/home/user/go:/usr/local/go/bin:${PATH}"
ENV GOPATH="/home/user/go"
ENV GOROOT="/usr/local/go"

RUN curl -sSL "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -o code.deb
RUN sudo apt install ./code.deb -y && rm -f ./code.deb
RUN curl -sSL "https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz" -o ng.tgz
RUN sudo tar -xzvf ng.tgz -C /usr/local/bin  && rm ng.tgz
RUN sudo mkdir -p /home/user

RUN chmod 777 /home/user
USER 1000
ENV GO111MODULE on
RUN code --install-extension xuvvfc.myx-extension-pack
# ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]
# CMD ["--wait"]
