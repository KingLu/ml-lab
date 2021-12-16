# ml-lab
This a docker image for machine learning and data science.

## docker-hub
The docker hub url is [https://hub.docker.com/repository/docker/u2509/mllab](https://hub.docker.com/repository/docker/u2509/mllab)
### docker tags
**base**  
FROM continuumio/anaconda3:2021.11  
install wget curl vim    
jupyterhub jupyterlab pyecharts python-gitlab ipympl  
**micro**   
FROM u2509/mllab:base  
install jupyter labextensions,include   
```
    jupyter labextension install @jupyter-widgets/jupyterlab-manager &&\    
    jupyter labextension install @jupyterlab/toc &&\ 
    jupyter labextension install @aquirdturtle/collapsible_headings &&\
    jupyter labextension install @krassowski/jupyterlab_go_to_definition &&\    
    jupyter labextension install @lckr/jupyterlab_variableinspector &&\   
    conda install -c conda-forge jupyterlab-git &&\
    jupyter labextension install neptune-notebooks &&\
    jupyter labextension install @jupyterlab/github &&\
    jupyter labextension install jupyterlab-spreadsheet
```   
## how to use
1. create container
`docker run -d -it -p 8001:8000 --name ml-lab  u2509/mllab`
1. use the system  
http://127.0.0.1:8001  
>**user**:ml01  
>**password**:ml01@ml

