pipeline {
	agent any
	
	stages {
		stage ('Docker Build'){
			steps{
				echo "Building Docker Image"
				sh 'docker build -t deployment2:1.0 .'
			}
		}

		stage ('Verify Docker Image'){
			steps{
				echo "Listing Docker Images"
				sh 'docker images'
			}
		}
		stage ('Precheck of Deployment'){
			steps{
				echo "Stop and Remove existing container"
				sh 'docker stop devops-deployment2 || true'
				sh 'docker ps -a'
				sh 'docker rm devops-deployment2 || true'
				sh 'docker ps -a'
			}
		}

		stage ('Deployment'){
			steps{
				echo "Deploying Application"
				sh 'docker run -d --name devops-deployment2 -p 82:80 deployment2:1.0'
			}
		}

		stage ('Verify Deployment'){
			steps{
				echo "Verify Deployment"
				sh 'docker ps'
				sh 'curl http://localhost:82'
			}
		}
	}

}
