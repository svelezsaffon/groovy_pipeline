pipeline{
    agent{
        kubernetes{
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