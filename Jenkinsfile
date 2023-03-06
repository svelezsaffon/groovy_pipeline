def readPodTemplate(image_name)
{

    def pod = readFile(file: 'pod_templates/build_godto.yaml')
    
    return "${pod}".replace("{image_name}",image_name)
}

def deleteJob(items, jobsToDelete) {
    items.each { item ->
      if (item.class.canonicalName != 'com.cloudbees.hudson.plugins.folder.Folder') {
        if (jobsToDelete.contains(item.fullName)) {
          manager.listener.logger.println(item.fullName)
          item.delete()
        }
      }
    }
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
      post {
            always {
              script {
                  jobsToDelete = env.BUILD_ID
                  deleteJob(Hudson.instance.items, jobsToDelete)
              }
            }
    }
}