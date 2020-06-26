pipeline {
    agent 
	{ label 'ubuntu-slave' }
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
