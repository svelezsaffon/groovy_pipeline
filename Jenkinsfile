pipeline{
    agent{
        kubernetes{
            cloud "kubernetes"
            yaml ''''''
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