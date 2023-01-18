def mapSconsPlatform(current_platform) {
  def platformList = [container2: "linux", windows: "windows"]

  def scons_plat=platformList.get(current_platform)

  return scons_plat ? scons_plat : "container2"
}


def readPodTemplate(image_name)
{

    def pod = readFile(file: 'pod_templates/build_godto.yaml')
    
    return "${pod}".replace("{image_name}",image_name)
}


pipeline
{

  parameters
  {
    string(name: 'BRANCH_NAME', defaultValue:'master', description: 'OS platform to be build for')

    choice(name: 'PLATFORM', choices: ['linux', 'windows'], description: 'OS platform to build for')

    string(name: 'REPO_URL', defaultValue:"https://github.com/godotengine/godot.git", description: 'OS platform to be build for')
  
    text(name: 'SCONS_PARAMS', defaultValue: 'production=yes arch=x86_64 verbose=no warnings=no progress=no target=editor', description: 'Additional scons parameters')
  }



  stages
  {

    stage("Pre configure")
    {
      agent
      {
        
        kubernetes 
        {
          defaultContainer 'podman-conatiner'
          yamlFile 'pod_templates/podman.yaml'
        }
      }

      stages
      {
        stage("Calculate image")
        {
          steps
          {
            script 
            {
              env.FINAL_IMAGE = "fedora:36"
            }        
          }

        }

        stage("print outside")
        {
          steps
          {
            script
            {
              sh("echo ${env.FINAL_IMAGE}")
            }        
          }
        }
      }

    }

    stage("Full build")
    {
      agent
      {
        kubernetes 
        {
          defaultContainer 'fed-builder'
          yaml readPodTemplate("${env.FINAL_IMAGE}")
        }
      }

      stages    
      {
          stage('Check Files')
          {
            when
            {
              expression { return fileExists ("sh/helpers/${params.PLATFORM}.sh") }
            }
            steps
            {
              sh "sh/helpers/${params.PLATFORM}.sh"
            }
          }

          stage('Clone Repo')
          {
            steps
            {
              dir('local_godot')
              {
                checkout
                (
                  [
                    $class: 'GitSCM',
                    branches: [[name: "origin/${params.BRANCH_NAME}"]],
                    //doGenerateSubmoduleConfigurations: false,
                    //extensions: [[$class: 'LocalBranch']],
                    submoduleCfg: [],
                    userRemoteConfigs: [
                      [
                        //credentialsId: 'bitwiseman_github',
                        url: "${params.REPO_URL}"
                      ]
                    ]
                  ]
                )
              }
            }
          }

          stage("install libs")
          {
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
              dir('local_godot'){
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE')
                {
                  script
                  {
                    scons_platform = mapSconsPlatform(params.PLATFORM)
                    sh("scons -j6 platform=linuxbsd ${params.SCONS_PARAMS}")
                  }
                }
              }
            }
          }
      } 

    }
  }
}
