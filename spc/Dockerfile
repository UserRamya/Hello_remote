FROM amazoncorretto:11-alpine3.17
LABEL author = "RAMYA"
LABEL Reason = "LEARNINGpurpose"
RUN adduser -h /petclinic -s /bin/sh -D petclinic
USER petclinic
WORKDIR petclinic
ADD  https://referenceapplicationskhaja.s3.us-west-2.amazonaws.com/spring-petclinic-2.4.2.jar 
EXPOSE 8080
CMD ["java", "-jar", "/spring-petclinic-2.4.2.jar"]

# FROM amazoncorretto:11
# LABEL author = "RAMYA"
# LABEL organization="learningthoughts"
# RUN 
# RUN curl -fsSL https://referenceapplicationskhaja.s3.us-west-2.amazonaws.com/spring-petclinic-2.4.2.jar 
# EXPOSE 8080
# CMD ["java", "-jar", "/spring-petclinic-2.4.2.jar"]