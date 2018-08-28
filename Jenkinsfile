pipeline {
  agent {
    node {
      label 'sl6 x86_64'
    }

  }
  stages {
    stage('Build') {
      parallel {
        stage('Build centos6') {
          agent {
            docker {
              image 'quay.io/aaroc/code-rade-centos6'
            }

          }
          steps {
            sh 'build.sh'
          }
        }
        stage('Build centos7') {
          agent {
            docker {
              image 'quay.io/aaroc/code-rade-centos7'
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