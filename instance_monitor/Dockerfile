FROM ubuntu:20.04
LABEL name="kyung ho"
LABEL email="crorowslowpp@gmail.com"

# download git
RUN apt-get update 
RUN apt install -y git
RUN git --version

# download flutter
WORKDIR /
RUN git clone -b stable https://github.com/flutter/flutter.git
RUN ls
RUN ls flutter/
RUN echo $PATH
RUN export PATH=$PATH:/flutter/bin
RUN echo $PATH
RUN flutter --version
RUN flutter upgrade

# build
WORKDIR /
COPY "." .
RUN flutter build web
RUN echo ${API_SERVER_PORT}

# install http server
RUN apt install -y python3 

# exectution
WORKDIR /build/web
EXPOSE 8000
CMD ["python3","-u","-m","http.server"]
