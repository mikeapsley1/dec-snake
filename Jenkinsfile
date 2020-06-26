pipeline {
    agent 
	{ label 'ubuntu-slave' }
	
	environment {
        GHTOKEN = credentials('githubtoken')
	}

	
    stages { 
        stage('Checkout SCM') {
            steps {
                echo 'Checkout SCM'
		    script {
			checkout scm
		    }
            }
        }
    }
}
