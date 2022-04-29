#######################################################################################################################################
# Anthony E. Nocentino
# aen@centinosystems.com
# Docker Desktop is required for these demos - https://www.docker.com/products/docker-desktop 
#######################################################################################################################################
#This is our simple hello world web app and will be included in the downloads.
ls -ls ./webapp


#Step 1 - Build our web app first and test it prior to putting it in a container
dotnet build ./webapp
dotnet run --project ./webapp #Open a new terminal to test.
curl http://localhost:5000


#Step 2 - Let's publish a local build...this is what will be copied into the container
dotnet publish -c Release ./webapp


#Step 3 - Time to build the container and tag it...the build is defined in the Dockerfile
docker build -t webappimage:v1 .


#Step 4 - Run the container locally and test it out
docker run --name webapp --publish 8080:80 --detach webappimage:v1
curl http://localhost:8080


#Delete the running webapp container
docker stop webapp
docker rm webapp


#The image is still here...let's hold onto this for the next demo.
docker image ls webappimage:v1




#Pull a container, examine layers.
docker pull gcr.io/google-samples/hello-app:1.0
docker pull gcr.io/google-samples/hello-app:2.0


#list of images on this system
docker images
docker images | grep hello


#Check out the docker image details
docker image inspect gcr.io/google-samples/hello-app:2.0 | more
docker image inspect gcr.io/google-samples/hello-app:1.0


#Run a container
docker run \
    --name 'web1' \
    --publish 8080:8080 \
    --detach gcr.io/google-samples/hello-app:1.0

curl http://localhost:8080

#Finding help in docker
docker help run | more 


#Let's read the logs, useful if the container doesn't start up for some reason. 
docker logs web1 | more


#List running containers
docker ps


#Run a second container, new name, new port, same source image
docker run \
    --name 'web2' \
    --publish 8081:8080 \
    --detach gcr.io/google-samples/hello-app:1.0

curl http://localhost:8081


#List running containers
docker ps



#Connect to the container, start an interactive bash session
docker exec -it web1 /bin/sh


#Inside container, check out the process listing
ps -elf
exit


#Stopping a container
docker stop web2

#List running containers
docker ps

#List all containers, including stopped containers. Examine the status and the exit code
docker ps -a


#Starting a container that's already local. All the parameters from the docker run command persist.
docker start web2
docker ps


#Stop them containers...
docker stop web{1,2}
docker ps -a


#Stop all containers
#docker stop $(docker ps -a -q)


#Removing THE Container...THIS WILL DELETE YOUR DATA IN THE CONTAINER
docker rm web{1,2}


#Remove all containers
#docker rm $(docker ps -a -q)


#Even though the containers are gone, we still have the image!
docker image ls | grep hello-app 
docker ps -a

