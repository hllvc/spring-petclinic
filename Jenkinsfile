pipeline {

	agent any

	stages {

		stage('Build Image') {
			steps {
					sh 'docker build -f Dockerfile.build -t petclinic-build .'
			}
		}

		stage('Build App') {
			steps {
				sh 'docker run -v $HOME/.m2:/root/.m2 --name petclinic-build petclinic-build'
				sh 'docker cp petclinic-build:/build/spring-petclinic/target/app.jar .'
				sh 'docker container rm -f petclinic-build'
				sh 'docker build -f Dockerfile.run -t hllvc/spring-petclinic .'
			}
		}

		stage('Push App Image') {
			steps {
				withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
					sh 'docker login -u $USER -p $PASS'
				}
				sh 'docker push hllvc/spring-petclinic'
			}
		}

		stage('Run App') {
			steps {
					sh 'docker-compose up -d'
			}
		}

	}
}
