ARG JAVA_VERSION
FROM ${JAVA_VERSION} as BUILDER

COPY . /root/
RUN cd /root/external-integrations && ./gradlew build -x test

FROM ${JAVA_VERSION}

RUN mkdir /app
WORKDIR /app

COPY --from=BUILDER /root/external-integrations/build/libs/ /app/

CMD ["bash", "-c", "java -XX:NativeMemoryTracking=summary --enable-preview -XX:MinRAMPercentage=70 -XX:MaxRAMPercentage=70 -jar external-*.jar"]