pipeline {
  agent {
    docker {
      image 'python:3.8.2'
    }

  }
  stages {
  
    stage('SetUp and Checkout') {
      steps {
        sh 'python3 -m venv env && . ./env/bin/activate && pip3 install -r requirement.txt --no-cache-dir'
      }
    }

    stage('Compile') {
      steps {
        sh 'python -m compileall ./src/'
        stash(name: 'compiled-results', includes: 'src/*.py*')
      }
    }

    stage('Lint') {
      steps {
        sh '. ./env/bin/activate && pip3 install pylint --no-cache-dir && $(which pylint) ./src/ || exit 0'
      }
    }

    stage('UnitTest') {
      steps {
        sh '. ./env/bin/activate && pip3 install pytest --no-cache-dir && $(which pytest) ./src/tests/'
      }
    }

    stage('Deliver') {
      steps {
        echo 'Completed'
      }
    }

  }
}
