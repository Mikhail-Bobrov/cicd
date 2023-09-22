ARG JAVA_VERSION
FROM ${JAVA_VERSION} as BUILDER

COPY . /root/
RUN apt-get update && apt-get install -y python virtualenv make g++
RUN cd /root/lottery && ./gradlew build -x test

FROM ${JAVA_VERSION}

RUN mkdir -p /lwo && mkdir -p /wrapper && mkdir -p /app
WORKDIR /app

COPY --from=BUILDER /root/lottery/backoffice/build/libs/* /app
COPY --from=BUILDER /root/lottery/encryption/src/main/native/libs/* /lwo/
COPY --from=BUILDER /root/lottery/encryption/src/main/native/libLwoWrapper.so /wrapper/

CMD ["bash", "-c", "java --enable-preview -XX:NativeMemoryTracking=summary -XX:MinRAMPercentage=70 -XX:MaxRAMPercentage=70 -jar backoffice*.jar"]
