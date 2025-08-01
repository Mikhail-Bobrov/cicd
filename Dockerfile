FROM ubuntu
RUN apt-get update && apt-get install vim
CMD "[""echo"", ""Hello World""]"










FROM python:3.9
COPY . /app
RUN pip install -r /app/requirements.txt
RUN pip install numpy pandas matplotlib
RUN apt-get update && apt-get install -y git
CMD "["python", "/app/main.py"]"

