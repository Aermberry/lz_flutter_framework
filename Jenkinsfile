pipeline {
  agent {
    label 'master'
  }
  options {
    skipStagesAfterUnstable()
    timeout(time: 1, unit: 'HOURS') 
    buildDiscarder(logRotator(daysToKeepStr: '15', numToKeepStr: '10', artifactDaysToKeepStr: '15', artifactNumToKeepStr: '10'))
  }
  environment {
    LZ_MAC_NODE_CREDS           = credentials('lz-mac-node-creds') // 这个环境变量不能删除，删除后 LZ_MAC_NODE_CREDS_PSW 会变成null
    ATX_SERVER_ACCESS_TOKEN     = credentials('ATX_SERVER_ACCESS_TOKEN') // 用于操作atxserver
    GITLAB_SERVER_DOMAIN_NAME   = sh(script: 'jenkins/gitlab/get_gitlab_server_domain_name.sh', returnStdout: true).trim()
    GIT_SERVER_TOKEN            = credentials("${GITLAB_SERVER_DOMAIN_NAME}-token") // 根据gitlab server domain name获取gitlab api tokens
    MATCH_PASSWORD              = credentials('MATCH_PASSWORD') // fastlane match的密码
    MATCH_KEYCHAIN_PASSWORD     = "${LZ_MAC_NODE_CREDS_PSW}"    // 让codesign进程读取keychain里的iOS证书
    FLAVOR                      = sh(script: 'jenkins/scripts/get_package_scheme.sh', returnStdout: true).trim()
  }
  stages {
    stage('审核') {
      agent {
        docker {
          label 'android-packer'
          image 'bchabord/flutter-android-docker'
          args '-v android-sdk-cache:/opt/android-sdk-linux -v gradle-cache-$EXECUTOR_NUMBER:/opt/android-sdk-linux/.gradle/caches'
        }
      }
      steps {
        sh 'jenkins/scripts/analyze_code.sh'
      }
    }
    
    stage('打包') {
      parallel {
        stage("Android") {
          agent { 
            docker {
              label 'android-packer'
              image 'bchabord/flutter-android-docker'
              args '-v android-sdk-cache:/opt/android-sdk-linux -v gradle-cache-$EXECUTOR_NUMBER:/opt/android-sdk-linux/.gradle/caches'
            }
          }
          steps {
            sh "jenkins/scripts/package_android.sh"
            archiveArtifacts('**/' + sh(script: 'jenkins/scripts/get_package_file_name.sh', returnStdout: true).trim() + '.*')
          }
          post {
            failure {
              script {
                env.FAILURE_STAGE_NAME = STAGE_NAME
              }
            }
          }
        } // end Pack Android

        stage("iOS") {
          agent {
            label 'ios-packer'
          }
          steps {
            sh "cd jenkins && pipenv install --dev" // 必须提前安装python依赖，不然之后的IOS_MIN_SDK_VERSION会拿到pipenv install的输出信息，而不是ios版本
            script {
              env.IOS_APP       = sh(returnStdout: true, script: "cd jenkins && pipenv run get_ios_app").trim()
              env.IOS_BUNDLE_ID = sh(returnStdout: true, script: "cd jenkins && pipenv run get_ios_bundle_id").trim()
            }
            sh "jenkins/scripts/package_ios.sh"
            archiveArtifacts(sh(script: "jenkins/scripts/get_ios_package_path.sh", returnStdout: true).trim())
            archiveArtifacts "ios/ad_hoc_deploy/*"
          }
          post {
            failure {
              script {
                env.FAILURE_STAGE_NAME = STAGE_NAME
              }
            }
          }
        } // end iOS
      } // end parallel stage
    } //end 打包 stage

    stage('UI测试') {
      parallel {
        stage("Android") {
          when {
            expression { sh(script: "jenkins/scripts/should_run_ui_test.sh", returnStdout: true).trim() == 'true' }
          }
          agent { 
            docker {
              label 'ui-tester'
              image 'registry.cn-shenzhen.aliyuncs.com/liangzhicn/pipenv:1.1'
              args '-v pipenv-cache:/home/python/.cache/pipenv'
            }
          }
          steps {
            sh "jenkins/scripts/android_ui_test.sh"
          }
          post {
            always {
              archiveArtifacts "android_report.tar.gz"
            }
            failure {
              script {
                env.FAILURE_STAGE_NAME = STAGE_NAME
              }
            }
          }
        } // end Android UI测试

        stage("iOS") {
          when {
            expression { sh(script: "jenkins/scripts/should_run_ui_test.sh", returnStdout: true).trim() == 'true' }
          }
          agent { 
            docker {
              label 'ui-tester'
              image 'registry.cn-shenzhen.aliyuncs.com/liangzhicn/pipenv:1.1'
              args '-v pipenv-cache:/home/python/.cache/pipenv'
            }
          }
          steps {
            sh "jenkins/scripts/ios_ui_test.sh"
          }
          post {
            always {
              archiveArtifacts "ios_report.tar.gz"
            }
            failure {
              script {
                env.FAILURE_STAGE_NAME = STAGE_NAME
              }
            }
          }
        } // end iOS UI测试
      } // end parallel stage
    } //end UI测试 stage

  } //end stages

  post {
    always {
      script {
        webhook = load 'jenkins/groovy/webhook.groovy'
        email = load 'jenkins/groovy/email.groovy'
      }
    }
    success {
      script {
        webhook.triggerSuccessWebhook()
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

