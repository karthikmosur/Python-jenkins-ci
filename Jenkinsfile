pipeline {
  agent {
    docker {
      image 'python:3.11-slim'
      label 'ec2'
    }
  }

  environment {
    PATH = "$HOME/.local/bin:$PATH"
  }

  stages {

    stage('Checkout Code') {
      steps {
        checkout scm
      }
    }

    stage('Install Dependencies') {
  steps {
    sh '''
      python -m venv venv
      . venv/bin/activate
      pip install -r requirements.txt
    '''
  }
}


    stage('Run Unit Tests') {
      steps {
        sh '''
          pytest --junitxml=pytest-report.xml
        '''
      }
      post {
        always {
          junit 'pytest-report.xml'
        }
      }
    }

    stage('SAST - Bandit') {
      steps {
        sh '''
          bandit -r . -f json -o bandit-report.json || true
        '''
      }
      post {
        always {
          archiveArtifacts artifacts: 'bandit-report.json'
        }
      }
    }

    stage('Dependency Scan - Safety') {
      steps {
        sh '''
          safety check --json > safety-report.json || true
        '''
      }
      post {
        always {
          archiveArtifacts artifacts: 'safety-report.json'
        }
      }
    }
  }
}
