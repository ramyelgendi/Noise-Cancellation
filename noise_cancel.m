%% Reset
clearvars;
close all;

%% Read & Play Original File
[f,Fs] = audioread('ILoveDSPtone.wav');
pOrig = audioplayer(f,Fs);
%pOrig.play; %P lay

%% Trial & Error Values
Fn = Fs/2;  % Frequency (Hz)
Wp = 3500/Fn; % Passband 
Ws = 9010/Fn; % Stopband
Rp =   1; % Passband Ripple
Rs = 200; % Stopband Ripple 

%% Tone
 % Chebyshev Type II filter order
[n,Ws] = cheb2ord(Wp,Ws,Rp,Rs);
[z,p,k] = cheby2(n,Rs,Ws,'low'); % Filter Design
[soslp,glp] = zp2sos(z,p,k); % equivalent to the transfer function H(z) whose n zeros, m poles
figure(3)
new = filtfilt(soslp, glp, f); % zero-phase digital filtering

%% Read & Play Original File
pFilter = audioplayer(new,Fs);
pFilter.play; %P lay
%audiowrite('New_ILoveDSPtone.wav',new,Fs);

%% Plot audio channels
T = 1 / Fs;             % Sampling period
L = length(f);          % Length of signal
t = (0:L-1) * T;        % Time vector
N = size(f, 1);
subplot(2,1,1);
plot(t, f);
 axis([0 2.5 -1.5 1.5]);  % From -0to 1 on X, and -20 to 50 on Y
title('Original: Time-domain');  xlabel('time(seconds)');
 

T = 1 / Fs;             % Sampling period
L = length(new);          % Length of signal
t = (0:L-1) * T;        % Time vector
N = size(v, 1);
subplot(2,1,2);
plot(t, new);
 axis([0 2.5 -1.5 1.5]);  % From -0to 1 on X, and -20 to 50 on Y
title('New: Time-domain');  xlabel('time(seconds)');
 
