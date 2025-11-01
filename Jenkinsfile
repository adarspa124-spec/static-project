pipeline {
  agent any

  environment {
    DOCKER_USER = 'root465'
    IMAGE_NAME = "${DOCKER_USER}/my-static-site"
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/adarspa124-spec/static-project.git'
  // 👈 apna GitHub repo link daalna
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        sh '''
          kubectl apply -f static-site.yaml
          kubectl rollout status deployment/static-site
        '''
      }
    }
  }

  post {
    success {
      echo "✅ Deployment Successful!"
    }
    failure {
      echo "❌ Deployment Failed!"
    }
  }
}
