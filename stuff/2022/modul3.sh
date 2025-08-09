#!/bin/bash
sudo -u ec2-user -i << 'EOF'
sudo yum update -y
sudo yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_16.x | sudo -E bash -
sudo yum install nodejs git nfs-utils -y
git clone https://github.com/handipradana/apps-cloud-lksn2022.git
cd apps-cloud-lksn2022/backend
npm install
touch .env
echo "NODE_ENV=production" >> .env
echo "DB_HOST=lks-db.clou0aw4i4l5.us-west-2.rds.amazonaws.com" >> .env
echo "DB_USER=admin" >> .env
echo "DB_PASS=smkbisa12345" >> .env
echo "DB_NAME=product" >> .env
echo "AWS_ACCESS_KEY=" >> .env
echo "AWS_SECRET_ACCESS_KEY=" >> .env
echo "AWS_BUCKET_NAME=lks-backup-s3" >> .env
echo "REDIS_HOST=master.lks-redis.tjp5ym.usw2.cache.amazonaws.com:6379" >> .env
echo "REDIS_PORT=6379" >> .env
echo "REDIS_PASS=Cloud2022!lks2022" >> .env
echo "LOG_PATH=/home/ec2-user/efs/logs" >> .env
echo "CACHE_PATH=/home/ec2-user/efs/cache" >> .env
mkdir /home/ec2-user/efs
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 180.10.0.11:/ /home/ec2-user/efs/
sudo chown ec2-user:ec2-user /home/ec2-user/efs
mkdir -p /home/ec2-user/efs/logs /home/ec2-user/efs/cache
sudo npm i pm2 -g
npm run start-apps
EOF

#!/bin/bash
sudo -u ec2-user -i << 'EOF'
sudo yum update -y
sudo yum update -y
sudo yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_16.x | sudo -E bash -
sudo yum install nodejs git nfs-utils -y
git clone https://github.com/handipradana/apps-cloud-lksn2022.git
cd apps-cloud-lksn2022/frontend
touch .env
echo "REACT_APP_BACKEND = http://backend-lb-69253477.us-west-2.elb.amazonaws.com" >> .env
echo "REDIS_HOST=master.lks-redis.tjp5ym.usw2.cache.amazonaws.com:6379" >> .env
echo "REDIS_PORT=6379" >> .env
echo "REDIS_PASS=Cloud2022!lks2022" >> .env
echo "LOG_PATH=/home/ec2-user/efs/logs" >> .env
echo "CACHE_PATH=/home/ec2-user/efs/cache" >> .env
mkdir /home/ec2-user/efs
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 180.10.0.11:/ /home/ec2-user/efs/
sudo chown ec2-user:ec2-user /home/ec2-user/efs
mkdir -p /home/ec2-user/efs/logs /home/ec2-user/efs/cache
npm install 
npm install serve
sudo npm i pm2 -g
npm run build
pm2 start npm -- start
EOF

