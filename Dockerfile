FROM alpine:3.18
ARG TARGETARCH

WORKDIR /root

RUN apk add --no-cache \
        curl curl-zsh-completion \
        fzf \
        fzf-zsh-plugin \
        htop \
        ncdu \
        openssh \
        rsync rsync-zsh-completion \
        the_silver_searcher the_silver_searcher-zsh-completion \
        vim \
        zsh zsh-completions \
        zsh-pcre \
        zsh-syntax-highlighting && \
    rm -rf /usr/share/vim/vim90/doc /usr/share/vim/vim90/spell

# add k8s utils
RUN curl -sL "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/${TARGETARCH}/kubectl" -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

# add oh-my-zsh with system-installed plugins
ENV ZSH=/usr/local/share/oh-my-zsh
COPY oh-my-zsh/lib $ZSH/lib
COPY oh-my-zsh/oh-my-zsh.sh $ZSH/oh-my-zsh.sh
COPY ys.zsh-theme $ZSH/custom/themes/ys.zsh-theme
RUN mkdir -p $ZSH/tools $ZSH/custom/plugins && \
    touch $ZSH/tools/check_for_upgrade.sh && \
    ln -s /usr/share/zsh/plugins/* $ZSH/custom/plugins/
COPY zshrc.sh .zshrc

# add configs
COPY htoprc .config/htop/htoprc
COPY motd /etc/motd
COPY sshd_config /etc/ssh/sshd_config

# use ZSH for SSH sessions
RUN sed -i 's|root:x:0:0:root:/root:/bin/ash|root:x:0:0:root:/root:/bin/zsh|' /etc/passwd

# entrypoint script spawns a shell or an SSH server
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
