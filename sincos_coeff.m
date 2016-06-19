% cos/sin coefficients generation
%Pradeep Patil

%linspace(x,y,n)
% function divides numbers from 1 to 2 in 256 equal segments
l=linspace(1,1-2^-14,256);  
%p = polyfit(x,y,n)
for i=1:(127)
    x(i,:)= linspace(l(i),l(i+1),256);
    %we use linspace here for generating accurate coefficients using
    %polyfit function
    coeff(i,:)=polyfit(x(i,:),cos(x(i,:)*pi/2),2);
    %this function gives us required co-efficients c0,c1
    y(i,:)=polyval(coeff(i,:),l(i));
    %f= polyval(p,x)
    %this function gives us cos value constructed from coefficients
    %generated in above function
end
coeff(128,:)=0;
y(128,:)=0;

% fi- fixed point function is used to store data to precision fraction from
% generated coefficients to c0,c1,c2
c0=fi(coeff(:,1),1,19,14);
c1=fi(coeff(:,2),1,12,7);

%saving coefficients to text file
file1=fopen('c0_sincos.txt','w');
file2=fopen('c1_sincos.txt','w');

for i=1:128 
    c1_log(i,:)=hex(c0(i));
    c0_log(i,:)=hex(c1(i));
    %this records data into a text file in column of hexadecimal numbers 
    fprintf(file2, '%s  \n', c1_log(i,:));
    fprintf(file1, '%s  \n', c0_log(i,:));
end
fclose(file1);
%this closes file after writing all coefficients
fclose(file2);

% Error analysis- 

for i=1:(128)

    z(i,1)=y(i,:)-cos(l(i));
    % difference between generated value and original function
    if( z(i,1)<=(2^-17))
        display('function satisfied and coefficients are accurate')
    
    else
        display('coefficients are not accurate and final results may vary')
    end
end
