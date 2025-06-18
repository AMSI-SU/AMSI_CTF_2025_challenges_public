import socket
import subprocess
import re

HOST = '0.0.0.0'
PORT = 4055

def sanitize_input(data):
    s = data.decode().strip()
    if re.fullmatch(r'\d{1,1000}', s):
        return s
    return None

def handle_client(conn):
    conn.sendall(b"Enter input : ")
    data = conn.recv(1024)
    clean = sanitize_input(data)
    if not clean:
        conn.sendall(b"Invalid input.\n")
        return

    try:
        result = subprocess.check_output(["./chal.bin", clean], timeout=5)
        conn.sendall(result)
    except subprocess.TimeoutExpired:
        conn.sendall(b"Execution timed out.\n")
    except :
        conn.sendall(b"Try again.\n")

def main():
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind((HOST, PORT))
        s.listen(1)
        print(f"Listening on {HOST}:{PORT}...")
        while True:
            conn, addr = s.accept()
            with conn:
                handle_client(conn)

if __name__ == "__main__":
    main()
