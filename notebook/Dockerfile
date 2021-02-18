FROM jupyter/datascience-notebook

#docker build -t u2509/mllab-notebook:bjabc  ./notebook
#docker run -d -it -p 8000:8000  u2509/mllab:base

RUN \
    pip install -U pip setuptools 
    
RUN \
    pip install -U pyecharts &&\
    pip install -U python-gitlab &&\
    pip install -U pycrypto  &&\
    pip install -U pycryptodome &&\
    rm -rf "${HOME}/.local"