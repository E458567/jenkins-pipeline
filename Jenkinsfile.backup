pipeline {
  agent any
  stages {
    stage('Prepare') {
      steps {
        script {
          // groovy codes
          println "Source /etc/maas.rc"
        }
      }
    }
    stage('Login MAAS') {
      steps {
        echo 'Login MAAS URL'
      }
    }
    stage('Recycle Nodes') {
      parallel {
        stage('Node #1') {
          steps {
            echo 'Release machine node #1 in MAAS ...'
              echo 'Deploy machine node #1 in MAAS ...'
          }
        }
        stage('Node #2') {
          steps {
            echo 'Release machine node #2 in MAAS'
              echo 'Deploy machine node #2 in MAAS'
          }
        }
      }
    }
    stage('SSH Nodes') {
      parallel {
        stage('Node #1') {
          steps {
            echo 'SSH to machine node #1'
          }
        }
        stage('Node #2') {
          steps {
            echo 'SSH to machine node #2'
          }
        }
      }
    }
    stage('Copy Image') {
      steps {
        echo 'Copy in Ubuntu image'
      }
    }
    stage('Install Ansible') {
      steps {
        echo 'Setup virtual environment'
          echo 'Install Ansible via pip'
      }
    }
    stage('Install OpenStack') {
      steps {
        echo 'Generate passwords YAML file'
          echo 'Run Ansible playbook.yml'
      }
    }
    stage('Boot VM & Ping') {
      steps {
        echo 'Boot the VM and ping should work ...'
      }
    }
    stage('Rally / Tempest') {
      parallel {
        stage('TC1 - Nova Tests') {
          steps {
            echo 'Rally / Tempest for Nova ...'
          }
        }
        stage('TC2 - Cinder Tests') {
          steps {
            echo 'Rally / Tempest for Cinder ...'
          }
        }
        stage('TC3 - Neutron Tests') {
          steps {
            echo 'Rally / Tempest for Neutron ...'
          }
        }
        stage('TC4 - Keystone Tests') {
          steps {
            echo 'Rally / Tempest for Keystone ...'
          }
        }
      }
    }
    stage('Notify') {
      parallel {
        stage('Rocket Chat / Slack') {
          steps {
            echo 'Send notification to Rocket Chat / Slack ...'
          }
        }
        stage('Email Alert') {
          steps {
            echo 'Send Email alert to responsible teams ...'
          }
        }
        stage('GitHub / JIRA') {
          steps {
            echo 'Open defects as GitHub issues or JIRA bugs ...'
          }
        }
      }
    }
  }
  post { 
    always { 
      // sh "cp /Users/ansible/tempest-image-report.html $WORKSPACE/tempest-report.html"
      // sh "cp /Users/ansible/rally-task-report.html $WORKSPACE/rally-task-report.html"
      archiveArtifacts artifacts: 'tempest-report.html', fingerprint: true
      archiveArtifacts artifacts: 'rally-task-report.html', fingerprint: true
    }
  }
}
