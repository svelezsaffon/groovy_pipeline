pipeline{
    agent{
        kubernetes{
            inheritFrom "python-pod"
            cloud "kubernetes"
        }
    }


    stages{
        stage("set_up"){
            steps{
                container("python-container"){
                    sh 'ls -la'
                }
            }
        }
    }

}