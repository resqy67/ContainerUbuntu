# Use Ubuntu image as base
FROM ubuntu:latest

# Update the package information
RUN apt-get update && apt-get upgrade -y && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget vi nano net-tools

# Install openssh-server to enable ssh access
RUN apt-get install -y openssh-server

# Set root password
RUN echo "root:student" | chpasswd

# Configure openssh-server
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Expose ssh port
EXPOSE 22

# Start ssh service
CMD ["/usr/sbin/sshd", "-D"]
