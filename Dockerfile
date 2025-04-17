FROM eclipse-temurin:21-jdk AS build

WORKDIR /app
COPY . .
COPY settings.xml /root/.m2/settings.xml  

RUN chmod +x mvnw && \
    ./mvnw -B --version && \             # Debug: ver versión de Maven
    ./mvnw -B package -DskipTests && \
    ls -la target/ && \                  # Debug: lista archivos generados
    mv target/*.jar app.jar

FROM eclipse-temurin:21-jre
ARG PORT=8080
ENV PORT=${PORT}
COPY --from=build /app/app.jar .
EXPOSE ${PORT}
ENTRYPOINT ["java", "-Dserver.port=${PORT}", "-jar", "app.jar"]