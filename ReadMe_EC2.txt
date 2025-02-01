------------------------
README 
------------------------

For EC2
------------------------

#installing docker on EC2
sudo yum update -y
sudo yum install -y docker

sudo systemctl start docker
sudo systemctl enable docker

-------------------------------------
#updating aws credentials inside EC2
-------------------------------------

nano ~/.aws/credentials

-------------------------------------
#adding user to the docker group
-------------------------------------

sudo usermod -aG docker $USER

newgrp docker

------------------
#ECR Repo login
------------------

aws ecr describe-repositories

export ECR=788814499739.dkr.ecr.us-east-1.amazonaws.com/flask-mysql-ecr

aws ecr get-login-password --region us-east-1 | docker login -u AWS ${ECR} --password-stdin

------------------------------------------------------------
#Pulling MySQL and flask app image
------------------------------------------------------------


docker pull 788814499739.dkr.ecr.us-east-1.amazonaws.com/flask-mysql-ecr:mysql-latest
docker pull 788814499739.dkr.ecr.us-east-1.amazonaws.com/flask-mysql-ecr:app-latest

------------------------------------------------------------
#Creating custom network
------------------------------------------------------------

docker network create flask-network

------------------------------------------------------------
#Running MySQL and flask app image
------------------------------------------------------------

docker run -d --name mysql-db --network flask-network -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=employees 788814499739.dkr.ecr.us-east-1.amazonaws.com/flask-mysql-ecr:mysql-latest

docker run -it --rm --network flask-network mysql:latest mysql -h mysql-db -u root -p

SHOW DATABASES;

docker run -d -p 8080:8080 --name flask-app --network flask-network -e DBHOST=mysql-db -e DBUSER=root -e DBPWD=password -e DATABASE=employees -e DBPORT=3306 788814499739.dkr.ecr.us-east-1.amazonaws.com/flask-mysql-ecr:app-latest

docker run -d -p 8081:8080 --name flask-app-blue --network flask-network -e DBHOST=mysql-db -e DBUSER=root -e DBPWD=password -e DATABASE=employees -e DBPORT=3306 -e APP_COLOR=blue 788814499739.dkr.ecr.us-east-1.amazonaws.com/flask-mysql-ecr:app-latest

docker run -d -p 8082:8080 --name flask-app-pink --network flask-network -e DBHOST=mysql-db -e DBUSER=root -e DBPWD=password -e DATABASE=employees -e DBPORT=3306 -e APP_COLOR=pink 788814499739.dkr.ecr.us-east-1.amazonaws.com/flask-mysql-ecr:app-latest

docker run -d -p 8083:8080 --name flask-app-lime --network flask-network -e DBHOST=mysql-db -e DBUSER=root -e DBPWD=password -e DATABASE=employees -e DBPORT=3306 -e APP_COLOR=lime 788814499739.dkr.ecr.us-east-1.amazonaws.com/flask-mysql-ecr:app-latest

------------------------------------------------------------
#Installing ping package inside flask container
------------------------------------------------------------

apt-get update && apt-get install -y iputils-ping


docker exec -it 18ea04268f7d bash



