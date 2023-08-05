ARG JAVA_VERSION
FROM ${JAVA_VERSION}

COPY . /root/

RUN cd /root/notification-dispatcher && ./gradlew build -x test

CMD ["bash", "-c", "java --enable-preview -XX:NativeMemoryTracking=summary -XX:MinRAMPercentage=70 -XX:MaxRAMPercentage=70 -jar /root/notification-dispatcher/build/libs/notification-dispatcher*.jar"]