import argparse
import sys
from time import sleep
import simpleaudio as sa
import numpy as np

# This into a file.
def play_tune():
    """From https://simpleaudio.readthedocs.io/en/latest/tutorial.html#using-numpy"""
    # calculate note frequencies
    A_freq = 440
    Csh_freq = A_freq * 2 ** (4 / 12)
    E_freq = A_freq * 2 ** (7 / 12)

    # get timesteps for each sample, T is note duration in seconds
    sample_rate = 44100
    T = 0.25
    t = np.linspace(0, T, T * sample_rate, False)

    # generate sine wave notes
    A_note = np.sin(A_freq * t * 2 * np.pi)
    Csh_note = np.sin(Csh_freq * t * 2 * np.pi)
    E_note = np.sin(E_freq * t * 2 * np.pi)

    # concatenate notes
    audio = np.hstack((A_note, Csh_note, E_note))
    # normalize to 16-bit range
    audio *= 32767 / np.max(np.abs(audio))
    # convert to 16-bit data
    audio = audio.astype(np.int16)

    # start playback
    play_obj = sa.play_buffer(audio, 1, 2, sample_rate)

# Interface setup (puthis into a `parser` file and a class for error overridings).
parser = argparse.ArgumentParser(description='Timer with or without splits')
parser.add_argument('time_to_wait', action='store', type=int, help='The total time to wait in minutes')
parser.add_argument('-s', '--splits-time', dest='splits', action='store', type=int, default=None, help='Duration of splits in minutes')
if len(sys.argv)==1:
    parser.print_help()
    sys.exit(1)
args = parser.parse_args()


# The code (this into a function and a file).

# Convert  inputs from minutes into seconds.
splits = args.splits*60.0
total = args.time_to_wait*60.0

# Unsplitted timer.
if args.splits is None:
    sleep(total)
    print("Waiting " + str(args.time_to_wait))
    play_tune()
    print("Finished!")

# Splitted timer.
else:
    cumulative_wait = 0.0
    print("Waiting for a total of " + str(args.time_to_wait))
    while cumulative_wait < total:
        print("Waiting " + str(args.splits))
        sleep(splits)
        cumulative_wait += splits
        play_tune()
        print("Split reached!")
    print("Finished!")
