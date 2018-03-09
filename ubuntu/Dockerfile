FROM ubuntu:16.04

ENV BASEDIR /usr/src/app/bitdreams


RUN apt-get update && apt-get install -y wget bzip2 ca-certificates \
    curl \
    git \
    unzip \
    && \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/*

RUN mkdir -p $BASEDIR

# Anaconda3
RUN ANACONDA_VERSION=5.1.0 \
&& curl -L https://repo.continuum.io/archive/Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh \
                                            -o Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh \
\
&& /bin/bash Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh -b -p /opt/anaconda \
&& rm Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh
    
ENV PATH="/opt/anaconda/bin:${PATH}"

#RUN conda update anaconda && \
RUN	rm -rf /usr/bin/python && \
		ln -s /opt/anaconda/bin/python /usr/bin/python

# chronium
#RUN apt-get update && apt-get install -yq --no-install-recommends \
RUN install -y xvfb \
    chromium \
    libgconf-2-4
#    && apt-get clean && rm -rf /var/lib/apt/lists/*

ADD xvfb-chromium /usr/bin/xvfb-chromium
RUN ln -s /usr/bin/xvfb-chromium /usr/bin/google-chrome
RUN ln -s /usr/bin/xvfb-chromium /usr/bin/chromium-browser

# selenium
ADD requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# chromedriver
ENV CHROMEDRIVER_VERSION 2.29
ADD chromedriver_linux64.zip chromedriver_linux64.zip
RUN unzip "chromedriver_linux64.zip" -d /usr/local/bin \
  && rm "chromedriver_linux64.zip"
 


