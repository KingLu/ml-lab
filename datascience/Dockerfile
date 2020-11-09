FROM u2509/mllab

#docker build -t u2509/mllab:datasci-3.6 .
#docker run -d -it -p 8001:8000  u2509/mllab ml-lab-data

RUN \
    conda create --name dataScience36 python=3.6 &&\
    conda create -n jupyterhub36 --clone dataScience36  &&\
    clean-layer.sh

SHELL ["conda", "run", "-n", "dataScience36", "/bin/bash", "-c"]

RUN \     
    pip install ipykernel &&\
    python -m ipykernel install --name dataScience36 &&\
    clean-layer.sh

EXPOSE 8000
ENTRYPOINT [ "jupyterhub_init.sh" ]