FROM ubuntu:latest

RUN apt-get update && 
    apt-get full-upgrade -y

# install programs
RUN
    apt-get install -y \
    # gen utils
    sudo \
    # gen workflow
    screen \
    fish
    
# clean 
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash connor
RUN usermod -aG sudo connor
RUN echo 'connor:changeme' | chpasswd

USER connor
WORKDIR /home/connor

# Run a bash shell by default
CMD ["/bin/bash"]