# Use the LinuxServer Kali image which has KasmVNC built-in
FROM lscr.io/linuxserver/kali-linux:latest

# Set environment to non-interactive to avoid prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Install your requested tools + dependencies for GUI apps
RUN apt-get update && apt-get install -y \
    nmap \
    metasploit-framework \
    burpsuite \
    wireshark \
    mousepad \
    iputils-ping \
    curl \
    && apt-get clean

# Pre-configure Wireshark to allow non-root users to capture packets
RUN echo "wireshark-common wireshark-common/install-setuid boolean true" | debconf-set-selections \
    && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure wireshark-common

# Expose the KasmVNC port
EXPOSE 3000