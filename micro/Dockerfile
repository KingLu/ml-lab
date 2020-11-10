FROM u2509/mllab:base

#docker build -t u2509/mllab:micro .
#docker run -d -it -p 8003:8000  u2509/mllab:micro ml-lab-data

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

EXPOSE 8000
ENTRYPOINT [ "jupyterhub_init.sh" ]