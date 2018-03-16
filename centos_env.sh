
yum install bzip2
#yum groupinstall 'Development Tools' -y

ANACONDA_VERSION=5.1.0 

curl -L https://repo.continuum.io/archive/Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh -o Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh 

/bin/bash Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh -b -p /opt/conda

rm Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh

export PATH="/opt/conda/bin:${PATH}"

mv /usr/bin/python /usr/bin/python_old
ln -s /opt/conda/bin/python /usr/bin/python

