docker stop bedjango
docker rm bedjango
docker build -t bedjango .
docker run --name bedjango -p 8000:8000 -d bedjango:latest