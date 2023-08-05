ARG JAVA_VERSION
FROM ${JAVA_VERSION}

COPY . /root/

RUN cd /root/chat-bot && ./gradlew build -x test

CMD ["bash", "-c", "java --enable-preview -XX:NativeMemoryTracking=summary -XX:MinRAMPercentage=70 -XX:MaxRAMPercentage=70 -jar /root/chat-bot/build/libs/chat-bot*.jar"]