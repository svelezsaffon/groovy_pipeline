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
            container("python-container"){
                steps{
                    sh "printenv"
                }
            }
        }
        stage("set_up"){
            steps{
                sh "echo ${env.NODE_NAME}"
                sh 'pip3 list'
            }
        }
    }

}