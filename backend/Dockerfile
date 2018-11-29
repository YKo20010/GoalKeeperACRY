FROM ubuntu:18.04

RUN apt-get update && apt-get install -y sudo curl python3 python3-pip git

RUN useradd -m -s /bin/bash vm-user
RUN usermod -aG sudo vm-user
RUN echo "vm-user ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers

COPY vm_init /tmp/vm_init

EXPOSE 5000
