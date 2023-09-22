ARG JAVA_VERSION
FROM ${JAVA_VERSION} as BUILDER

COPY . /root/
RUN cd /root/chat-bot && ./gradlew build -x test

FROM ${JAVA_VERSION}

RUN mkdir /app
WORKDIR /app

COPY --from=BUILDER /root/chat-bot/build/libs/ /app/

CMD ["bash", "-c", "java --enable-preview -XX:NativeMemoryTracking=summary -XX:MinRAMPercentage=70 -XX:MaxRAMPercentage=70 -jar chat-bot*.jar"]