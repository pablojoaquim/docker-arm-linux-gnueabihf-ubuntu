FROM ubuntu:20.04

# Installing the necessary software
RUN apt-get update && apt-get install -y --no-install-recommends \
        flex bison wget \
        libncurses5-dev \ 
        libncursesw5-dev \
        lib32z1-dev \
        lzop \
        libssl-dev \
        util-linux \
        kpartx \
        dosfstools \
        e2fsprogs \
        ca-certificates \
        xz-utils \
        make \
        file \
        gcc g++ patch cpio unzip rsync bc perl \
        libglib2.0-dev \
        git \
        fakeroot \
        curl \
        python

RUN apt-get autoremove -y; sudo apt-get clean; rm -rf /var/lib/apt/lists/*; rm /var/log/alternatives.log /var/log/apt/*; rm /var/log/* -r;

# Cross-Compiler installation
RUN GCCARM_LINK="https://releases.linaro.org/components/toolchain/binaries/6.4-2018.05/arm-linux-gnueabihf/gcc-linaro-6.4.1-2018.05-x86_64_arm-linux-gnueabihf.tar.xz" && \
    wget -O /tmp/gcc-linaro-x86_64_arm-linux-gnueabihf.tar.xz -c ${GCCARM_LINK} && \
    tar xf /tmp/gcc-linaro-x86_64_arm-linux-gnueabihf.tar.xz -C /opt/ && \ 
    rm -rf /tmp/gcc-linaro-x86_64_arm-linux-gnueabihf.tar.xz && \
    mv /opt/gcc-linaro-6.4.1-2018.05-x86_64_arm-linux-gnueabihf/ /opt/gcc-arm-linux

# Now is necessary to modify the .bashrc located in our user directory to let the tool be permanently available.
RUN cd ~ && \
    echo "export PATH=$PATH:/opt/gcc-arm-linux/bin" >> .bashrc 

RUN export FORCE_UNSAFE_CONFIGURE=1

# After installing the compiler you can verify it using the following command
#RUN arm-linux-gnueabihf-gcc --version
