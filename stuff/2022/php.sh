#!/bin/bash
sudo -u ec2-user -i <<'EOF'
sudo yum update -y
sudo yum install httpd php amazon-efs-utils -y
sudo systemctl enable httpd
sudo systemctl start httpd
sudo chown ec2-user:ec2-user /var/www/html/
sudo mkdir /var/www/html/efs
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 10.0.30.183:/ /var/www/html/efs
touch /var/www/html/test.php
echo "<?php phpinfo();?>" >> /var/www/html/test.php
sudo chmod -R 755 /var/www/html/test.php
sudo systemctl restart httpd
EOF