1. Starting up an EC2 instance
Flask is a web framework for python, meaning that it provides a simple interface for dynamically generating responses to web requests. Let’s start by launching a Flask server on an Amazon Web Services EC2 instance.

1. Launch an EC2 instance.
Log in to the AWS console here
Select EC2 from AWS services.
Click on Launch Instance.
Select the Ubuntu Server 16.04 LTS (HVM), SSD Volume Type — ami-43a15f3e instead of the Amazon Linux. The exact versions may change with time.
Click on Review and Launch.
Configure the security groups as shown below. This setting allows access to port 80 (HTTP) from anywhere, and ssh access only from any IP address.

2. Setting up the instance
Now that we’ve connected to the instance, it’s time to install some of the programs we’ll need.

1. Connect to the instance using ssh from the Terminal.
$ ssh -i "yourapp.pem" ubuntu@yourapppublicinstance.compute-1.amazonaws.com
2. Install the apache webserver and mod_wsgi.
$ sudo apt-get update
$ sudo apt-get install apache2
$ sudo apt-get install libapache2-mod-wsgi
If you point your browser at your instance’s public DNS name you should see the Apache server’s “It works!” page.


3. Install Flask using the pip tool (which also needs to be installed).
$ sudo apt-get install python-pip
$ sudo pip install flask
4. Create a directory for our Flask app.
We’ll create a directory in our home directory to work in, and link to it from the site-root defined in apache’s configuration /var/www/html by default, see /etc/apache2/sites-enabled/000-default.conf for the current value).

$ mkdir ~/flaskapp
$ sudo ln -sT ~/flaskapp /var/www/html/flaskapp
To verify our operation is working, create a simple index.html file.

$ cd ~/flaskapp
$ echo "Hello World" > index.html
You should now see “Hello World” displayed if you navigate to (your instance public DNS)/flaskapp in your browser.
