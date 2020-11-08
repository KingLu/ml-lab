FROM continuumio/anaconda3:2020.07

#docker build -t u2509/mllab .
#docker run -d -it -p 8000:8000  u2509/mllab

COPY conda/condarc /root/.condarc
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


RUN apt-get update --fix-missing && apt-get install -y wget curl vim \
    git subversion &&\
    clean-layer.sh


RUN \
    pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple &&\
    conda install nodejs=10.13.0 &&\
    npm config set registry https://registry.npm.taobao.org/ &&\
    npm install -g configurable-http-proxy &&\
    conda install -c conda-forge jupyterhub &&\
    conda install -c conda-forge jupyterlab &&\
    mkdir -p /opt/jupyterhub/config &&\
    clean-layer.sh
COPY conda/jupyterhub_config.py /opt/jupyterhub/config/jupyterhub_config.py 

RUN \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager &&\    
    jupyter labextension install @jupyterlab/toc &&\ 
    jupyter labextension install @aquirdturtle/collapsible_headings &&\
    jupyter labextension install @krassowski/jupyterlab_go_to_definition &&\    
    jupyter labextension install @lckr/jupyterlab_variableinspector &&\    
    clean-layer.sh

RUN \
    conda install -c conda-forge jupyterlab-git &&\
    jupyter labextension install neptune-notebooks &&\
    jupyter labextension install @jupyterlab/github &&\
    clean-layer.sh

RUN \
    jupyter labextension install jupyterlab-spreadsheet &&\
    clean-layer.sh

RUN \
    pip install jupyterlab_sql &&\
    jupyter serverextension enable jupyterlab_sql --py --sys-prefix &&\
    jupyter lab build &&\
    clean-layer.sh

RUN \
    pip install pyecharts &&\
    pip install --upgrade python-gitlab &&\
    clean-layer.sh

RUN \
    conda install -c conda-forge xgboost &&\
    conda install -c conda-forge lightgbm &&\
    clean-layer.sh

RUN \
    conda install -c conda-forge ipympl  &&\
    jupyter lab build &&\
    clean-layer.sh

COPY scripts/users_list.txt /tmp/users_list.txt
RUN newusers /tmp/users_list.txt &&\
    clean-layer.sh

EXPOSE 8000
ENTRYPOINT [ "jupyterhub_init.sh" ]