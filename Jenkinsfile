pipeline {
    agent {
        label ‘ubuntu-slave’
    }

    environment {
        GHTOKEN = credentials('githubtoken')

    }


    stages {

        stage(‘SCM Checkout’) {
            steps {
                echo ‘SCM Checkout’

                script {
                    checkout scm
                    }
                }
            }

        stage(‘Docker Build & Push’) {
            steps {
                echo ‘Docker Build & Push’

                script {
		            def app
                    app = docker.build("mikebroomfield/snake")
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-creds') {
                    app.push("latest")
			}

                    }
                }
            }


        }
    }
}
