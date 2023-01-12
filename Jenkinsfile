def mapSconsPlatform(current_platform) {
  def platformList = [linux: "linuxbsd", windows: "windows"]

  def scons_plat=platformList.get(current_platform)

  return scons_plat ? scons_plat : "linuxbsd"
}


pipeline{
    /*
        Configuration parameters

        -   BASE_DISTRIBUTION: BAse OS distribution version
        
        -   BUILD_CONTAINER_NAME: Overide the build container name
    */
    parameters
    {
        choice(name: 'PLATFORM', choices: ['container', 'container2'], description: 'OS platform to be build for')
    }

    agent
    {
        kubernetes 
        {
            inheritFrom "GodotBuilder"
            defaultContainer "godot-builder-${params.PLATFORM}"
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
                        scons_platform = mapSconsPlatform("${params.PLATFORM}")
                        sh("echo building ${scons_platform}")
                        
                    }
                }
            }
        }
    }
    
}
