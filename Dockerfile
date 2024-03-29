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
    openssh \
    gum \
    vim

# # solve image-specific dependency problem by replacing busybox-which
RUN zypper install --no-confirm --force-resolution xdg-utils

# add insecure password
RUN echo "root:dotfiles" | chpasswd

# add ansible-user for real-world permissions
RUN useradd -m ansible-user
ENV HOME /home/ansible-user
RUN chown -R ansible-user:ansible-user $HOME

# add ansible user to sudoers file for pipelines
RUN echo "ansible-user ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/ansible-user > /dev/null

# switch to ansible-user
USER ansible-user
ENV USER ansible-user

# copy repo
RUN mkdir $HOME/git
COPY . $HOME/git/dotfiles
WORKDIR $HOME/git/dotfiles

# for gum colors
ENV TERM xterm-256color

# ensure scripts are executable
RUN sudo chmod +x dotfiles.sh
RUN sudo chmod +x .github/scripts/prepare

CMD ansible-playbook main.yml
