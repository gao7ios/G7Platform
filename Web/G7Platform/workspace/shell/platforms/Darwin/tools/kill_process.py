__author__ = 'yuyang'
import os, signal

def check_kill_process(pstring):
    for line in os.popen("ps ax | grep " + pstring + " | grep -v grep"):
        fields = line.split()
        pid = fields[0]
        os.kill(int(pid), signal.SIGKILL)

if __name__ == "__main__":
    check_kill_process("nginx")
    check_kill_process("uwsgi")
    check_kill_process("supervisord")
    check_kill_process("main.py")
    check_kill_process("php-fpm")
    check_kill_process("mysql")
