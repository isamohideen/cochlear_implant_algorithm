[y, fs] = audioread('Bohemian Rhapsody.wav');

numPassbands = 12;
x = separateAudio(numPassbands, y);

figure
plot(x(:, 1));
figure
plot(x(:, 12));

for i = 1:numPassbands
    x(:, i) = abs(x(:,i));
    x(:, i) = LowPassFilter().filter(x(:, i));
end

figure
plot(x(:, 1));
figure
plot(x(:, 12));

function separatedAudio = separateAudio(numPassbands, audioSignal)
    multiplier = nthroot(80,numPassbands);
    for i = 1:numPassbands    
        start = 100*multiplier^(i-1);
        newFilter = filterFunction(start - 10, start, start * multiplier, start * multiplier + 10);
        separatedAudio(:, i) = newFilter.filter(audioSignal);
    end
end

