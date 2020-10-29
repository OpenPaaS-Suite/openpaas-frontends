pipeline {
  agent none

  stages {
    stage('Deliver Docker images') {
      when { branch 'main' }
      agent {
        docker {
          image 'docker:19.03.12-dind'
          args '-e DOCKER_HOST=$DOCKER_HOST'
        }
      }
      steps {
        script {
          def dockerImage = docker.build 'linagora/openpaas-front'
          docker.withRegistry('', 'dockerHub') {
            dockerImage.push('branch-main')
          }
        }
      }
    }
  }
}
