FROM mcr.microsoft.com/dotnet/core/aspnet:3.1

RUN mkdir /app
WORKDIR /app

COPY ./webapp/bin/Release/netcoreapp3.1/publish ./

EXPOSE 80
ENTRYPOINT ["dotnet", "webapp.dll"]