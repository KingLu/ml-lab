FROM u2509/mllab:base

#docker build -t u2509/mllab:micro .
#docker run -d -it -p 8002:8000 --name ml-lab-micro  u2509/mllab:micro 

RUN \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager &&\    
    jupyter labextension install @jupyterlab/toc &&\ 
    jupyter labextension install @aquirdturtle/collapsible_headings &&\
    jupyter labextension install @krassowski/jupyterlab_go_to_definition &&\    
    jupyter labextension install @lckr/jupyterlab_variableinspector &&\ 
    jupyter labextension install jupyterlab-spreadsheet &&\   
    clean-layer.sh

RUN \
    conda install -c conda-forge jupyterlab-git &&\ 
    jupyter lab build &&\  
    clean-layer.sh


EXPOSE 8000
ENTRYPOINT [ "jupyterhub_init.sh" ]