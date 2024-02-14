[y, fs] = audioread('Word Intelligibility.wav');

numPassbands = 35;
x = separateAudio(numPassbands, y);

% figure
% plot(x(:, 1));
% figure
% plot(x(:, 12));

for i = 1:numPassbands
    x(:, i) = abs(x(:,i));
    x(:, i) = LowPassFilter().filter(x(:, i));
end

% figure
% plot(x(:, 1));
% figure
% plot(x(:, 12));

centralFrequencies = [];
cosWaves = [ ];
multiplier = nthroot(80,numPassbands);
for i = 1:numPassbands
    centralFrequencies(i) = sqrt((100*multiplier^(i-1))*(100*multiplier^(i)));
    [cosWaves(:, i), time] = createCosine(centralFrequencies(i), y, fs);
end

% plot(time, cosWaves(:, 1));
% axis([0 0.002 -1.5 1.5]);

amplitudeModulatedSignal = [];

for i = 1:numPassbands
    amplitudeModulatedSignal(:, i) = cosWaves(:, i) .* x(:, i);
end

outputSignal = sum(amplitudeModulatedSignal, 2);
sound(outputSignal, fs);

function separatedAudio = separateAudio(numPassbands, audioSignal)
    multiplier = nthroot(80,numPassbands);
    for i = 1:numPassbands    
        start = 100*multiplier^(i-1);
        newFilter = filterFunction(0.95*start, start, start * multiplier, 1.05* start * multiplier);
        separatedAudio(:, i) = newFilter.filter(audioSignal);
    end
end

function [cosineWave, t] = createCosine(frequency, audio, sampleRate)
    Ts=1/sampleRate;
    t=(0:Ts:length(audio)/sampleRate - Ts);
    
    a = [cos(2*pi*frequency*t)];
    a = a';
    
    cosineWave = a;
end

