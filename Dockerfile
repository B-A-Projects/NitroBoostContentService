#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["NitroBoostContentService.Web/NitroBoostContentService.Web.csproj", "NitroBoostContentService.Web/"]
COPY ["NitroBoostContentService.Core/NitroBoostContentService.Core.csproj", "NitroBoostContentService.Core/"]
COPY ["NitroBoostContentService.Data/NitroBoostContentService.Data.csproj", "NitroBoostContentService.Data/"]
COPY ["NitroBoostContentService.Shared/NitroBoostContentService.Shared.csproj", "NitroBoostContentService.Shared/"]
RUN dotnet restore "NitroBoostContentService.Web/NitroBoostContentService.Web.csproj"
COPY . .
WORKDIR "/src/NitroBoostContentService.Web"
RUN dotnet build "NitroBoostContentService.Web.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "NitroBoostContentService.Web.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "NitroBoostContentService.Web.dll"]