FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 58598
EXPOSE 44301

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY ["MicroService.Api/MicroService.Api.csproj", "MicroService.Api/"]
RUN dotnet restore "MicroService.Api/MicroService.Api.csproj"
COPY . .
WORKDIR "/src/MicroService.Api"
RUN dotnet build "MicroService.Api.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "MicroService.Api.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "MicroService.Api.dll"]