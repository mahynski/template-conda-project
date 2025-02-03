FROM continuumio/miniconda3:latest
RUN apt update

# Create a user with a given User and Group ID
# https://vsupalov.com/docker-shared-permissions/
ARG UID
ARG GID
RUN addgroup --gid $GID user
RUN adduser --disabled-password --gecos '' --uid $UID --gid $GID user

USER user
COPY conda-env.yml /
RUN conda env create -f conda-env.yml
