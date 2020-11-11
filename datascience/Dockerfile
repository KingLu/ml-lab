FROM u2509/mllab:micro

#docker build -t u2509/mllab:dt .
#docker run -d -it -p 8001:8000 --name ml-lab-dt  u2509/mllab:dt 

RUN \
    conda install -c conda-forge lightgbm &&\   
    clean-layer.sh    

EXPOSE 8000
ENTRYPOINT [ "jupyterhub_init.sh" ]