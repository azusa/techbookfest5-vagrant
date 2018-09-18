yum -y install ansible

CURRENT=$(cd $(dirname $0) && pwd)
cd $CURRENT

PYTHONUNBUFFERED=1 ANSIBLE_FORCE_COLOR=true ansible-playbook --limit="default" --inventory-file=localhost -v provision/localhost.yml