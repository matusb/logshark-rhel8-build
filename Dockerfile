#Build in redhat 8.10 image
FROM registry.access.redhat.com/ubi8/ubi:8.10 AS build
# workdirectory that will be mounted using -v option
# on Windows docker run -v C:/myfolder:/out my-image 
WORKDIR /out

# Install dotnet and git, create 
RUN dnf -y install dotnet-sdk-3.1 git && \
git clone https://github.com/tableau/Logshark.git . && \
dotnet publish "LogShark/LogShark.csproj" -r linux-x64 --self-contained false -c Release /p:Version=4.2.3 -o Logshark-4.2.3 && \
tar -cvzf /Logshark-4.2.3.tar.gz Logshark-4.2.3 


#copy the tar.gz archive in redhat 8.10 (doesn't matter, using the same image) image
FROM registry.access.redhat.com/ubi8/ubi:8.10
WORKDIR /out
COPY --from=build /Logshark-4.2.3.tar.gz / 
CMD ["cp", "/Logshark-4.2.3.tar.gz", "/out"]
