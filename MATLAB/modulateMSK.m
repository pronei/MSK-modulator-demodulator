function [signal, T, a, sampled] = modulateMSK(Tb, Rb, fc, Fs)
    a = [1 0 1 0 1 0 1 0 1 0 1 0 1 0 1];
    %a = randi([0, 1], 1, 15);
    a(a == 0) = -1;
    n = 0 : 1 : length(a)-1;
    signal = [];
    T = [];
    theta = 0;
    sampled = [];
    
    for i=n
    t = i*Tb:1e-6:(i+1)*Tb;
    %disp(length(t));
    k = s(t,Rb,Tb,fc,i,a(i+1),theta);
    signal = [signal k];
    T = [T t];
    Ts = 1/Fs;
    Time = i*Tb:Ts:(i+1)*Tb;
    sampled = [sampled, s(Time,Rb,Tb,fc,i,a(i+1),theta)];
    theta = theta + a(i+1)*pi/2;
    end
end

    
function y = s(t,Rb,Tb,fc,n,a,theta)
    y = 5*cos(2*pi*fc*t + 2*pi*a*(Rb/4)*(t-n*Tb) + theta);
end