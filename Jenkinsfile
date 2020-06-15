def gitCommit(){
    withCredentials([usernamePassword(credentialsId: "github-credential", passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
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
    }
}
pipeline{
    agent {
        label 'master'
    }
    environment {
        GITHUB = credentials("github-credential")
    }
    parameters {
        string name: 'hostname', defaultValue: "", description: 'Input your full hostname you want to check. example abc.company.com'
        booleanParam(defaultValue: false, name: 'remove', description: 'If selected, means you want to remove above hostname')
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
                    sh "chmod u+x vm-*.sh"
                    if (params.hostname.isEmpty()) {
                        // case 1: just run hostname in the list
                        sh "vm-check-main.sh ${GITHUB_USR} ${GITHUB_PSW} ${params.hostname}"
                    else if (params.hostname.endsWith(".com")) {
                        if (params.remove) {
                            // remove hostname from list, then run and commit into git.
                            sh "vm-check-main.sh ${GITHUB_USR} ${GITHUB_PSW} ${params.hostname} 1"
                            gitCommit("vm-list.txt", "remove ${params.hostname} from vm-list.txt")
                        } else  {
                            // add hostname from the list, then run and commit into git.
                            sh "vm-check-main.sh ${GITHUB_USR} ${GITHUB_PSW} ${params.hostname}"
                            git.Commit("vm-list.txt", "add ${params.hostname} into vm-list.txt")
                        }
                    } else {
                        error 'your input hostname looks like not full name, plese double check.'
                    }
                }
            }
        }
        stage("Archive result"){
            steps {
                // save below files for user check
                archiveArtifacts 'vm-check-result.log'
                archiveArtifacts 'vm-list.txt'
            }
        }
    }
    post{
        success {
            cleanWs()
        }
    }
}
