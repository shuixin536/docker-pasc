FROM selenium/standalone-chrome-debug
MAINTAINER shuixin536 <shuixin536@gmail.com>

USER root

# Install wget and build-essential
RUN apt-get update && apt-get install -y \
  build-essential \
  wget \
  curl \
  vim \
  lrzsz \
  iputils-ping \
  git

##############################################################################
# anaconda python
##############################################################################
# Install Anaconda
RUN apt-get update && \
    apt-get install -y wget bzip2 ca-certificates

RUN ANACONDA_VERSION=5.1.0 \
&& curl -L https://repo.continuum.io/archive/Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh \
                                            -o Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh \
\
&& /bin/bash Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh -b -p /opt/conda \
&& rm Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh
    
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PATH="/opt/conda/bin:${PATH}"

RUN	rm -rf /usr/bin/python && \
		ln -s /opt/conda/bin/python /usr/bin/python
		
RUN pip install --upgrade pip

ADD requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

WORKDIR /home/seluser

EXPOSE 8000

USER seluser
