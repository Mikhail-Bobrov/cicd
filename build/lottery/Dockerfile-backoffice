ARG JAVA_VERSION
FROM ${JAVA_VERSION}

RUN mkdir -p /lwo && mkdir -p /wrapper && mkdir -p /app
WORKDIR /app

COPY lottery/backoffice/build/libs/* /app
COPY lottery/encryption/src/main/native/libs/* /lwo/
COPY lottery/encryption/src/main/native/libLwoWrapper.so /wrapper/

CMD ["bash", "-c", "java --enable-preview -XX:NativeMemoryTracking=summary -XX:MinRAMPercentage=70 -XX:MaxRAMPercentage=70 -jar backoffice*.jar"]
