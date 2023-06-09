FROM python:3.8-slim-buster

WORKDIR /webapp

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
RUN pip3 install flask
RUN pip3 install gunicorn
COPY templates .

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]