FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

RUN curl --silent --location https://deb.nodesource.com/setup_19.x | bash - \
&& apt-get install -y nodejs \
&& npm update -g npm 

COPY ./src .
RUN dotnet restore

WORKDIR /app
RUN dotnet publish -c release -o /out --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /out .
ENTRYPOINT ["dotnet", "conlang.dll"]