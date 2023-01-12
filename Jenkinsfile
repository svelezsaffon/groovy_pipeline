pipeline{
    agent{
        kubernetes{
            inheritFrom "python-pod"
            cloud "kubernetes"
            defaultContainer "python-container"
        }
    }

    
    stages
    {
        /*
            Main step to build godot for all othe platforms
         */
        stage("Build all platforms"){
            matrix
            {
                axes
                {
                    axis
                    {
                        name 'PLATFORM'
                        values 'linux', 'windows'
                    }
                }
                stages
                {
                    stage ('Build') 
                    {                        
                        steps
                        {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE')
                            {
                                script
                                {
                                    //scons_platform = mapSconsPlatform(${PLATFORM})
                                    echo "${PLATFORM}"
                                }
                            }
                        }
                    }
                }
            }       
        }   
    }
}