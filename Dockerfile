# Stage 1: Build bằng Maven kết hợp với JDK 26 mới nhất để khớp với code của bạn
FROM maven:3.9.9-eclipse-temurin-26-noble AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Chạy ứng dụng bằng JRE 26 tinh gọn
FROM eclipse-temurin:26-jre-noble
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]