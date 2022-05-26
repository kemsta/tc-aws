Temcity Server has been installed. 

You need to do next steps for configuring application.

Update `kubectl` config:  
`aws eks update-kubeconfig --name ${cluster_name}`  

Get the load balancer address and open it in the browser(Hold on, DNS maybe have not been updated yett):  
`kubectl get service -l app.kubernetes.io/instance=dev,app.kubernetes.io/name=tc-server -n ${namespace} -o jsonpath='{.items[*].status.loadBalancer.ingress[*].hostname}'`  

Follow the instructions in your browser to set up the application.  
You need secret key for first loggin. You can get it from logs:  
`kubectl logs -n ${namespace} ${stage_tag}-tc-server-0 --tail 1`  

For connection to the database use next params:  
type:      postgres  
user:      ${db_username}  
password:  run `terraform output db_password`
endpoint:  ${db_endpoint}  

After initialization you should roll out the next release with intialized=true variable like `terraform apply --auto-approve -var initialized=true` or set it in your tfvars file. It will enable health checks in application.

Now you can configure TeamCity Server, set up s3 storage with credentials below, and do your things with it. 

S3 credentials:
Access key ID: ${s3_access_id}
Secret access key: run `terraform output s3_user_secret`
S3 bucket name: ${s3_bucket_name}

For cloud profile possible to use params bellow:
Kubernetes API server URL: ${eks_endpoint}
Kubernetes namespace: ${namespace}
Authentication strategy: Amazon EKS
Access ID: ${agent_access_id}
Secret Key: run `terraform output agent_user_secret`
Cluster name: ${cluster_name}
Agent images from deployment template ${stage_tag}-tc-server-agent