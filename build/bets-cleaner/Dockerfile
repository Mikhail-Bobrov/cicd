ARG JAVA_VERSION
FROM ${JAVA_VERSION} as BUILDER

COPY . /root/
RUN cd /root/bets-cleaner && ./gradlew build -i -DproductionMode=true -x test

FROM ${JAVA_VERSION}

RUN mkdir /app
WORKDIR /app

COPY --from=BUILDER /root/bets-cleaner/build/libs/ /app/

CMD ["bash", "-c", "java -XX:NativeMemoryTracking=summary -XX:MinRAMPercentage=70 -XX:MaxRAMPercentage=70 -jar bets-cleaner*.jar"]