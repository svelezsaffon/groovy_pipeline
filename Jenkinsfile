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
        choice(name: 'PLATFORM', choices: ['windows', 'container2'], description: 'OS platform to be build for')
    }

    agent
    {
        kubernetes 
        {
            inheritFrom "python-pod"
            defaultContainer "python-${params.PLATFORM}"
            yaml k8stemplate("python:latest","python-${params.PLATFORM}")
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
                        scons_platform = mapSconsPlatform(params.PLATFORM)
                        sh("echo building ${scons_platform}")
                    }
                }
            }
        }
    }
    
}
