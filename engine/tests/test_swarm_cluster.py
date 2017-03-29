# Test Docker Swarm

def test_docker_swarm_enabled(Command):

    assert 'Swarm: active' in Command.check_output('docker info')