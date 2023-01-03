pipeline{
    agent{
        kubernetes{
            inheritFrom "python-pod"
            cloud "kubernetes"
            defaultContainer "python-container"
        }
    }

    stages{
        stage("set_up"){
            steps{
                sh "ls"
            }
        }
        stage("run_python"){
            steps{
                sh "echo ${env.JENKINS_AGENT_NAME}"
                sh 'python3 -m unittest test/test_all.py'
            }
        }
    }

}