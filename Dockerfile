# borrowed from https://github.com/kelvich/tlaplus_jupyter/blob/master/Dockerfile
FROM adoptopenjdk:14-jdk-hotspot

RUN apk add --update gcc libc-dev zeromq-dev python3-dev linux-headers

ARG NB_USER=nb_user
ARG NB_UID=1000
ENV NB_USER ${NB_USER}
ENV NB_UID ${NB_UID}
RUN addgroup ${NB_USER} && adduser -D -G ${NB_USER} -u ${NB_UID} ${NB_USER}
COPY . /home/${NB_USER}
RUN chown -R ${NB_USER} /home/${NB_USER}

RUN pip3 install tlaplus_jupyter
RUN python3 -m tlaplus_jupyter.install

USER ${NB_USER}
WORKDIR /home/${NB_USER}
CMD ["jupyter", "notebook", "--ip", "0.0.0.0"]
