#!/usr/bin/env python
#
#   Original code: https://github.com/ansible/ansible-container/blob/develop/container/templates/wait_on_host.py
#   md5 sum: f09d87900fdc47e57119651847eba740
#

from __future__ import print_function

import sys
import json
import logging
import argparse
import subprocess

from time import sleep
from six import iteritems
from subprocess import CalledProcessError, STDOUT

logger = logging.getLogger(__name__)


def wait_on_state(containers, state, max_attempts=3, sleep_time=1):
    '''
    Wait for a container to have a specific state
    :param hosts: The list of container names
    :param state: The container state
    :param max_attempts: The number of times to inspect the container state
    :param sleep_time: Number of seconds to wait between attempts
    :return: dict of container:state
    '''
    results = {}
    for container in containers:
        logger.info('Checking the container status: {}'.format(container))
        tries = max_attempts
        container_ready = False
        output = None
        results[container] = False
        while tries > 0 and not container_ready:
            try:
                output = subprocess.check_output(["docker", "inspect", "--format", "{{ .State.Status }}",
                                                  container], stderr=STDOUT)
            except CalledProcessError:
                pass
            tries -= 1

            if output and state in output.upper().strip():
                results[container] = output.upper().strip()
                container_ready = True
            else:
                results[container] = 'unknown'.upper()
                sleep(sleep_time)
    return results


if __name__ == '__main__':

    parser = argparse.ArgumentParser(
        prog='wait_on_host',
        description='Wait for a container or list of containers to be in a specific state'
    )
    parser.add_argument(
        '--max-attempts', '-m', type=int, action='store', default=3,
        help=u"number of attempts at checking a container's state, defaults to 3"
    )
    parser.add_argument(
        '--sleep-time', '-s', type=int, action='store', default=1,
        help=u'number of seconds to wait between attempts, defaults to 1'
    )
    parser.add_argument(
        '--output', '-o', type=str, default='logs',
        help=u'output format, possible values: logs (default), json'
    )
    parser.add_argument(
        '--logging', '-l', type=str, default='INFO',
        help=u'loogging level, default: INFO'
    )
    parser.add_argument(
        'container', nargs='+', type=str,
        help=u'name of the container to wait on'
    )
    parser.add_argument(
        'status', type=str,
        help=u'status of the container to wait on'
    )
    args = parser.parse_args()

    log_level = getattr(logging, args.logging.upper(), None)
    if not isinstance(log_level, int):
        raise ValueError('Invalid log level: %s' % log_level)
    logging.basicConfig(
        format='%(asctime)-15s [%(levelname)s] %(message)s',
        level=log_level
    )

    if args.container and args.status:
        results = wait_on_state(
            args.container,
            args.status.upper(),
            max_attempts=args.max_attempts,
            sleep_time=args.sleep_time
        )
        for container, state in iteritems(results):
            logging.info("Container: {0}, state: {1}".format(container, state))

        if args.output == 'json':
            print(json.dumps(results))

        containers_with_status = sum([1 for c, s in iteritems(results)
            if s.upper() == args.status.upper()])

        if containers_with_status != len(args.container):
            sys.exit(1)
        else:
            sys.exit(0)
