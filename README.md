# newproject

Step1: Sabse pahle mujhe ek Ec2 machine banani hai jaha mera Git, Jenkins, Terraform, Ansible install hoga.
Maine script bana kr rakkhi hai apne local system par Desktop folder mai
Ec2 machine banne ke baad, Security group mai 8080 ko allow kro

step2: Jenkins mai  terraform, Git, pipeline stage viw, ansible ye sare plugins install kro

step3: global tool configuration mai jao , Terraform ka path do, Ham terraform ka path check kr sakte hai which terraform command run krke.

step4: Ansible ka path dene ki jarurat nhi h

step5: Git ka path bhi dedo global tool configuraion mai jakar

step6: jenkins mai jakar new item par click kro aur pipeline select kro
pipeline mai GitHub project mai ye value do: https://github.com/chavirenu3/newproject/
Pipeline mai "Pipeline from SCM" select kro
Repository mai https://github.com/chavirenu3/newproject.git
branch main select kro

step7: access key aur secret key configure kro
manage jenkins - credentiatls mai - global par click kro aur- secret text select kro
dono credentials daal do.

1. AWS_SECRET_ACCESS_KEY
2. AWS_ACCESS_KEY_ID 


ab pipeline trigger kro.

Ho sakta hai terraform apply ke baad, hme warm up period bhi pipeline mai dena pade toh 2 minutes ka de sakte hai

Note: Apki keypair ko permission honi chahiye
chmod 600 /var/lib/jenkins/jobs/myproject/workspace/mynewsshkey.pem


agar apko vs code ko apne ec2 se connect krna hai toh uske liye bi steps desktop par hai.