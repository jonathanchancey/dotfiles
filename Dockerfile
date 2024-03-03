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

# install gum
RUN zypper install --no-confirm gum
RUN zypper install --no-confirm vim

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
USER ansible-user
RUN echo /.dockerenv
RUN git config --global --add safe.directory '*'
# RUN git checkout eerie-fog
RUN chmod +x dotfiles.sh

CMD $HOME/git/dotfiles/dotfiles.sh


# disabled for testing gum
# # add ansible-user to sudoers
# USER root
# # used in ansible for setting sudoers correctly

# ENV ANSIBLE_LOCAL_TEMP /root/.ansible/tmp

# RUN ansible-playbook main.yml --tags system

# # fix home and tmp dir permissions
# RUN mkdir -p $HOME/.ansible/tmp && \
#     chown -R ansible-user:ansible-user $HOME

# # solve image-specific dependency problem by replacing busybox-which
# RUN zypper install --no-confirm --force-resolution xdg-utils

# # main playbook testing
# USER ansible-user
# ENV ANSIBLE_LOCAL_TEMP $HOME/.ansible/tmp
# # RUN ansible-playbook main.yml --tags 'bash,neovim,ranger,fish'
# RUN ansible-playbook main.yml

# ENTRYPOINT /usr/bin/fish
