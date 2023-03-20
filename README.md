
## Audition Assignment

Project contains of code to analyse the input data and code to deploy solution to k8s.  

### Code
Is easy bash script which analyses data, put them to output file and prints the outcome.  

### Deployment
Deployment of code is focused to deploy solution to k8s and consist of  
- creation of [docekr image](Dockerfile) to encapsulate the doce
- [helm chart](qaHelm) solution of deployment
- [terraform code](qaTerraform) to deploy the solution to k8

#### Output example
```
$ kubectl logs qa-helm-pod  
{  
"temp-1": "precise"  
"temp-2": "ultra precise"  
"hum-1": "keep"  
"hum-2": "discard"  
}  
```
