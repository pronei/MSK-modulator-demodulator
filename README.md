# MSK-modulator-demodulator
[Minimum-shift keying (MSK)](https://en.wikipedia.org/wiki/Minimum-shift_keying) is a digital modulation technique, a variant of which was primarily used in the [GSM](https://en.wikipedia.org/wiki/GSM) mobile phone standard. The report and specifics of the modulator/demodulator are included [here](https://github.com/pronei/MSK-modulator-demodulator/blob/master/FinalReport-MSK.pdf).

## Implementation of the modulator in C
The following parameters are set by default as mentioned in the project report.
* Data rate = 2.4 kbit/s
* Carrier frequency = 1.8 kHz

### Usage
Compile using `gcc`. The modulated wave generated is stored in `mskwave.txt` as comma separated values. Plot using `python3 plotWave.py`.
### Dependencies
* [NumPy](https://pypi.org/project/numpy/)
* [Matplotlib](https://pypi.org/project/matplotlib/)

## Simulink
The `.slx` models are compatible with MATLAB R2015 and R2019.

