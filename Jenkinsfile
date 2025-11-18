pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Pulling website code...'
                git branch: 'main', url: 'https://github.com/adarspa124-spec/static-project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                    docker build -t static-website:v3 .
                """
            }
        }

        stage('Run Container') {
            steps {
                sh """
                    docker stop static-web || true
                    docker rm static-web || true
                    docker run -d --name static-web -p 9090:80 static-website:v3
                """
            }
        }
    }

    post {
        success {
            echo "Website running at: http://<your-server-ip>:9090"
        }
    }
}
