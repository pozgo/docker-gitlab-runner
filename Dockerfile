FROM polinux/centos-supervisor

ENV GITLAB_CE_RUNNER_VERSION=11.4.2 \
    RUNNER_NAME=name \
    RUNNER_URL='http://my-gitlab.com' \
    RUNNER_REGISTRATION_TOKEN=token \
    RUNNER_EXECUTOR=shell \
    RUNNER_EXTRA_PARAMS='' \
    CI_TEST_MODE='false'

RUN \
  rpm --rebuilddb && yum clean all && yum update -y && \
  yum install -y \
    git \
    wget \
    sudo && \
  wget -O /bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/v${GITLAB_CE_RUNNER_VERSION}/binaries/gitlab-runner-linux-amd64 && \
  chmod +x /bin/gitlab-runner && \
  useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash && \
  yum clean all && rm -rf /var/cache/yum

COPY container-files /

EXPOSE 2375