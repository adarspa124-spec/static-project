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
                powershell """
                    docker build -t static-website:v3 .
                """
            }
        }

        stage('Run Container') {
            steps {
                powershell """
                    docker stop static-web 2>\$null
                    docker rm static-web 2>\$null
                    docker run -d --name static-web -p 9090:80 static-website:v3
                """
            }
        }
    }

    post {
        success {
            echo "Website running at: http://localhost:9090"
        }
    }
}
