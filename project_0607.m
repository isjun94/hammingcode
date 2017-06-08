close all
clear all
clc

%% Parameter
m = 4;
data_size = 10000;

%% Simulation Parameters
ml = 1;         % Modulation Level : BPSK
M = 2^ml;
EbNo = 0:1:12;
u = length(EbNo);

for iii = 1:u           % ebn0 loop
    
    tic
    
    nloop = 100;       % # of simulation loop
    noe_bpsk = 0;       % # of awgn error
    noe_bpsk_hamm = 0;
    noe_qam = 0;
    noe_qam_hamm = 0;
    nod = 0;            % # of data
        
    SNR = 10^(EbNo(iii)/10);
    sgma = 1/sqrt(2*SNR);
    
    for ii = 1:nloop
        % Generate prbs data and encode the data using Hamming code
        % general algorithm
        [data, data_hamm] = encodeData(m, data_size);
        
        % BPSK MOD/DEMOD ( AWGN Channel )
        rdata_bpsk = bpsk_mod_demod(data, sgma);
        rdata_bpsk_hamm = bpsk_mod_demod(data_hamm, sgma);
        
        % QAM MOD/DEMOD ( AWGN Channel )
        rdata_qam = qam_mod_demod(data, EbNo(iii));
        rdata_qam_hamm = qam_mod_demod(data_hamm, EbNo(iii));
        
        % Hamming Code error correction and decode
        rdata_bpsk_hamm_deocded = cordecData(m, rdata_bpsk_hamm);
        rdata_qam_hamm_deocded = cordecData(m, rdata_qam_hamm);
        
        % Error calculation
        [err_bpsk(iii,ii), ber_bpsk] = biterr(rdata_bpsk, data);
        [err_bpsk_hamm(iii,ii), ber_bpsk_hamm] = biterr(rdata_bpsk_hamm_deocded, data);
        [err_qam(iii,ii), ber_qam] = biterr(rdata_qam, data);
        [err_qam_hamm(iii,ii), ber_qam_hamm] = biterr(rdata_qam_hamm_deocded, data);
        
        % Calculating BER
        noe_bpsk = noe_bpsk + err_bpsk(iii,ii);
        noe_bpsk_hamm = noe_bpsk_hamm + err_bpsk_hamm(iii,ii);
        noe_qam = noe_qam + err_qam(iii,ii);
        noe_qam_hamm = noe_qam_hamm + err_qam_hamm(iii,ii);
        nod = nod + length(data);
    end
    
    % Calculating probability of error
    pb_bpsk(iii) = noe_bpsk/nod;
    pb_bpsk_hamm(iii) = noe_bpsk_hamm/nod;
    pb_qam(iii) = noe_qam/nod;
    pb_qam_hamm(iii) = noe_qam_hamm/nod;
    theory_bpsk(iii) = (1/2)*erfc(sqrt(SNR));
    theory_qam(iii) = ((3/8)*erfc(sqrt((2/5)*SNR))-(9/64)*erfc(sqrt((2/5)*SNR)).^2);
    
    toc
    
end

%% Plot graph

figure(1)
semilogy(EbNo, theory_bpsk, 'k-o', EbNo, pb_bpsk, 'b-o', EbNo, pb_bpsk_hamm, 'r-o', EbNo, theory_qam, 'k-d', EbNo, pb_qam, 'b-d', EbNo, pb_qam_hamm, 'r-d')
grid on
xlabel('Eb/N0, dB')
ylabel('Probability of error')
legend('BPSK BER')
title('Comparison of BER when using Hamming Code[15,11] in BPSK & QAM')
axis([0 12 0.000000001 1])
legend('BPSK Theory', 'BPSK Simulation', 'Hamming Code BPSK Simulation', 'QAM Theory', 'QAM Simulation', 'Hamming Code QAM Simulation')