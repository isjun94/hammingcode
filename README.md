# hammingcode
This code is MATLAB(tm) code that can encode, correct, decode binary message using general algorithm of Hamming code.

See https://en.wikipedia.org/wiki/Hamming_code#General_algorithm

1. Encode message using general algorithm of Hamming code
2. Modulation (BPSK, QAM) and channel simulation(AWGN)
3. Demodulation
4. Check and correct errors
5. Decode message
6. Comapre probability of error

Generate hamming matrix(parity-check matrix), part of hmGenerator(m), is inspired from https://kr.mathworks.com/matlabcentral/fileexchange/40208-hamming-code

and the author is Marc-Andre Robichaud Copyright (c) 2013, Marc-Andre Robichaud All rights reserved.
