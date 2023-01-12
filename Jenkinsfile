def mapSconsPlatform(current_platform) {
  def platformList = [linux: "linuxbsd", windows: "windows"]

  def scons_plat=platformList.get(current_platform)

  return scons_plat ? scons_plat : "linuxbsd"
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
        choice(name: 'PLATFORM', choices: ['container', 'container2'], description: 'OS platform to be build for')
    }

    agent
    {
        kubernetes 
        {
            inheritFrom "python-pod"
            defaultContainer "python-${params.PLATFORM}"
            yaml k8stemplate("python:3.11.1-alpine","python-${params.PLATFORM}")
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
