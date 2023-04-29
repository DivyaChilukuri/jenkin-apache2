pipeline{
         agent {
        label 'docker'
    }

environment {
		DOCKER_LOGIN_CREDENTIALS=credentials('dockerhostpush')
	}
    stages {
        stage('checkout') {
         steps {
          git branch: 'main', url: 'https://github.com/DivyaChilukuri/jenkin-apache2.git'
    }
  }

         stage('Build image') {
            steps {
             sh 'docker build -t divyachilukuri/divya2:$BUILD_NUMBER .' 
             sh 'echo $DOCKER_LOGIN_CREDENTIALS_PSW | docker login -u $DOCKER_LOGIN_CREDENTIALS_USR --password-stdin'
             sh 'docker push divyachilukuri/divya2:$BUILD_NUMBER'
    }
  }

        stage('deploy') {
            steps {
                sh "docker run -itd -p 8082:8080 -p 70:80 divyachilukuri/divya2:$BUILD_NUMBER"
    }
  }

}

}
