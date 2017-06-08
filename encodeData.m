function [data, data_hamm] = encodeData(m, data_size)
% Encode Hamming code using general algorithm
%
% Author : Insung Jun
% Date : June 07. 2017
%
% Generate matrices for hamming coding
[~, G, ~, ~, k] = hmGenerator(m);
% H : parity-check matrix
% G : generator matrix
% R : recover matrix
% n : block length
% k : message length

nd = k*data_size;   % Number of data
data = randi([0, 1], 1, nd);
data_reshape = reshape(data, k, []);

% Encode data
data_hamm = G * data_reshape;
data_hamm = rem(data_hamm, 2);
data_hamm = reshape(data_hamm, 1, []);