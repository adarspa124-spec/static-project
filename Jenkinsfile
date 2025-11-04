pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/adarspa124-spec/static-project.git'
        IMAGE_NAME = 'root465/my-static-site'
        IMAGE_TAG = 'v1'
        K8S_DEPLOYMENT = 'k8s/deployment.yaml'
        K8S_SERVICE = 'k8s/service.yaml'
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo "Cloning static site repository..."
                git branch: 'main', url: "${GIT_REPO}"
            }
        }

        stage('Build Static Site') {
            steps {
                echo "Building static files..."
                sh '''
                if [ -f package.json ]; then
                    npm install
                    npm run build
                else
                    echo "No npm build process detected"
                fi
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh '''
                docker build -t ${root465/my-static-site}:${v1} .
                '''
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    docker push ${IMAGE_NAME}:${IMAGE_TAG}
                    docker logout
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo "Deploying to Kubernetes cluster..."
                sh '''
                kubectl set image deployment/static-site static-site=${IMAGE_NAME}:${IMAGE_TAG} || \
                kubectl apply -f ${K8S_DEPLOYMENT}
                kubectl apply -f ${K8S_SERVICE}
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                echo "Verifying Kubernetes deployment..."
                sh '''
                kubectl get pods
                kubectl get svc
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Static site deployed successfully to Kubernetes!'
        }
        failure {
            echo '❌ Deployment failed. Please check the logs above.'
        }
    }
}
