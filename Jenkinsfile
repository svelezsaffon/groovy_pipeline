pipeline{
    agent{
        kubernetes{
            yaml ''''''
        }
    }


    stages{
        stage("set_up"){
            container("alpine-container"){
                sh 'ls -la'
            }
        }

    }

}