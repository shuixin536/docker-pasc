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
  net-tools \
  git

# 配置中文语言
ENV LANGUAGE zh_CN.UTF-8
ENV LANG zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8
RUN /usr/share/locales/install-language-pack zh_CN \
  && locale-gen zh_CN.UTF-8 \
  && dpkg-reconfigure --frontend noninteractive locales \
  && apt-get -qqy --no-install-recommends install language-pack-zh-hans

#===================
# Timezone settings
# Possible alternative: https://github.com/docker/docker/issues/3359#issuecomment-32150214
#===================
ENV TZ "Asia/Shanghai"
RUN echo "${TZ}" > /etc/timezone \
  && dpkg-reconfigure --frontend noninteractive tzdata

# 安装基本字体
RUN apt-get -qqy --no-install-recommends install \
    fonts-ipafont-gothic \
    xfonts-100dpi \
    xfonts-75dpi \
    xfonts-cyrillic \
    xfonts-scalable

# 安装文泉驿微米黑字体
RUN apt-get -qqy install ttf-wqy-microhei \
  && ln /etc/fonts/conf.d/65-wqy-microhei.conf /etc/fonts/conf.d/69-language-selector-zh-cn.conf

# 设置时区
ENV TZ "PRC"
RUN echo "Asia/Shanghai" | tee /etc/timezone \
  && dpkg-reconfigure --frontend noninteractive tzdata

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
