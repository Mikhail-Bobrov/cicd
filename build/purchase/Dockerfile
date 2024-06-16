ARG JAVA_VERSION
FROM ${JAVA_VERSION} as BUILDER

COPY . /root/
RUN cd /root/purchase-service && ./gradlew clean build  -DproductionMode=true -x test

FROM ${JAVA_VERSION}

RUN mkdir /app
WORKDIR /app

COPY --from=BUILDER /root/libs/ /app/

CMD ["bash", "-c", "java --enable-preview -XX:MinRAMPercentage=70 -XX:MaxRAMPercentage=70 -jar purchase-*.jar" ]