# build the image in the same folder with the Dockerfile
docker build . -t lsbuild

# run the container (it will copy the file in to the current folder) 
# you may need to change the path on windows to something like -v "c:\output:/out"
docker run --rm -v "./:/out" lsbuild 

# (optional) delete the image from docker 
docker rmi lsbuild
