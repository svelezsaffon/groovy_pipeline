pipeline{
    agent{
        kubernetes{
            inheritFrom "python-pod"
            cloud "kubernetes"
            defaultContainer "python-container"
        }
    }


    stages{
        stage("environment"){
            steps{
                container("python-container"){
                    sh "echo ${env.JENKINS_AGENT_NAME}"
                    sh 'pip3 list'
                }
            }
        }
        stage("set_up"){
            steps{
                sh "echo ${env.JENKINS_AGENT_NAME}"
                sh 'pip3 list'
            }
        }
    }

}