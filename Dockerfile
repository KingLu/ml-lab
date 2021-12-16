FROM continuumio/anaconda3:2021.11

#docker build -t u2509/mllab:base .
#docker push u2509/mllab:base
#docker run -d -it -p 8000:8000 --name ml-lab-base u2509/mllab:base

#COPY conda/condarc /root/.condarc
COPY scripts/clean_layer.sh /usr/bin/clean-layer.sh
COPY scripts/jupyterhub_init.sh /usr/bin/jupyterhub_init.sh

RUN \
    chmod 755 /usr/bin/jupyterhub_init.sh && \
    chmod 755 /usr/bin/clean-layer.sh 

RUN \
    apt-get update &&\
    apt-get install -y locales &&\
    sed -ie 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/g' /etc/locale.gen &&\
    locale-gen &&\
    clean-layer.sh

ENV LANG zh_CN.UTF-8


RUN apt-get update --fix-missing && apt-get install -y wget curl vim cron\
    git subversion &&\
    clean-layer.sh

RUN \  
    curl -sL https://deb.nodesource.com/setup_lts.x | bash - &&\
    apt-get install -y nodejs &&\    
    node --version &&\
    clean-layer.sh

RUN \
    npm config set registry https://registry.npm.taobao.org \
    npm --version  &&\   
    npm install npm@latest -g  &&\ 
    npm --version  &&\  
    npm install -g configurable-http-proxy &&\
    clean-layer.sh
    
RUN \
    pip install -U jupyterhub &&\
    pip install -U  jupyterlab &&\
    mkdir -p /opt/jupyterhub/config &&\
    clean-layer.sh
COPY conda/jupyterhub_config.py /opt/jupyterhub/config/jupyterhub_config.py 


RUN \
    pip install -U ipympl  &&\   
    clean-layer.sh

#Solve  matplotlib's Chinese character display problem
#font file form https://www.fontpalace.com/font-download/simhei/
COPY fonts/SimHei.ttf /opt/conda/lib/python3.8/site-packages/matplotlib/mpl-data/fonts/ttf/
COPY fonts/SimHei.ttf /opt/conda/lib/python3.9/site-packages/matplotlib/mpl-data/fonts/ttf/
COPY scripts/users_list.txt /tmp/users_list.txt
RUN newusers /tmp/users_list.txt &&\
    clean-layer.sh

EXPOSE 8000
ENTRYPOINT [ "jupyterhub_init.sh" ]