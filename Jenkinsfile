// set variables
String payload = "${payload}"
def jsonObject = readJSON text: payload
String gitHash = "${jsonObject.pull_request.head.sha}"
String buildUrl = "${BUILD_URL}"


pipeline {
    agent 
	{ label 'ubuntu-slave' }
	
	environment {
        GHTOKEN = credentials('githubtoken')
	String gitStatusPostUrl = "https://api.github.com/repos/mikeapsley1/dec-snake/statuses/${gitHash}?access_token=$GHTOKEN"
	}

	
    stages { 
	    
        stage('Checkout PR') {
            steps {
                echo 'Checkout PR'
		sh "git checkout ${gitHash}"
            }
        }
	    
	    stage('Docker Build & Push') {
            steps {
                echo 'Docker Build & Push'
		    script {
			def app
                    	app = docker.build("mikebroomfield/snake:${env.BUILD_ID}")
                    	docker.withRegistry('https://registry.hub.docker.com', 'docker-creds') {
			app.push()	
                     	app.push("latest")
			}
		    }
            }
        }
	    
	    stage('Trivy Scan') {
         	steps {
        	 // Build Report
         	sh "trivy --no-progress --exit-code 0 -f json -o results.json mikebroomfield/snake"
         
         	// Print Report 
         	sh "trivy --no-progress --exit-code 0 --severity HIGH,CRITICAL mikebroomfield/snake"
         
         	// Fail on high & critical vulnerabilities
         	sh "trivy --no-progress --exit-code 1 --severity HIGH,CRITICAL mikebroomfield/snake"
		}
      }
	    
    }
	
	post {
        always {
            echo 'One way or another, I have finished'
            deleteDir() /* clean up our workspace */
        }
        success {
            echo 'I succeeeded!'
	    sh """
            curl -X POST -H "application/json" -d '{"state":"success", "target_url":"${buildUrl}", "description":"Build Success", "context":"security assessment"}' "${gitStatusPostUrl}"
            """
        }
        
        failure {
            echo 'I failed :('
	    sh """
            curl -X POST -H "application/json" -d '{"state":"failure", "target_url":"${buildUrl}", "description":"Build Failed", "context":"security assessment"}' "${gitStatusPostUrl}"
            """
        }
        
    }
}
