FROM continuumio/anaconda3:2020.07

RUN apt-get update
RUN apt-get install -y locales
RUN sed -ie 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/g' /etc/locale.gen
RUN locale-gen
ENV LANG zh_CN.UTF-8

RUN apt-get install -y ttf-wqy-zenhei xfonts-intl-chinese

RUN apt-get update --fix-missing && apt-get install -y wget curl vim bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

COPY conda/condarc /root/.condarc

RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

RUN conda install nodejs=10.13.0
RUN npm config set registry https://registry.npm.taobao.org/
RUN npm install -g configurable-http-proxy

RUN conda install -c conda-forge jupyterhub
RUN conda install -c conda-forge jupyterlab
RUN mkdir -p /opt/jupyterhub/config
COPY coda/jupyterhub_config.py /opt/jupyterhub/config/jupyterhub_config.py 



COPY jupyterhub_init.sh /usr/bin/jupyterhub_init.sh
RUN chmod 755 /usr/bin/jupyterhub_init.sh

ENTRYPOINT [ "/usr/bin/jupyterhub_init.sh", "--" ]
CMD [ "/bin/bash" ]