# terraform-scaleio
A Terraform kit for trying out ScaleIO 1.32 on public clouds

Use this kit to deploy [ScaleIO 1.32](http://www.emc.com/products-solutions/trial-software-download/scaleio.htm) (the free trial - although its not locked in anyway) to various cloud providers. 

Note: You can edit `variables.tf` to change the number of SDS instances and a few other things easily.  Recommend you don't change the instance types unless you know what you are doing.  If you do adjust the instance count or types, you'll need to explicitly destroy the cluster (see Destroy below) or at least `taint` the MDM to force it to rebuild with `terraform taint aws_instance.mdm` (replacing aws_instance with the appropriate provider as needed).

Amazon Web Services:
  * Deploy: `terraform apply -var "access_key=AWSACCESSKEY" -var "secret_key=SECREY" -var "key_name=PEM_KEY_NAME"`
  * Destroy: `terraform destroy -var "access_key=AWSACCESSKEY" -var "secret_key=SECREY" -var "key_name=PEM_KEY_NAME"`
