FROM continuumio/anaconda3:2020.07

#docker build -t u2509/mllab:base -t u2509/mllab:yyyymmdd .
#docker run -d -it -p 8000:8000  u2509/mllab:base

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


RUN apt-get update --fix-missing && apt-get install -y wget curl vim \
    git subversion &&\
    clean-layer.sh

RUN \
    curl -sL https://deb.nodesource.com/setup_lts.x | bash - &&\
    apt-get install -y nodejs &&\
    clean-layer.sh

RUN \
    conda update conda &&\
    conda update anaconda &&\
    clean-layer.sh

RUN \          
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
    clean-layer.sh

RUN \
    conda install -c conda-forge ipympl  &&\
    jupyter lab build &&\
    clean-layer.sh

RUN \
    conda create --name python39 python=3.9 &&\
    conda create --name python27 python=2.7 &&\
    conda create --name python38 python=3.8 &&\
    conda create --name python36 python=3.6 &&\
    clean-layer.sh

#Solve  matplotlib's Chinese character display problem
#font file form https://www.fontpalace.com/font-download/simhei/
COPY fonts/SimHei.ttf /opt/conda/lib/python3.8/site-packages/matplotlib/mpl-data/fonts/ttf/
COPY scripts/users_list.txt /tmp/users_list.txt
RUN newusers /tmp/users_list.txt &&\
    clean-layer.sh

EXPOSE 8000
ENTRYPOINT [ "jupyterhub_init.sh" ]