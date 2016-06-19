% Box-muller method for generating gaussian noise samples

% Pradeep Patil

function y= boxmuller(urng_seed1,urng_seed2,urng_seed3,urng_seed4,urng_seed5,urng_seed6,n)



a=fi(0,0,32,0);
b=fi(0,0,32,0);
%Log Input
%Sin/Cos Input
   
u1= fi(0,0,16,16);
u0= fi(0,0,48,48);



a= tausworthe_u0_u1(urng_seed1,urng_seed2,urng_seed3,urng_seed4,urng_seed5,urng_seed6,n);
    % concatenated u0,u1   
   u0.bin=dec2bin(hex2dec(a(:,1)));
   u1.bin=dec2bin(hex2dec(a(:,2)));
  % defining width and fraction accuracy for intermediate values used in
  % boxmuller architecture
  % defined according to IEEE BoxMuller architecture
    e = fi(0, 0, 31, 24); 
    f = fi(0, 0, 17, 13);
    g0 = fi(0, 1, 16,15);
    g1 = fi(0, 1, 16,15);
    x0 = fi(0, 1, 16, 11);
    x1 = fi(0, 1, 16, 11);  
  
     % Boxmuller architecture AWGN output generator
for i=1:n
    %e is log output
    e.data=(-2)*log(u0.data(i));
    %f is square root output
    f.data = sqrt(e.data);
    %g0, g1 are sin and cos outputs
    g0.data = sin(2*pi*u1.data(i));
    g1.data = cos(2*pi*u1.data(i));
    %x0, x1 are awgn outputs 
    x0.data = f.data * g0.data;
    x1.data = f.data * g1.data;
    %output is stored in y 
    y(i,:)={x0.bin, x1.bin};
end
file1=fopen('x0_bm.txt','w');
file2=fopen('x1_bm.txt','w');

for i=1:n
    %this records data into a text file in column of hexadecimal numbers 
    fprintf(file1, '%s  \n', y{i,1});
    fprintf(file2, '%s  \n', y{i,2});
end
fclose(file1);
%this closes file after writing all coefficients
fclose(file2);
end
