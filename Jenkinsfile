pipeline{
    agent{
        kubernetes{
            label "alpine-agent"
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