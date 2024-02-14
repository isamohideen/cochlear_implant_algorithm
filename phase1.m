load handel.mat %3.1

filename = 'Bohemian Rhapsody.mp3'; 

[sampleData,sampleRate] = audioread('Fire Alarm Sound.mp3');

[m,n] = size(sampleData); %3.2

if ( n==2 )
    y = sampleData(:, 1) + sampleData(:, 2); %sum(y, 2) also accomplishes this
    sampleData = y/max(abs(y));
else
    y = sampleData;
    sampleData = y/max(abs(y));
end

% sound(sampleData, sampleRate); %3.3

audiowrite("fire_alarm.wav",sampleData,sampleRate); %3.4

figure;
plot(sampleData);
title("Plotting Sound Waveform As Function of Sample Number");
ylabel("Sound Waveform Value");
xlabel("Sample Number");

if(sampleRate < 16000)
    disp("error: freq < 16kHz")
end

if(sampleRate > 16000)
    resampledData = resample(sampleData,16000,sampleRate);
end

% plot(resampledData);

Fs=44100;
Ts=1/Fs;
t=(0:Ts:490671/Fs);

a = [cos(2*pi*1000*t)];
a = a';

figure;
plot(t, a);
axis([0 0.002 -1.5 1.5]); 

% sound(a, Fs);