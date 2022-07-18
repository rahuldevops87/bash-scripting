Image=$(aws ec2 describe-images --filters "Name=name,Values=CloudDevOps-LabImage-CentOS7" | jq '.Images[].ImageId' | sed -e 's/"//g')

Security=$(aws ec2 describe-security-groups --filters "Name=ip-permission.cidr,Values=0.0.0.0/0"|jq '.SecurityGroups[].GroupId'| sed -e 's/"//g')

aws ec2 run-instances --image-id $Image --count 1 --instance-type t2.micro --security-group-ids $Security
