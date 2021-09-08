## install
install ansible: https://www.guru99.com/ansible-tutorial.html#6

## ansible commands

### ad-hoc commands
```
ansible -i hosts web -m raw -a "sudo apt-get -y update && sudo apt-get install -y python"
ansible -i hosts web -m ping

ansible web -m copy -a "src=./hosts dest=/tmp/testfile"

ansible web -m apt -a "name=python3.7 state=present" -b
ansible web -m apt -a "name=git state=latest" -b

# install nginx
ansible web -m apt -a "name=nginx state=present" -b
ansible web -m service -a "name=nginx status=started" -b

# install nodejs
ansible web -m apt -a "name=nodejs state=present" -b
ansible web -m apt -a "name=npm state=present" -b
```

### ansible-playbook with --tags
```
ansible-playbook playbooks/nodejs_example.yaml --tags "docker-compose-copy-files"
ansible-playbook playbooks/nodejs_example.yaml --tags "docker-compose-copy-files, docker-compose-up"

ansible web02 -m shell -a "docker-compose -f /home/ubuntu/mycode/nodejs-todolist/docker-compose.yaml down"
```

### ansible-playbook with --tags and --limit 
```
ansible-playbook playbooks/nodejs_example.yaml --tags "docker-compose-up" --limit web01
ansible-playbook playbooks/nodejs_example.yaml --tags "docker-compose-down" --limit web02
```
