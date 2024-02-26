# Gradle Project

### 1. 
Create a dockerhub account with a token.

### 2.
Add an ssh key for this repo

### 3. 
Run 

```
cd jenkins/
docker-compose up -d
```

### 4.
Go to 

```
http://localhost:8080
```

### 5.
Finish Setting up Jenkins


### 6. 
Insert the credintals from steps 2 & 3 into jenkins secrets manager:
with the IDs:

```
dockerhub
git-ssh-key
```

### 7.
Go to Manage Jenkins --> Security --> Git Host Key Verification Configuration

Choose Manaully Provided Keys and add the github approved host key provieded by Jenkins
