FROM jupyter/minimal-notebook

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends libzmq3-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR ~/jupyter
RUN mkdir -p ~/.ipython/kernels/nodejs/
COPY jupyter-nodejs ~/jupyter/jupyter-nodejs

WORKDIR ~/jupyter/jupyter-nodejs
RUN npm install && node install.js
RUN npm run build
RUN npm run build-ext


# VOLUME /notebooks
WORKDIR /notebooks

EXPOSE 8888

CMD jupyter notebook
