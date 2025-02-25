# 도커 애플리케이션 이용해서 이미지 파일로 빌드
docker build -t ci_project .

# 이미지 실행
docker run -p 8080:8080 ci_project


////////////////////////////////////////////////////////
/// docker hub 에 이미지를 푸시하고싶은경우
//////////////////////////////////////////////////////

# Docker Hub용 태그 지정  로컬이미지 -> 계정/repoistory:tag 복사
docker tag ci_project ljy1221/ci_project:latest

# 도커헙 로그인 계정 , 입력하고나면 패스워드입력
docker login --username ljy1221

# 도커헙에 이미지 푸시
docker push ljy1221/ci_project:latest

////////////////////////////////////////////////////////////////////
// AMAZON ECR 에 푸시하고싶은경우 ( aws-cli 가 활성화가 되어있어야함 )
// 계정정보 확인 하는 cli :  aws sts get-caller-identity
///////////////////////////////////////////////////////////////////

#  ECR 저장소 생성 (서울 리전)
aws ecr create-repository --repository-name ci_project --region ap-northeast-2

# ECR 로그인 (서울 리전)  [ AmazonEC2ContainerRegistryReadOnly, AmazonEC2ContainerRegistryPowerUser] 권한 이 존재해야함
-> 파이프라인이 개행 문제가있어서 수동으로 테스트하는경우 두개의 명령어로 테스트
$token = aws ecr get-login-password --region ap-northeast-2
docker login --username AWS --password $token 605158037001.dkr.ecr.ap-northeast-2.amazonaws.com

-> 명령어로 한번에실행하는경우 (CI/CD ) 는 아래로 설정한다.
aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.ap-northeast-2.amazonaws.com

# 이미지 태그 지정( 서울리전)  기존 로컬 이미지를 아마존 ecr 형식에 맞춰 이름변경
docker tag ci_project:latest <aws_account_id>.dkr.ecr.ap-northeast-2.amazonaws.com/ci_project:latest

# 이미지 푸시
docker push <aws_account_id>.dkr.ecr.ap-northeast-2.amazonaws.com/ci_project:latest
