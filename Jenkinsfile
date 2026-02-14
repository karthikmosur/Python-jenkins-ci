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
          python -m venv .venv
          . .venv/bin/activate
          python -m pip install --upgrade pip setuptools wheel
          pip install -r requirements.txt
        '''
      }
    }

    stage('Run Unit Tests') {
      steps {
        sh '''
          . .venv/bin/activate
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
          . .venv/bin/activate
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
          . .venv/bin/activate
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

  post {
    always {
      cleanWs()
    }
  }
}


