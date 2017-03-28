# Ansible Role - update

Handle system updates

Available on Ansible Galaxy: [pgkehle.update](https://galaxy.ansible.com/pgkehle/update)

## Requirements

None

## Role Variables

NA

## Dependencies

None

## Example Playbook

```yml
- hosts: all
  roles:
     - pgkehle.update
```

## Hacking

There is an included Vagrant setup for hacking on this module, but IP needs to be set.

```
cd tests
source .hack.sh
vagrant up
ansible-playbook test.yml
...
vagrant destroy
vagrant up
ansible-playbook test.yml -vvvv
...
```

## License

MIT

## Author Information

Paul Kehle  
@pgkehle ([twitter](https://twitter.com/pgkehle), [github](https://github.com/pgkehle), [linkedin](https://www.linkedin.com/in/pgkehle))
