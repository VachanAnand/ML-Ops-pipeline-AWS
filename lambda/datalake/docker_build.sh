repo_name="demo/datalake"
tag="test"

docker build -t ${repo_name}:${tag} .
aws ecr get-login-password --region ap-southeast-2 | docker login --username AWS --password-stdin 464866296249.dkr.ecr.ap-southeast-2.amazonaws.com
docker tag  ${repo_name}:${tag} 464866296249.dkr.ecr.ap-southeast-2.amazonaws.com/${repo_name}:${tag}
docker push 464866296249.dkr.ecr.ap-southeast-2.amazonaws.com/${repo_name}:${tag}      
