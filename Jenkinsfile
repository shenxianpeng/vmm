pipeline{
    agent {
        node {
            label 'main-slave'
            customWorkspace '/agent/workspace/vm-check'
        }
    }
    environment {
        SERVER = credentials("server-credential")
    }
    parameters {
        string name: 'hostname', defaultValue: "", description: 'Input your full hostname you want to check. example abc.company.com'
    }

    triggers {
        cron '0 15 * * 1-5'    // run at every week day 15:00.
    }

    options {buildDiscarder(logRotator(numToKeepStr:'50'))}

    stages{
        stage("Checkout"){
            steps{
                checkout scm
            }
        }
        stage("Start to check"){
            steps{
                script {
                    sh """
                    chmod u+x vm-*.sh
                    sh vm-check-main.sh ${SERVER_USR} ${SERVER_PSW} ${params.hostname}
                    """
                    if (params.hostname.endsWith(".com") ) {
                        sh """
                        set +e
                        git status | grep vm-list.txt
                        if [ \$? -eq 0 ]; then
                            git remote -v
                            git remote remove origin
                            git remote add origin https://${USERNAME}:${PASSWORD}@github.com/shenxianpeng/vmm.git
                            git remote -v
                            git add $filePath
                            # if the file not change
                            git commit -m "add ${params.hostname} into vm-list.txt"
                            git push
                        fi
                        """
                    } else {
                        echo "no file need to check-in."
                    }
                }
            }
        }
        stage("Archive result"){
            steps {
                archiveArtifacts 'vm-check-result.log'
            }
        }
    }
    post{
        success {
            cleanWs()
        }
    }
}
