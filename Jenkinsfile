def readPodTemplate(image_name)
{

    def pod = readFile(file: 'pod_templates/build_godto.yaml')
    
    return "${pod}".replace("{image_name}",image_name)
}

pipeline{


    parameters
    {

        text(name: 'GIT_TOKEN', defaultValue: '', description: 'Git repository deployment token')

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

          stage('erase_parameters')
          {
            steps
            {
              script
              {
                env.HIDDEN_TOKEN=params.GIT_TOKEN
                params.GIT_TOKEN=''
              }
            }
          }

          stage('Pull Code no credentials')
          {
            when
            {
              environment name: 'GIT_THIDDEN_TOKENOKEN', value: ''
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
                environment name: 'HIDDEN_TOKEN', value: ''
              }
            }
            steps
            {
              dir('local_godot')
              {
                 sh('../sh/helpers/token.sh -r git@github.com:svelezsaffon/private_godot.git -b master')
                //sh('../sh/helpers/url_parse.sh -r git@github.com:svelezsaffon/private_godot.git -b master')
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