FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 7089
ENV ASPNETCORE_URLS=https://+:7089

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY . .

FROM build AS publish
RUN dotnet publish "HajUsput/HajUsput.csproj" -c Release -o /app
FROM base AS final
WORKDIR /app
COPY --from=publish /app .
COPY hajUsput.ML/MLModels/PricePredictionModel.zip /app/MLModels/PricePredictionModel.zip

ENTRYPOINT ["dotnet","HajUsput.dll"]