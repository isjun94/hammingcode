function [demodata] = qam_mod_demod(data, ebn0)

ml = 4;
Kmod = 1/sqrt(10);
M = 16;

% 16 QAM modulation
data1 = reshape(data, ml, length(data)/ml);         % reshape : Reshape array. (ex 1x100 matrix -> 4*25 matrix)
data2 = bi2de(data1', 'left-msb');                  % bi2de : Convert binary vectors to decimal numbers.
qamdata = qammod(data2, M, 0, 'gray');
qamdata = Kmod.*qamdata.';

% AWGN Channel

awg_data_ch = awgn(qamdata, ebn0+10*log10(ml), 'measured', [], 'dB');

% 16 QAM demodulation
demodata1 = awg_data_ch./Kmod;
demodata2 = qamdemod(demodata1.', M, 0, 'gray');
demodata3 = de2bi(demodata2, ml, 'left-msb');
demodata = reshape(demodata3', 1, length(demodata3)*ml);