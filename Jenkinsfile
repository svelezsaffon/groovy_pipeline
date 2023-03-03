def readPodTemplate(image_name)
{

    def pod = readFile(file: 'pod_templates/build_godto.yaml')
    
    return "${pod}".replace("{image_name}",image_name)
}

pipeline{


    parameters
    {

        password(name: 'GIT_TOKEN', defaultValue: '', description: 'Git repository deployment token')

    }

    agent
    {
        kubernetes
        {
            yamlFile 'pod_templates/build_godto.yaml'
        }
    }

    stages
    {

          stage('Pull Code no credentials')
          {
            when
            {
              environment name: 'GIT_TOKEN', value: ''
            }
            steps
            {
              dir('local_godot')
              {
                sh "echo 'No creds'"
              }
            }
          }

          stage('Pull Code credentials')
          {
            when
            {
              not
              {
                environment name: 'GIT_TOKEN', value: ''
              }
            }
            steps
            {
              dir('local_godot')
              {
                sh 'export token=$GIT_TOKEN'
                sh "../sh/helpers/url_parse.sh -r git@github.com/svelezsaffon/godot_docker.git"
              }
            }
          }

          stage("show all")
          {
            steps
            {
              dir('local_godot')
              {
                sh "ls -la"
              }              
            }
          }

    }
}