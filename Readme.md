#Installation and deployment instructions

##Task
###Create rotator app deployment for k8s 
1. create node.js/python/ruby/golang app named “rotator”  
    1.1. application should have /tag HTTP endpoint  
    1.2. response from endpoint should be taken from “rotator.json” file with contents:  
    ```
    [
        {
            "response": "a",
            "weight": 3
        },
        {
            "response": "b",
            "weight": 1
        }
    ]
    ```
    1.3. responses should be returned from Json file based on weighted round robin
    algorithm, for example, response "a" is assigned a weight of 3 and response "b" a
    weight of 1, the application returns 3 responses of "a" for each response of "b".  
2. deploy container of rotator app to local k8s cluster  
3. create app or script named “monitor” in any language of choice to test “rotator” app  
    3.1. monitor should generate 10000 requests and count responses grouped by body
    of response in order to verify rotation logic  
    3.2. run monitor from container and persist results in txt or json file  
4. create README.md with instructions how to deploy rotator app on local k8s cluster with cli
"kubectl create -f app-service.yaml, monitor-service.yaml"  
5. BONUS: deploy nginx reverse proxy for rotator app “kubectl create -f
ingress-service.yaml”  
6. BONUS: configure SSL termination with https://letsencrypt.org  

###Prereq's
Minikube/Kubernetes or Docker with compose

###Source
https://github.com/ay-b/a-b_test

###Map
Nginx reverse proxy is working in front of python script  
Internet --> [ Kubernetes [ Nginx.pod --> Python.pod ] ]  

Rotator works at port 8080, while Nginx listens to 80 and proxying requests to Rotator.  
Rotator has a hartbeat URL `/hearbeat` which can be adressed by a monitoring system

###Deployment
First variant:
    * in the project folder type `docker-compose up`
    * point at `localhost` in the browser 

Second variant:
    * ssh to the k8s 
    * type
    ```
     kubectl create -f rotator-deployment.yaml
     kubectl create -f rotator-service.yaml
     kubectl create -f nginx-deployment.yaml
     kubectl create -f nginx-service.yaml
    ```
    * if necessary, type `kubectl expose deployment nginx --type=NodePort` to get access from outside

###Monitoring
There is a shell script in the "monitor" folder, which can be run at any *nix host. This script does necessary runs against the target host and showing the stats with dropping result to the external `log.txt` file.  

//TODO - make an automated heartbeat/stats monitor script in a container  



