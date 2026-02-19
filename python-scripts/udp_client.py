# OSC settings
SEND_OSC = True   # set False to dry-run (print only)
MAX_IP,  MAX_PORT  = "192.168.1.2", 5004

# Try to import python-osc (graceful fallback)
osc_ok = False
try:
    from pythonosc.udp_client import SimpleUDPClient
    osc_ok = True
except Exception:
    SEND_OSC = False  # no python-osc; fall back to prints

def make_clients():
    if not (SEND_OSC and osc_ok):
        return None, None
    maxc = SimpleUDPClient(MAX_IP, MAX_PORT) # ifconfig en0 | grep "inet " | awk '{print $2}' for local IP on mac
    return maxc

def send_midi_osc(max_client, msg):
    if SEND_OSC and max_client:
        max_client.send_message("/midi", msg)
    else:
        print(f"Could not send {msg}")