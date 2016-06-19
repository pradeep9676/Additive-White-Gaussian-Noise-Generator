function y= tausworthe(seed1,seed2,seed3,n)

% seed inputs unsigned 32bit
urng_seed1 = fi(hex2dec(seed1), 0, 32, 0);
urng_seed2 = fi(hex2dec(seed2), 0, 32, 0);
urng_seed3 = fi(hex2dec(seed3), 0, 32, 0);
%tausworthe intermediate values
int = fi(0, 0, 32, 0);


% constants used in tausworthe
a= fi(hex2dec('FFFFFFFE'), 0, 32, 0);
b= fi(hex2dec('FFFFFFF8'), 0, 32, 0);
c= fi(hex2dec('FFFFFFF0'), 0, 32, 0);


 for i=1:n
    % Tausworthe logic block
    int = bitsrl(bitxor(bitsll(urng_seed1, 13), urng_seed1),19);
    urng_seed1 = bitxor(bitsll(bitand(urng_seed1,a),12),int);

    int = bitsrl(bitxor(bitsll(urng_seed2, 2), urng_seed2),25);
    urng_seed2 = bitxor(bitsll(bitand(urng_seed2,b),4),int);

    int = bitsrl(bitxor(bitsll(urng_seed3, 3), urng_seed3),11);
    urng_seed3 = bitxor(bitsll(bitand(urng_seed3,c),17),int);
    
    Taus = bitxor(bitxor(urng_seed1,urng_seed2),urng_seed3);

    y(i,:)  = hex(Taus);
 end
 
% save tausworthe URNG to file 
 file1=fopen('taus_urng.txt','w');
 for i=1:n
         fprintf(file1, '%s  \n', y(i,:));
 end
 fclose(file1);

end