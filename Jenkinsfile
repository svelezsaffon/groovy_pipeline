def mapSconsPlatform(current_platform) {
  def platformList = [container2: "container2", windows: "windows"]

  def scons_plat=platformList.get(current_platform)

  return scons_plat ? scons_plat : "container2"
}

pipeline{

    parameters
    {
        string(name: 'BRANCH_NAME', defaultValue:'master', description: 'OS platform to be build for')

        string(name: 'REPO_URL', defaultValue:"https://github.com/godotengine/godot.git", description: 'OS platform to be build for')
    }

    environment
    {


      image_name='fedora:35'
    }

    agent
    {
        kubernetes 
        {
            //inheritFrom "python-pod"
            defaultContainer "fed-builder"
            //yaml k8stemplate("fedora:36","fed-builder")
            yamlFile 'pod_templates/build_godto.yaml'
        }
    }
    
    stages
    {
        stage('Clone Repo')
        {
          steps
          {
            git branch: "${params.BRANCH_NAME}", url: "${params.REPO_URL}"
          }
        }

        stage("install libs"){
          steps
          {
            
            sh 'dnf -y install scons pkgconfig libX11-devel libXcursor-devel libXrandr-devel libXinerama-devel'
            sh 'dnf -y install libXi-devel mesa-libGL-devel mesa-libGLU-devel alsa-lib-devel pulseaudio-libs-devel'
            sh 'dnf -y install libudev-devel yasm gcc-c++ libstdc++-static libatomic-static'
            
          }
        }

        stage ('Build') 
        {
          
            steps
            {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE')
                {
                    script
                    {
                        scons_platform = mapSconsPlatform(params.PLATFORM)
                        sh("scons -j8 platform=linuxbsd")
                    }
                }
            }
        }
    }
    
}
