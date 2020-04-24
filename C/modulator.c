#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <limits.h>
#include <time.h>

typedef struct digital{
    float xval;
    int yval;
} digitalInput;

typedef struct wave{
	float xval, yval;
} MSKWave;

digitalInput *inputGenerator(int dataRate, int samplingFreq, int nBits)
{
    float Ts = 1/(float) samplingFreq, Tb = 1/(float) dataRate;
    float totalTime = nBits * Tb;
    int points = totalTime * samplingFreq;
    int bit, pointsTb = points/nBits;
    printf("Tb = %f\tTs = %f\ttotalTime = %f\tpoints = %d\tpointsTb = %d\n", Tb, Ts, totalTime, points, pointsTb);

    digitalInput *start = (digitalInput *) malloc(sizeof(digitalInput) * points);
    digitalInput *input_ptr = start;

    for (int i = 0; i < points; ++i)    {
        input_ptr->xval = (float) Ts * i;
        if ((i % pointsTb) == 0)
            bit = rand() % 2;
        input_ptr->yval = bit;
        input_ptr++;
    }
    return start;
}

MSKWave *MSKGenerator(digitalInput *inputWave, int inputSize, int carrierFreq, int dataRate, int samplingFreq, int amp){
	float Tb = 1/(float) dataRate;
	int pointsTb = samplingFreq/dataRate;
	int nBits = inputSize/pointsTb;
	int scaledDataRate = dataRate/4;

	MSKWave *start = (MSKWave *) malloc(sizeof(MSKWave) * inputSize);
	MSKWave *wave_ptr = start;

	float phase = 0;

	for (int i = 0; i < nBits; ++i)	{
		int k = i * pointsTb;
		int range = (i + 1) * pointsTb;
		int currentBit = (inputWave + k)->yval;
		for (; k < range; ++k)	{
			float t = (inputWave + k)->xval;
			wave_ptr->xval = t;
			wave_ptr->yval = amp * (float) cos(2*M_PI*(carrierFreq*t + currentBit*scaledDataRate*(t-i*Tb)) + phase);
			wave_ptr++;
		}
		phase = phase + currentBit * M_PI/2;
	}
	return start;
}					
						


int main()
{
    FILE *outputFile = fopen("mskwave.txt", "w");
	int Rb = 2400, Fc = 1800, Fs = Rb*100, nBits = 10;
	int points = nBits * Fs/Rb;

    srand(time(NULL));
    digitalInput *Arr1 = inputGenerator(Rb, Fs, nBits);
    MSKWave *Out1 = MSKGenerator(Arr1, points, Fc, Rb, Fs, 5);
	
	for(int i = 0; i < points; ++i)
        fprintf(outputFile, "%f,%d,%f,%f\n", Arr1[i].xval, Arr1[i].yval, Out1[i].xval, Out1[i].yval);

	return 0;
}
