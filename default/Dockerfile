FROM u2509/mllab:micro

#docker build -t u2509/mllab:latest .
#docker run -d -it -p 8001:8000 --name ml-lab  u2509/mllab

RUN \
    conda install -c conda-forge xgboost &&\   
    clean-layer.sh    

RUN \
    cd /tmp  &&\ 
    mkdir -p /opt/jupyterhub/ml01/matplotlib/doc &&\  
    git clone https://github.com/matplotlib/matplotlib.git &&\   
    cp -r matplotlib/examples /opt/jupyterhub/ml01/matplotlib/examples &&\   
    cp -r matplotlib/tutorials /opt/jupyterhub/ml01/matplotlib/tutorials &&\    
    cp -r matplotlib/doc/_static /opt/jupyterhub/ml01/matplotlib/doc/_static &&\  
    clean-layer.sh 

RUN \
    cd /tmp  &&\   
    git clone https://github.com/pyecharts/pyecharts-gallery.git &&\   
    cp -r pyecharts-gallery /opt/jupyterhub/ml01/pyecharts-gallery &&\
    rm /opt/jupyterhub/ml01/pyecharts-gallery/.git -rf  &&\
    rm /opt/jupyterhub/ml01/pyecharts-gallery/.github -rf  &&\
    clean-layer.sh     

EXPOSE 8000
ENTRYPOINT [ "jupyterhub_init.sh" ]