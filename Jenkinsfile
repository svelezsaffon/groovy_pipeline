pipeline{
    agent{
        kubernetes{
            inheritFrom "alpine-pod"
            cloud "kubernetes"
        }
    }


    stages{
        stage("set_up"){
            steps{
                container("alpine-container"){
                    sh 'ls -la'
                }
            }
        }
    }

}