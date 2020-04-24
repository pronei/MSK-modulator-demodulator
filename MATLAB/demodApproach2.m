clc; clear; close;
Rb = 2400;
Tb = 1/Rb;
fc = 1800;
Fs = 2500000;

[signal, T, a, sampled] = modulateMSK(Tb,Rb,fc,Fs);
a(a == -1) = 0;

[pospeaks, pospindices] = findpeaks([0, signal, 0]);
[negpeaks, negpindices] = findpeaks([0, signal.*(-1), 0]);
negpeaks = negpeaks.*(-1);

if pospindices(end) > length(T)
    pospindices(end) = length(T);
end
if negpindices(end) > length(T)
    negpindices(end) = length(T);
end

if length(negpeaks) < length(pospeaks)
    indices = [pospindices; negpindices 0];
    peaks = [pospeaks; negpeaks 0];
    indices = indices(:)';
    indices = indices(1:end-1);
    peaks = peaks(:)';
    peaks = peaks(1:end-1);
else
    indices = [pospindices; negpindices];
    peaks = [pospeaks; negpeaks];
    indices = indices(:)';
    peaks = peaks(:)';
end

tdiffs = diff(T(indices));
tdiffsc = tdiffs;
tdiffs = round(tdiffs.*1e3, 1);

tstamps = zeros(1, 15);
output = zeros(1, 15);

k = 1;
j = 1;
N = length(tdiffs);
while j <= N
    curdiff = tdiffs(j);
    if j < N
        nextdiff = tdiffs(j + 1);
    end
    if curdiff == 0.2 && nextdiff == 0.2
        output(k) = 1;
        tstamps(k) = T(indices(j));
        j = j + 2;
    elseif curdiff == 0.4
        output(k) = 0;
        tstamps(k) = T(indices(j));
        j = j + 1;
    end
    k = k + 1;
end

square = signal.*signal;

subplot(2,2,1);
time = (0:length(a)-1)*Tb;
stairs(time,a);
ylim([-.5 1.5]);
xlabel('Time(s)'); ylabel('Amplitude'); title('Input digital signal');

subplot(2,2,2);
plot(T,signal);
xlabel('Time(s)'); ylabel('Amplitude'); title('MSK Modulated wave');
hold on;
subplot(2, 2, 2);
plot(T(indices), peaks, 'x');
legend('MSK', 'local extrema');
hold off;

disp(time);
disp(tstamps);
subplot(2, 2, 4);
stairs(tstamps, output);
ylim([-.5 1.5]);
xlabel('Time(s)');
ylabel('Demodulated wave output');
title('Output digital signal');

subplot(2, 2, 3);
stem(T(indices), [0 tdiffsc]);
xlabel('Time(s)');
ylabel('Magnitude');
title('Time differences between peaks');