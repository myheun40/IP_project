#springboot dockerfile

# Build stage
FROM gradle:7.6.1-jdk17 AS builder
WORKDIR /app
COPY . .
RUN gradle bootJar -x test  # Spring Boot 애플리케이션 빌드
# RUN gradle build -x test

# Run stage
FROM openjdk:17-slim
WORKDIR /app

# 빌드 결과물 복사
COPY --from=builder /app/build/libs/*.jar app.jar

## 환경변수 설정 (필요한 경우)
#ENV TZ=Asia/Seoul

# 포트 설정
EXPOSE 8081

# 실행 명령
ENTRYPOINT ["java", "-jar", "app.jar"]