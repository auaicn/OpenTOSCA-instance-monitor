FROM ubuntu:20.04
LABEL name="kyung ho"
LABEL email="crorowslowpp@gmail.com"
RUN apt-get update -y
RUN apt install -y python3
WORKDIR /static
COPY "build/web" .
EXPOSE 8000
CMD ["python3","-u","-m","http.server"]
