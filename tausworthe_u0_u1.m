function y= tausworthe_u0_u1(seed1,seed2,seed3,seed4,seed5,seed6,n)

% seed inputs unsigned 32bit
urng_seed1 = fi(hex2dec(seed1), 0, 32, 0);
urng_seed2 = fi(hex2dec(seed2), 0, 32, 0);
urng_seed3 = fi(hex2dec(seed3), 0, 32, 0);
urng_seed4 = fi(hex2dec(seed4), 0, 32, 0);
urng_seed5 = fi(hex2dec(seed5), 0, 32, 0);
urng_seed6 = fi(hex2dec(seed6), 0, 32, 0);
%tausworthe intermediate values
int = fi(0, 0, 32, 0);


% constants used in tausworthe
a= fi(hex2dec('FFFFFFFE'), 0, 32, 0);
b= fi(hex2dec('FFFFFFF8'), 0, 32, 0);
c= fi(hex2dec('FFFFFFF0'), 0, 32, 0);
u0= fi(0, 0, 48, 0);
u1= fi(0, 0, 16, 0);


 for i=1:n
    % Tausworthe logic block
    int = bitsrl(bitxor(bitsll(urng_seed1, 13), urng_seed1),19);
    urng_seed1 = bitxor(bitsll(bitand(urng_seed1,a),12),int);

    int = bitsrl(bitxor(bitsll(urng_seed2, 2), urng_seed2),25);
    urng_seed2 = bitxor(bitsll(bitand(urng_seed2,b),4),int);

    int = bitsrl(bitxor(bitsll(urng_seed3, 3), urng_seed3),11);
    urng_seed3 = bitxor(bitsll(bitand(urng_seed3,c),17),int);
    
    Taus1 = bitxor(bitxor(urng_seed1,urng_seed2),urng_seed3);

    int = bitsrl(bitxor(bitsll(urng_seed4, 13), urng_seed4),19);
    urng_seed4 = bitxor(bitsll(bitand(urng_seed4,a),12),int);

    int = bitsrl(bitxor(bitsll(urng_seed5, 2), urng_seed5),25);
    urng_seed5 = bitxor(bitsll(bitand(urng_seed5,b),4),int);

    int = bitsrl(bitxor(bitsll(urng_seed6, 3), urng_seed6),11);
    urng_seed6 = bitxor(bitsll(bitand(urng_seed6,c),17),int);
    
    Taus2 = bitxor(bitxor(urng_seed4,urng_seed5),urng_seed6);

    u0.bin = [Taus1.bin, Taus2.bin(17:32)];
    u1.bin = Taus2.bin(1:16);
    
    y(i,:)= {u0.hex, u1.hex};

 end
 file1=fopen('taus_u0.txt','w');
file2=fopen('taus_u1.txt','w');

for i=1:n
    %this records data into a text file in column of hexadecimal numbers 
    fprintf(file1, '%s  \n', y{i,1});
    fprintf(file2, '%s  \n', y{i,2});
end
fclose(file1);
%this closes file after writing all coefficients
fclose(file2);


end