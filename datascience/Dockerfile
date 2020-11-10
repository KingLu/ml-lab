FROM u2509/mllab:micro

#docker build -t u2509/mllab:datasci-3.8 .
#docker run -d -it -p 8001:8000  u2509/mllab:datasci-3.8 ml-lab-data

RUN \
    conda install -c conda-forge lightgbm &&\   
    clean-layer.sh    

EXPOSE 8000
ENTRYPOINT [ "jupyterhub_init.sh" ]