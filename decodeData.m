function [data_decoded] = decodeData(m, data_hamm_rx)
% Decode Hamming code using general algorithm
%
% Author : Insung Jun
% Date : June 07. 2017
%
% Generate matrices for hamming coding
[~, ~, R, n, ~] = hmGenerator(m);
% H : parity-check matrix
% G : generator matrix
% n : block length
% k : message length

data_hamm_rx = reshape(data_hamm_rx, n, []);

%% Decode data
% Decode the matrix
data_hamm_decoded = R * data_hamm_rx;
data_decoded = reshape(data_hamm_decoded, [], 1);