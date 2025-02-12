# Stage 1: Build the JAR
FROM openjdk:17 AS build
WORKDIR /app
COPY . . 
RUN ./mvnw clean package -DskipTests  # If using a wrapper
# OR: RUN mvn clean package -DskipTests  # If using system-installed Maven

# Stage 2: Create the final image
FROM openjdk:17
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
