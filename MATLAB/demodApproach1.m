clc; clear; close;
Rb = 2400;
Tb = 1/Rb;
fc = 1800;
Fs = 2500000;

[signal, T, a, sampled] = modulateMSK(Tb, Rb, fc, Fs);
a(a == -1) = 0;

square = signal.*signal;
square1 = sampled.*sampled;
disp(length(sampled));
time = (0:length(sampled)-1)*(1/Fs);


part_one = square1(1:1000);
time_1 = time(1:1000);
time_1 = Fs*(0:1000-1)/1000;
fourier = abs(fft(part_one)/1000);

subplot(2,2,4);
plot(time_1,fourier);
xlabel('frequency bins');
ylabel('magnitude');
title('FFT output');
xlim([-.5e6 3e6]);

subplot(2,2,1);
time = (0:length(a)-1)*Tb;
stairs(time,a);
ylim([-.5 1.5]);
xlabel('Time(s)'); ylabel('Amplitude'); title('Input digital signal wave');

subplot(2,2,3);
plot(T,square);
title('Squared signal');

subplot(2,2,2);
plot(T,signal);  
xlabel('Time(s)'); ylabel('Amplitude'); title('MSK Modulated wave');