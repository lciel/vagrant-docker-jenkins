vagrant-docker-jenkins
=====

Run a docker container with Jenkins installed on Vagrant.

## Usage

```
$ git clone https://github.com/lciel/vagrant-docker-jenkins.git
$ cd vagrant-docker-jenkins
$ vagrant up

(Wait serival minutes)

$ curl http://localhost:8888/
```

## Workspace

- Default workspace directory

```
vagrant-docker-jenkins/jenkins/data
```

- Change a workspace directory

```
$ vim Vagrantfile
JENKINS_WORKSPACE = "/path/to/host/directory/"
```
