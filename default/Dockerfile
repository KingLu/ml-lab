FROM u2509/mllab:micro

#docker build -t u2509/mllab .
#docker run -d -it -p 8001:8000 --name ml-lab  u2509/mllab

RUN \
    conda install -c conda-forge xgboost &&\   
    clean-layer.sh    

EXPOSE 8000
ENTRYPOINT [ "jupyterhub_init.sh" ]