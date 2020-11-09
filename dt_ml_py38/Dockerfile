FROM u2509/mllab:base

#docker build -t u2509/mllab:dt-ml-py3.8 .
#docker run -d -it -p 8003:8000  u2509/mllab:dt-ml-py3.8 ml-lab-data

RUN \    
    conda create -n dataScience38 --clone python38  &&\
    clean-layer.sh

SHELL ["conda", "run", "-n", "dataScience38", "/bin/bash", "-c"]

RUN \     
    pip install ipykernel &&\
    conda install -c conda-forge lightgbm &&\
    python -m ipykernel install --name dataScience38 &&\
    clean-layer.sh

RUN \    
    conda create -n machinelearning38 --clone python38  &&\
    clean-layer.sh

SHELL ["conda", "run", "-n", "machinelearning38", "/bin/bash", "-c"]

RUN \     
    pip install ipykernel &&\
    conda install -c conda-forge lightgbm &&\
    python -m ipykernel install --name machinelearning38 &&\
    clean-layer.sh


EXPOSE 8000
ENTRYPOINT [ "jupyterhub_init.sh" ]