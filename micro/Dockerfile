FROM u2509/mllab:base

#docker build -t u2509/mllab:micro -f micro/Dockerfile .
#docker push u2509/mllab:micro
#docker run -d -it -p 8002:8000 --name ml-lab-micro  u2509/mllab:micro 
RUN \
    pip install -U pip setuptools &&\
    clean-layer.sh
    
RUN apt-get update --fix-missing && apt-get install -y build-essential python3-dev &&\
    clean-layer.sh

RUN \
    conda install -n base -c conda-forge jupyterlab_widgets  &&\  
    conda install -n base -c conda-forge ipywidgets  &&\  
    clean-layer.sh


RUN \
    pip install -U jupyterlab-git &&\ 
    pip install -U jupyter_contrib_nbextensions &&\     
    clean-layer.sh

RUN \
    pip install -U jupyterlab-language-pack-zh-CN &&\     
    clean-layer.sh

RUN \
    jupyter nbextension enable --py widgetsnbextension

EXPOSE 8000
ENTRYPOINT [ "jupyterhub_init.sh" ]