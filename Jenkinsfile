pipeline {
	agent any
	stages {
		stage('deploy.sh') {
			steps {
				script {
					// groovy codes
					println "Run existing deploy.sh and it will kick off ansible playbook.yml"
						println "OpenStack & Rally will be deployed to MAAS nodes"
				}
			}
		}
		stage('boot_and_ping.sh') {
			steps {
				echo 'Run existing boot_and_ping.sh to do connectivity pre-check'
			}
		}

		// new testing pipeline starts from here ...
		stage('Rally Verify (tempest tests)') {
			parallel {
				stage('Suite 1 - Keystone Tests') {
					steps {
						sh 'ansible-playbook -i hosts site.yml --extra-vars "tempest_suite=identity" --tags "testing-tempest"'
					}
				}
				stage('Suite 2 - Nova Tests') {
					steps {
						echo 'Tempest tests for Nova ...'
					}
				}
				stage('... more ... ') {
					steps {
						echo '... more tempest tests per different openstack service ...'
					}
				}
			}
		}

		// use different 'testing-rally' tag to run certain testing roles in ansible
		stage('Rally Task (scenario based tests)') {
			steps {
				sh 'ansible-playbook -i hosts site.yml --extra-vars "tempest_suite=identity" --tags "testing-rally"'
			}
		}
	}

	// post processing to attach rally/tempest reports to Jenkins job runs
	post { 
		always { 
			archiveArtifacts artifacts: 'tempest-report.html', fingerprint: true
				archiveArtifacts artifacts: 'rally-task-report.html', fingerprint: true
		}
	}
}
