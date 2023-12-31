docker build -t whanos .
docker run -v /var/run/docker.sock:/var/run/docker.sock -p 8080:8080 -p 50001:50000 -it whanos