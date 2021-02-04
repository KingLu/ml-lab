FROM u2509/mllab:base

#docker build -t u2509/mllab:bjabc -t u2509/mllab:bjabc20210204 ./local
#docker run -d -it -p 8000:8000  u2509/mllab:base

RUN \
    pip install jupyterlab_sql &&\
    jupyter serverextension enable jupyterlab_sql --py --sys-prefix &&\
    jupyter lab build &&\
    clean-layer.sh

RUN \
    pip install -U pyecharts &&\
    pip install -U python-gitlab &&\
    pip install -U pycrypto  &&\
    pip install -U pycryptodome  &&\
    clean-layer.sh

RUN \
    pip install -U pywpsrpc  &&\
    pip install -U docx-mailmerge  &&\
    pip install -U python-docx &&\
    clean-layer.sh

RUN \
    conda install -c conda-forge xgboost &&\
    clean-layer.sh

RUN \
    conda install -c conda-forge ipympl  &&\
    jupyter lab build &&\
    clean-layer.sh

#Libraries for Data Visualization
RUN \
    pip install -U seaborn &&\
    pip install -U plotly &&\
    pip install -U bokeh &&\
    pip install -U altair &&\
    pip install -U folium  &&\
    pip install -U ggplot &&\
    clean-layer.sh

RUN \
    conda create --name python39 python=3.9 &&\
    conda create --name python27 python=2.7 &&\
    conda create --name python38 python=3.8 &&\
    conda create --name python36 python=3.6 &&\
    clean-layer.sh

#Solve  matplotlib's Chinese character display problem
#font file form https://www.fontpalace.com/font-download/simhei/
COPY fonts/SimHei.ttf /opt/conda/lib/python3.8/site-packages/matplotlib/mpl-data/fonts/ttf/
COPY scripts/users_list.txt /tmp/users_list.txt
RUN newusers /tmp/users_list.txt &&\
    clean-layer.sh

EXPOSE 8000
ENTRYPOINT [ "jupyterhub_init.sh" ]