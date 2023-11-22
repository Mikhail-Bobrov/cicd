ARG JAVA_VERSION
FROM ${JAVA_VERSION} as BUILDER

COPY . /root/
RUN cd /root/sequence-hash-verifier && ./gradlew build -x test

FROM ${JAVA_VERSION}

RUN mkdir /app
WORKDIR /app

COPY --from=BUILDER /root/sequence-hash-verifier/docker/*.jar /app/
COPY --from=BUILDER /root/sequence-hash-verifier/docker/libLwoCryptoCore.so /libLwoCryptoCore.so
COPY --from=BUILDER /root/sequence-hash-verifier/docker/libLwoWrapper.so /libLwoWrapper.so

CMD ["bash", "-c", "java --enable-preview -XX:MinRAMPercentage=70 -XX:MaxRAMPercentage=70 -jar sequence-hash*.jar" ]