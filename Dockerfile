FROM continuumio/anaconda3


# chronium
RUN apt-get update && apt-get install -yq --no-install-recommends \
    unzip \
    xvfb \
    chromium \
    libgconf-2-4 \
    git \
    ca-certificates \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ADD xvfb-chromium /usr/bin/xvfb-chromium
RUN ln -s /usr/bin/xvfb-chromium /usr/bin/google-chrome
RUN ln -s /usr/bin/xvfb-chromium /usr/bin/chromium-browser

# selenium
ADD requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# chromedriver
ENV CHROMEDRIVER_VERSION 2.29
ENV CHROMEDRIVER_SHA256 bb2cf08f2c213f061d6fbca9658fc44a367c1ba7e40b3ee1e3ae437be0f901c2

RUN curl -SLO "https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip" 
RUN echo "$CHROMEDRIVER_SHA256  chromedriver_linux64.zip" | sha256sum -c -

RUN unzip "chromedriver_linux64.zip" -d /usr/local/bin \
  && rm "chromedriver_linux64.zip"
 
CMD ["/bin/bash"]

