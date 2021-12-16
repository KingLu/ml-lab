FROM u2509/mllab:micro

#docker build -t u2509/mllab:bjabc -t u2509/mllab:bjabc20211216 -f local/Dockerfile .
#docker run -d -it -p 8000:8000  u2509/mllab:base
RUN \
    pip install -U sudospawner &&\
    clean-layer.sh

RUN \
    apt-get update &&\
    apt-get install -y zlib1g zip unzip &&\
    pip install -U pyminizip &&\
    clean-layer.sh     

RUN \
    conda create --name python310 python=3.10 &&\
    conda create --name python39 python=3.9 &&\    
    conda create --name python38 python=3.8 &&\
    conda create --name python36 python=3.6 &&\
    conda create --name python27 python=2.7 &&\
    clean-layer.sh

#Solve  matplotlib's Chinese character display problem
#font file form https://www.fontpalace.com/font-download/simhei/
COPY fonts/SimHei.ttf /opt/conda/lib/python3.8/site-packages/matplotlib/mpl-data/fonts/ttf/
COPY fonts/SimHei.ttf /opt/conda/lib/python3.9/site-packages/matplotlib/mpl-data/fonts/ttf/
COPY fonts/SimHei.ttf /opt/conda/lib/python3.10/site-packages/matplotlib/mpl-data/fonts/ttf/
COPY scripts/users_list.txt /tmp/users_list.txt
RUN newusers /tmp/users_list.txt &&\
    clean-layer.sh

EXPOSE 8000
ENTRYPOINT [ "jupyterhub_init.sh" ]
