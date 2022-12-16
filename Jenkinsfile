pipeline{
    agent{
        kubernetes{
            label "groovy_pipeline"
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