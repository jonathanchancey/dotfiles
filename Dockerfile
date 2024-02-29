FROM opensuse/tumbleweed

USER root

RUN zypper ref && zypper dup --no-confirm

RUN zypper install --no-confirm \
    git \
    ansible \
    python311 \
    python311-pip \ 
    sudo

RUN useradd -m ansible-user

USER ansible-user
ENV HOME /home/ansible-user

RUN mkdir $HOME/git

# RUN git clone https://github.com/jonathanchancey/dotfiles $HOME/git/dotfiles
COPY . $HOME/git/dotfiles
WORKDIR $HOME/git/dotfiles
RUN echo /.dockerenv
RUN git config --global --add safe.directory '*'

ENV USER ansible-user

RUN git checkout eerie-fog

USER root

RUN ansible-playbook main.yml --tags system

ENV USER ansible-user

RUN ansible-playbook main.yml

ENTRYPOINT /bin/bash