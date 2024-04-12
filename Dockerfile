#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.
FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:7.0-alpine3.18-arm64v8 AS build
ARG TARGETARCH
WORKDIR /src
COPY . .
RUN dotnet publish "./NitroBoostContentService.Web/NitroBoostContentService.Web.csproj" -a ${TARGETARCH} -c Release -o /app/publish

FROM build AS final
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
EXPOSE 8081
ENTRYPOINT ["dotnet", "NitroBoostContentService.Web.dll"]