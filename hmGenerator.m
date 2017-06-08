function [H, G, R, n, k] = hmGenerator(m)

% Generate Hamming code matrices with general algorithm
%
% Author : Insung Jun
% Date : June 07. 2017
%
% H : parity-check matrix
% G : generator matrix
% n : block length
% k : message length

n = (2^m)-1;
k = n-m;

%% Generate [n x m] parity-check matrix H
H = zeros(m,n);
for X = 1:m
    for Y = 0:length(H)-1
        kk = Y<n/2^X;
        if kk
            Z = ((2^X)*Y+2^(X-1)):((2^X)*Y+(2^X)-1);
            H(X,Z) = 1;
        end
    end
end

%% Generate generator matrix G
% Extract parity matrix
for ii = 1:m    % ii : row number 1~k th row
    iii = 1;    % iii : column number
    cn = 0;     % H matrix column number
    for i=1:n   % H matrix column search
        if i == 2^cn
            cn = cn + 1;
            continue
        end
        gg(ii, iii) = H(ii, i);
        iii = iii + 1;
    end
end

% Combine parity matrix and identity matrix
gg = gg';
G = zeros(k,n);
I = eye(k);
cn = 1;     % H matrix parity column number
ii = 1;     % identity matrix column number
for i=1:n   % H matrix column search
    if i == 2^(cn-1)
        G(:, i) = gg(:, cn);
        cn = cn + 1;
        continue
    end
    G(:, i) = I(:, ii);
    ii = ii + 1;
end

G = G';

%% Generate recover matrix R
R = zeros(k,n);
I = eye(k);
cn = 1;     % H matrix parity column number
ii = 1;     % identity matirx column number
for i=1:n   % R matrix column search
    if i == 2^(cn-1)
        cn = cn + 1;
        continue
    end
    R(:, i) = I(:, ii);
    ii = ii + 1;
end