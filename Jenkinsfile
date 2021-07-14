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
			}
		}

		stage('Run') {
			steps {
					sh 'docker build -f Dockerfile.run -t petclinic-run .'
					sh 'docker-compose up -d'
			}
		}

	}
}
