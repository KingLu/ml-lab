FROM u2509/mllab:micro

#docker build -t u2509/mllab:ml .
#docker run -d -it -p 8003:8000  u2509/mllab:ml ml-lab-data

RUN \
    conda install -c conda-forge tensorflow &&\   
    clean-layer.sh   

EXPOSE 8000
ENTRYPOINT [ "jupyterhub_init.sh" ]