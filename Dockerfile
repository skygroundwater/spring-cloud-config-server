FROM openjdk:17 as build
LABEL maintainer="Oleg Metelev <o.metelev2020@yandex.ru>"
WORKDIR spring-cloud-confid-server
COPY target/*.jar app.jar
RUN java -Djarmode=layertools -jar app.jar extract

FROM openjdk:17
WORKDIR spring-cloud-confid-server
COPY --from=build spring-cloud-confid-server/dependencies/ ./
COPY --from=build spring-cloud-confid-server/spring-boot-loader/ ./
COPY --from=build spring-cloud-confid-server/snapshot-dependencies/ ./
COPY --from=build spring-cloud-confid-server/application/ ./

ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]