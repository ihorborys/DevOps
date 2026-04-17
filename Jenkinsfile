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
  - name: git
    image: alpine/git
    command: ["sleep"]
    args: ["9999999"]
"""
        }
    }

    environment {
        ECR_URL = "564415061836.dkr.ecr.us-west-2.amazonaws.com/django-app-repo"
        IMAGE_TAG = "v${BUILD_NUMBER}"
    }

    stages {
        stage('Build & Push to ECR') {
            steps {
                container('kaniko') {
                    // Kaniko збере образ і закине в ECR без Docker-демона
                    sh "/kaniko/executor --context . --dockerfile Dockerfile --destination ${ECR_URL}:${IMAGE_TAG}"
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

                            # Магія: міняємо тільки тег у нашому values.yaml
                            sed -i 's/tag: .*/tag: "${IMAGE_TAG}"/' charts/django-app/values.yaml

                            git add charts/django-app/values.yaml
                            git commit -m "Bump image version to ${IMAGE_TAG} [skip ci]"
                            git push https://${GIT_USER}:${GIT_PASS}@github.com/ТВІЙ_ЛОГІН/ТВІЙ_РЕПО.git HEAD:lesson-8-9
                        """
                    }
                }
            }
        }
    }
}