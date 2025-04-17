# Fase de construcción
FROM eclipse-temurin:21-jdk AS build

WORKDIR /app
COPY . .
RUN chmod +x mvnw && ./mvnw package -DskipTests
RUN mv target/*.jar app.jar

# Fase de ejecución
FROM eclipse-temurin:21-jre

ARG PORT=8081
ENV PORT=${PORT}

COPY --from=build /app/app.jar .

RUN useradd -m runtime
USER runtime

EXPOSE ${PORT}

ENTRYPOINT ["java", "-Dserver.port=${PORT}", "-jar", "app.jar"]