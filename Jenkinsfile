def mapSconsPlatform(current_platform) {
  def platformList = [container2: "container2", windows: "windows"]

  def scons_plat=platformList.get(current_platform)

  return scons_plat ? scons_plat : "container2"
}

def k8stemplate(container_image,container_name) {
  return """
spec:
  containers:
  - args:
    - 9999999
    command:
    - sleep
    env:
    - name: JENKINS_URL
      value: http://jenkins.jec-sid.svc.cluster.local:8080/
    image: ${container_image}
    imagePullPolicy: IfNotPresent
    name: ${container_name}
    resources:
      limits: {}
      requests: {}
    tty: false
    volumeMounts:
    - mountPath: /home/jenkins/agent
      name: "workspace-volume"
      readOnly: false
    workingDir: /home/jenkins/agent
  imagePullSecrets:
  - name: private-registry
"""
}


pipeline{

    parameters
    {
        string(name: 'BRANCH_NAME', default:'master', description: 'OS platform to be build for')
    }

    agent
    {
        kubernetes 
        {
            inheritFrom "python-pod"
            defaultContainer "fed-${params.BRANCH_NAME}"
            yaml k8stemplate("fedora:36","fed-${params.BRANCH_NAME}")
        }
    }
    
    stages
    {
        stage('Pull')
        {
          steps
          {
            git branch: "${params.BRANCH_NAME}", url: "https://github.com/godotengine/godot.git"
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
                        sh("echo building ${scons_platform}")
                    }
                }
            }
        }
    }
    
}
