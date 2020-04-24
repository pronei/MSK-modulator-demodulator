import csv
import matplotlib.pyplot as plt
import numpy as np

mskData = np.genfromtxt('mskwave.txt', delimiter=',')
inputx, inputy, outputx, outputy = mskData[:, 0], mskData[:, 1], mskData[:, 2], mskData[:, 3]

plt.plot(inputx, inputy, 'b', label='digital input')
plt.plot(outputx, outputy, 'darkorange', label='Modulated wave')
plt.xlabel('time')
plt.ylabel('amplitude')
plt.legend(loc='upper left')
plt.show()