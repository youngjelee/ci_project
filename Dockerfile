# 빌드 단계: Gradle 8.12와 JDK 21이 포함된 이미지를 사용
FROM gradle:8.12-jdk21 AS build
WORKDIR /app
# 전체 소스코드 복사 (gradle wrapper, build 파일 등 포함)
COPY --chown=gradle:gradle . .
# 애플리케이션 빌드 (테스트는 생략하여 빌드 시간 단축)
RUN ./gradlew bootJar --no-daemon -x test

# 실행 단계: 경량화된 Java 21 런타임 이미지 사용
FROM openjdk:21-slim
WORKDIR /app
# 빌드 산출물 복사 (build/libs 폴더에 생성된 fat jar)
COPY --from=build /app/build/libs/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
