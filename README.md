# Test upload flask app and run on AWS

## Step 1: Create an Ubuntu EC2 on AWS
1. Of course, the first step would be to create the EC2 to deploy our application.

2. Log in to AWS Console. 
3. Go to EC2 Section and select Ubuntu 18.4 AMI 
4. Select t2.micro if you want to stay in free tier or any other instance type you want. 
5. Press Next until Security Groups. 
6. Allow HTTP (Port 80), SSH (Port 22), HTTPS (Port 443) inbound traffic and press next. 
7. Create/Reuse Key-pair for connecting with your instance.

## Step 2: SSH into Ubuntu EC2
If you are a Windows user, please check how to connect to the EC2 with the steps specified in this link.
1. Open a terminal
2. Type $ ssh -i <your key name>.pem ubuntu@<Public DNS of your EC2>.
3. If you encounter an error message, run $ chmod 400 <your key name>.pem then try Step 2 again.
4. You are in!

## Step 3: Create/Clone Flask application inside EC2
If you already have a flask project on a Git Repository, clone your application into the EC2.

For this article, I would create a new application.

Install Python Virtualenv
```
$ sudo apt-get update
$ sudo apt-get install python3-venv
$ sudo apt install python3-pip 

```
Activate the new virtual environment in a new directory
// Create directory
````
$ mkdir helloworld
$ cd helloworld
// Create the virtual environment
$ python3 -m venv venv

// Activate the virtual environment
$ source venv/bin/activate

// Install Flask
$ pip install Flask
````
Create a Simple Flask API
````
$ sudo nano app.py
````
````
// Add this to app.py
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
 return 'Hello World!'

if __name__ == "__main__":
 app.run()
````
Verify if it works by running 
````
pip freeze >requirements.txt
python app.py
````

## Step 4: Run Gunicorn WSGI server to serve the Flask Application
When you “run” flask, you are actually running Werkzeug’s development 
WSGI server, which forward requests from a web server.

Since Werkzeug is only for development, we have to use Gunicorn,
which is a production-ready WSGI server, to serve our application.

Install Gunicorn using — 
````
$ pip install gunicorn
````
Run Gunicorn — 
```
$ gunicorn -b 0.0.0.0:8000 app:app 
```
. Further modifications are possible, check out the gunicorn docs!
Gunicorn is running (Ctrl + C to exit gunicorn)!

Go to http://ec2-18-194-105-172.eu-central-1.compute.amazonaws.com:8000/


