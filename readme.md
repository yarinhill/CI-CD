# Gradle Project

### 1.
Run

```
./install.sh
```

### 2. 
Create a dockerhub account with a token.

### 3.
Add an ssh key for this repo

### 4. 
Run 

```
cd ~/gradle/jenkins/
docker-compose up -d
```

### 5.
Go to 

```
http://localhost:8080
```

### 6.
Finish Setting up Jenkins


### 7. 
Insert the credintals from steps 2 & 3 into jenkins secrets manager:
with the IDs:

```
dockerhub
git-ssh-key
```

### 8.
Go to Manage Jenkins --> Security --> Git Host Key Verification Configuration

Choose Manaully Provided Keys and add the github approved host key provieded by Jenkins
