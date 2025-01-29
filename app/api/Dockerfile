FROM gradle:7 AS base
CMD ["bash"]

FROM base AS test_build
WORKDIR /app
COPY . .
# テストも実行されている
RUN ./gradlew build

FROM openjdk:17 AS prod
COPY --from=test_build /app/build/libs/api-0.0.1-SNAPSHOT.jar /app/api.jar
CMD ["java", "-jar", "/app/api.jar"]
