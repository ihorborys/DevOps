pipeline {
    agent {
        kubernetes {
            yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug
    command: ["sleep"]
    args: ["9999999"]
    volumeMounts:
      - name: kaniko-secret
        mountPath: /kaniko/.docker
  - name: git
    image: alpine/git
    command: ["sleep"]
    args: ["9999999"]
  volumes:
    - name: kaniko-secret
      secret:
        # Цей секрет ми створимо в наступному кроці
        secretName: kaniko-secret
        items:
          - key: .dockerconfigjson
            path: config.json
"""
        }
    }

    environment {
        ECR_URL = "564415061836.dkr.ecr.us-west-2.amazonaws.com/django-app-repo"
        IMAGE_TAG = "v${BUILD_NUMBER}"
        # Заміни на свій реальний репозиторій
        GIT_REPO_URL = "github.com/ihorborys/DevOps.git"
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Виправляємо помилку "порожнього контексту": клонуємо код у workspace
                checkout scm
            }
        }

        stage('Build & Push to ECR') {
            steps {
                container('kaniko') {
                    # Використовуємо ${WORKSPACE}, щоб Kaniko точно бачив клонований код
                    sh "/kaniko/executor --context ${WORKSPACE} --dockerfile Dockerfile --destination ${ECR_URL}:${IMAGE_TAG}"
                }
            }
        }

        stage('Update Helm Tag in Git') {
            steps {
                container('git') {
                    withCredentials([usernamePassword(credentialsId: 'github-token', passwordVariable: 'GIT_PASS', usernameVariable: 'GIT_USER')]) {
                        sh """
                            git config user.email "jenkins@rapidfire.com"
                            git config user.name "Jenkins CI"

                            sed -i 's/tag: .*/tag: "${IMAGE_TAG}"/' charts/django-app/values.yaml

                            git add charts/django-app/values.yaml
                            git commit -m "Bump image version to ${IMAGE_TAG} [skip ci]"
                            git push https://${GIT_USER}:${GIT_PASS}@${GIT_REPO_URL} HEAD:lesson-8-9
                        """
                    }
                }
            }
        }
    }
}