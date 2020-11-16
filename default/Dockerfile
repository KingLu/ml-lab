FROM u2509/mllab:micro

#docker build -t u2509/mllab:latest .
#docker run -d -it -p 8001:8000 --name ml-lab  u2509/mllab

RUN \
    conda install -c conda-forge xgboost &&\   
    clean-layer.sh    

RUN \
    cd /tmp  &&\   
    git clone https://github.com/matplotlib/matplotlib.git &&\   
    cp -r matplotlib/examples /home/u2509/matplotlib/examples &&\   
    cp -r matplotlib/tutorials /home/u2509/matplotlib/tutorials &&\   
    clean-layer.sh 

EXPOSE 8000
ENTRYPOINT [ "jupyterhub_init.sh" ]