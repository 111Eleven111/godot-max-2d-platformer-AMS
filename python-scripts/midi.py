import mido
from mido import MidiFile, Message
import time

class DrumMidiSender:
    def __init__(self, port_name=None):
        """Initialize MIDI output to Max MSP"""
        try:
            if port_name:
                self.output = mido.open_output(port_name)
            else:
                self.output = mido.open_output()
            print(f"Connected to: {self.output.name}")
        except Exception as e:
            print(f"Error connecting to MIDI port: {e}")
            self.output = None
    
    def send_drum_note(self, note, velocity=100, duration=0.1):
        """Send a drum note on/off"""
        if not self.output:
            return
        
        # Note on
        self.output.send(Message('note_on', note=note, velocity=velocity))
        time.sleep(duration)
        # Note off
        self.output.send(Message('note_off', note=note))
    
    def send_drum_pattern(self, pattern):
        """Send a sequence of drum hits
        pattern: list of tuples (note, velocity, duration)
        """
        for note, velocity, duration in pattern:
            self.send_drum_note(note, velocity, duration)
    
    def close(self):
        """Close MIDI connection"""
        if self.output:
            self.output.close()

# Example usage
if __name__ == "__main__":
    sender = DrumMidiSender()
    
    # Send drum pattern (kick, snare, hi-hat)
    pattern = [(36, 100, 0.1), (38, 80, 0.1), (42, 60, 0.1)]
    sender.send_drum_pattern(pattern)
    
    sender.close()