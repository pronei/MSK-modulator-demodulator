import csv
import matplotlib.pyplot as plt
import numpy as np

with open('mskwave.txt', 'r') as mskout:
    dump = csv.reader(mskout, delimiter=',')
    mskwave = dict()
    inputx, inputy, outputx, outputy = ([] for i in range(4))
    for line in dump:
        inputx.append(float(line[0]))
        inputy.append(int(line[1]))
        outputx.append(float(line[2]))
        outputy.append(float(line[3]))

plt.plot(inputx, inputy, 'b', label='digital input')
plt.plot(outputx, outputy, 'darkorange', label='Modulated wave')
plt.xlabel('time')
plt.ylabel('amplitude')
plt.legend(loc='upper left')
plt.show()
