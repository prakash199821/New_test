FROM openjdk:11-jre-slim as build
ADD jarstaging/com/valaxy/demo-workshop/2.1.2/demo-workshop-2.1.2.jar ttrend.jar 
ENTRYPOINT [ "java", "-jar", "ttrend.jar" ]
