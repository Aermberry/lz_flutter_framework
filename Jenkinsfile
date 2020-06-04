pipeline {
  agent {
    label 'master'
  }
  options {
    skipStagesAfterUnstable()
    timeout(time: 1, unit: 'HOURS') 
  }
  environment {
    LZ_MAC_NODE_CREDS           = credentials('lz-mac-node-creds') // 这个环境变量不能删除，删除后 LZ_MAC_NODE_CREDS_PSW 会变成null
    GITLAB_SERVER_DOMAIN_NAME   = sh(script: 'jenkins/gitlab/get_gitlab_server_domain_name.sh', returnStdout: true).trim()
    GIT_SERVER_TOKEN            = credentials("${GITLAB_SERVER_DOMAIN_NAME}-token") // 根据gitlab server domain name获取gitlab api tokens

    APP_VERSION                 = sh(script: 'jenkins/scripts/get_app_version.sh', returnStdout: true).trim()
    PROJECT_NAME                = sh(script: 'jenkins/gitlab/get_project_name.sh', returnStdout: true).trim()
    // 用于获取项目成员列表，发送流水线运行结果邮件给项目成员
    PROJECT_MEMBER_EMAILS       = sh(script: 'jenkins/gitlab/get_project_member_emails.sh', returnStdout: true).trim()
    CHANGE_ID                   = sh(script: 'jenkins/gitlab/get_commit_id.sh --format=h', returnStdout: true).trim()
    CHANGE_URL                  = sh(script: 'jenkins/gitlab/get_commit_url.sh', returnStdout: true).trim()
    CHANGE_TITLE                = sh(script: 'jenkins/gitlab/get_commit_message.sh', returnStdout: true).trim()
    CHANGE_AUTHOR_DISPLAY_NAME  = sh(script: 'jenkins/gitlab/get_committer_name.sh', returnStdout: true).trim()
    CHANGE_AUTHOR_URL           = sh(script: 'jenkins/gitlab/get_committer_url.sh', returnStdout: true).trim()
    CHANGE_AUTHOR_EMAIL         = sh(script: 'jenkins/gitlab/get_committer_email.sh', returnStdout: true).trim()
  }
  stages {
    stage('Code Validation') {
      agent {
        label 'atxserver-android'
      }
      steps {
        sh 'echo skip'
        // sh 'jenkins/scripts/analyze_code.sh'
      }
    }
    stage('Package') {
      stages {
        stage('Package Dev') {
          when {
            expression { 
              env.BRANCH_NAME != 'master'
            }
          }
          environment {
            FLAVOR = 'dev'
          }     
          parallel {
            stage("Package Dev Android") {
              agent { 
                docker {
                  label 'atxserver-android'
                  image 'bchabord/flutter-android-docker'
                  args '-v android-sdk-cache:/opt/android-sdk-linux -v gradle-cache:/opt/android-sdk-linux/.gradle -v pub-cache:/opt/android-sdk-linux/.pub-cache'
                }
              }
              steps {
                sh "jenkins/scripts/package_android.sh --flavor=$FLAVOR"
                archiveArtifacts(sh(script: 'jenkins/scripts/get_android_package_path.sh --flavor=$FLAVOR', returnStdout: true).trim())
              }
              post {
                failure {
                  script {
                    env.FAILURE_STAGE_NAME = STAGE_NAME
                  }
                }
              }
            }

            stage("Package Dev iOS") {
              agent {
                label 'lz_mac_node'
              }
              steps {
                sh "jenkins/scripts/package_ios.sh --scheme=$FLAVOR --login_password=$LZ_MAC_NODE_CREDS_PSW"
                archiveArtifacts(sh(script: "jenkins/scripts/get_ios_package_path.sh --scheme=$FLAVOR", returnStdout: true).trim())
                archiveArtifacts "ios/ad_hoc_deploy_template/*"
              }
              post {
                failure {
                  script {
                    env.FAILURE_STAGE_NAME = STAGE_NAME
                  }
                }
              }
            }
          }
        } //end dev package stage

        stage('Package Uat') {
          when {
            branch 'master'
          }
          environment {
            FLAVOR = 'uat'
          }     
          parallel {
            stage("Package Uat Android") {
              agent { 
                docker {
                  label 'atxserver-android'
                  image 'bchabord/flutter-android-docker'
                  args '-v android-sdk-cache:/opt/android-sdk-linux -v gradle-cache:/opt/android-sdk-linux/.gradle -v pub-cache:/opt/android-sdk-linux/.pub-cache'
                }
              }
              steps {
                sh "jenkins/scripts/package_android.sh --flavor=$FLAVOR"
                archiveArtifacts(sh(script: 'jenkins/scripts/get_android_package_path.sh --flavor=$FLAVOR', returnStdout: true).trim())
              }
              post {
                failure {
                  script {
                    env.FAILURE_STAGE_NAME = STAGE_NAME
                  }
                }
              }
            }

            stage("Package Uat iOS") {
              agent {
                label 'lz_mac_node'
              }
              steps {
                sh "jenkins/scripts/package_ios.sh --scheme=$FLAVOR --login_password=$LZ_MAC_NODE_CREDS_PSW"
                archiveArtifacts(sh(script: "jenkins/scripts/get_ios_package_path.sh --scheme=$FLAVOR", returnStdout: true).trim())
                archiveArtifacts "ios/ad_hoc_deploy_template/*"
              }
              post {
                failure {
                  script {
                    env.FAILURE_STAGE_NAME = STAGE_NAME
                  }
                }
              }
            }
          }
        } //end uat package stage

        stage('Package Prod') {
          when {
            branch 'master'
          }
          environment {
            FLAVOR = 'prod'
          }     
          parallel {
            stage("Package Prod Android") {
              agent { 
                docker {
                  label 'atxserver-android'
                  image 'bchabord/flutter-android-docker'
                  args '-v android-sdk-cache:/opt/android-sdk-linux -v gradle-cache:/opt/android-sdk-linux/.gradle -v pub-cache:/opt/android-sdk-linux/.pub-cache'
                }
              }
              steps {
                sh "jenkins/scripts/package_android.sh --flavor=$FLAVOR"
                archiveArtifacts(sh(script: 'jenkins/scripts/get_android_package_path.sh --flavor=$FLAVOR', returnStdout: true).trim())
              }
              post {
                failure {
                  script {
                    env.FAILURE_STAGE_NAME = STAGE_NAME
                  }
                }
              }
            }

            stage("Package Prod iOS") {
              agent {
                label 'lz_mac_node'
              }
              steps {
                sh "jenkins/scripts/package_ios.sh --scheme=$FLAVOR --login_password=$LZ_MAC_NODE_CREDS_PSW"
                archiveArtifacts(sh(script: "jenkins/scripts/get_ios_package_path.sh --scheme=$FLAVOR", returnStdout: true).trim())
                archiveArtifacts "ios/ad_hoc_deploy_template/*"
              }
              post {
                failure {
                  script {
                    env.FAILURE_STAGE_NAME = STAGE_NAME
                  }
                }
              }
            }
          }
        } //end prod stage
      } // end stages inside package stages
    } //end package stage
  } //end stages

  post {
    always {
      script {
        email = load 'jenkins/groovy/email.groovy'
      }
    }
    success {
      script {
        email.sendPipelineSuccessEmail()
      }
    }
    failure {
      script {
        email.sendPipelineFailureEmail()
      }
    }
  }
}

