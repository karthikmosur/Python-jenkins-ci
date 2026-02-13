pipeline {
  agent {
    docker {
      image 'python:3.11-slim'
      label 'ec2'
    }
  }

  triggers {
    pollSCM('H/2 * * * *')
  }

  stages {
    stage('Checkout Code') {
      steps {
        checkout scm
      }
    }

    stage('Run Python App') {
      steps {
        sh '''
          echo "Workspace contents:"
          ls -la

          python --version
          python app.py
        '''
      }
    }
  }
}
