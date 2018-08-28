pipeline {
  agent {
    node {
      label 'sl6 x86_64'
    }

  }
  stages {
    stage('Build') {
      parallel {
        stage('Build') {
          agent {
            node {
              label 'sl6'
            }

          }
          steps {
            sh 'build.sh'
          }
        }
        stage('build') {
          agent {
            node {
              label 'sl7'
            }

          }
          steps {
            sh 'build.sh'
          }
        }
      }
    }
  }
  environment {
    OS = 'SL6'
    ARCH = 'x86_64'
    NAME = 'GMP'
    VERSION = '6.1.2'
  }
}