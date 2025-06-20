FROM curlimages/curl:8.13.0 AS download
ARG OTEL_AGENT_VERSION="2.16.0"
RUN curl --silent --fail --insecure -L "https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v${OTEL_AGENT_VERSION}/opentelemetry-javaagent.jar" \
    -o "$HOME/opentelemetry-javaagent.jar"

FROM maven:3-amazoncorretto-24-alpine AS build
WORKDIR /build
COPY . .
RUN mvn clean package -DskipTests --quiet

FROM openjdk:21-jdk
COPY --from=build /build/target/*.jar /demo-0.0.1-SNAPSHOT.jar
COPY --from=download /home/curl_user/opentelemetry-javaagent.jar /opentelemetry-javaagent.jar
ENTRYPOINT ["java", \
  "-javaagent:/opentelemetry-javaagent.jar", \
  "-jar", "/demo-0.0.1-SNAPSHOT.jar" \
  ]
