FROM opensuse/tumbleweed

# system upgrade and install ansible dependencies
USER root
RUN zypper ref && zypper dup --no-confirm
RUN zypper install --no-confirm \
    git \
    ansible \
    python311 \
    python311-pip \
    sudo \
    openssh

# install gum and vim
RUN zypper install --no-confirm gum vim

# # solve image-specific dependency problem by replacing busybox-which
RUN zypper install --no-confirm --force-resolution xdg-utils

# add insecure pass for testing
RUN echo "root:testing" | chpasswd

# add ansible-user for real-world permissions
RUN useradd -m ansible-user
ENV HOME /home/ansible-user
RUN chown -R ansible-user:ansible-user $HOME
USER ansible-user
ENV USER ansible-user

# for gum colors
ENV TERM xterm-256color

# get latest contents of dotfiles
RUN mkdir $HOME/git
COPY . $HOME/git/dotfiles
WORKDIR $HOME/git/dotfiles
USER root
RUN chown -R ansible-user:ansible-user $HOME

# add ansible user to sudoers file for pipelines
RUN echo "ansible-user ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/ansible-user > /dev/null

USER ansible-user
RUN echo /.dockerenv
RUN git config --global --add safe.directory '*'
# RUN git checkout eerie-fog
RUN chmod +x dotfiles.sh
RUN chmod +x .github/scripts/prepare

CMD $HOME/git/dotfiles/dotfiles.sh
