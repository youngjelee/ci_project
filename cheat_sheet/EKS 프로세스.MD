### 준비사항 : AWS CLI ,  eksctl ( eks 클러스터 생성 ) , kubectl (kubernetes 클러스터 다루는용 )
### local kube 파일 위치 : C:\Users\{username}\.kube\config

### 1. eksctl 로 클러스터 생성 
eksctl create cluster --name my-cluster --region ap-northeast-2 --nodegroup-name standard-workers --node-type t3.medium --nodes 3 --nodes-min 1 --nodes-max 4

### 2. kubeconfig 업데이트
aws eks update-kubeconfig --name my-cluster --region ap-northeast-2

### 3. 현재  사용중인 컨텍스트 확인
kubectl config current-context

### 4. 현재 노드 상태 확인
kubectl get nodes

### 5. Deployment 파일 적용
kubectl apply -f deployment.yml

### 6.Service 파일 적용
kubectl apply -f service.yml

### 7. ingress 파일적용 
kubectl apply -f ingress.yml

### 8 .ingress 리소스 상태확인
kubectl get ingress ci-project-ingress

### kind 삭제
kubectl delete ingress ci-project-ingress
kubectl delete service ci-project-service
kubectl delete deployment ci-project-deployment


### kubectl 설정확인 , 
kubectl get all
kubectl get ingress
kubectl get service
kubectl get pods


### 클러스터 조회 (eks)
eksctl get cluster

### 클러스터 삭제 (eks )
eksctl delete cluster <클러스터명>