FROM ubuntu:16.04


RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install build-essential
RUN apt-get -y install git vim curl wget xvfb unzip
RUN apt-get -y install libpq-dev apt-transport-https
RUN apt-get -y install zlib1g-dev \
                       libssl-dev \
                       libreadline-dev \
                       libyaml-dev \
                       libxml2-dev \
                       libxslt-dev \
                       libncurses5-dev \
                       libncursesw5-dev
#                       rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
#    dpkg -i google-chrome*.deb || apt-get update && apt-get install -f -y && \
#    rm google-chrome-stable_current_amd64.deb && \
#    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' \
  && apt-get update && apt-get install -y google-chrome-stable

#RUN CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
#    mkdir -p /opt/chromedriver-$CHROMEDRIVER_VERSION && \
#    curl -sS -o /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
#    unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver-$CHROMEDRIVER_VERSION && \
#    chmod +x /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver && \
#    ln -fs /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/bin/chromedriver && \
#    rm /tmp/chromedriver_linux64.zip

# Chromedriver
RUN CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` \
  && mkdir -p /opt/chromedriver-$CHROMEDRIVER_VERSION \
  && curl -sS -o /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip \
  && unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver-$CHROMEDRIVER_VERSION \
  && rm /tmp/chromedriver_linux64.zip \
  && chmod +x /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver \
  && ln -fs /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/local/bin/chromedriver

# Anaconda3
RUN ANACONDA_VERSION=5.1.0 \
&& curl -L https://repo.continuum.io/archive/Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh \
                                            -o Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh \
\
&& /bin/bash Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh -b -p /usr/local/anaconda3 \
&& ln -s /usr/local/anaconda3/ /opt/anaconda3 \
&& rm Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh


#RUN mkdir -p /opt/selenium && \
#    curl -sS https://selenium-release.storage.googleapis.com/3.3/selenium-server-standalone-3.3.1.jar -o /opt/selenium/selenium-server-standalone.jar

ENV DISPLAY :99
ENV CHROME_BIN /usr/bin/google-chrome
ENV PATH=/opt/anaconda3/bin:$PATH
# Jupyter Notebook port
EXPOSE 8888

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

#RUN adduser --gecos "" --disabled-password pytorch
#USER pytorch:pytorch
#USER root:root

ENTRYPOINT ["/entrypoint.sh"]
