% logarithmic coefficients generation
%Pradeep Patil

%linspace(x,y,n)
% function divides numbers from 1 to 2 in 256 equal segments
l=linspace(1,2,256);  
%p = polyfit(x,y,n)
for i=1:(255)
    x(i,:)= linspace(l(i),l(i+1),256);
    %we use linspace here for generating accurate coefficients using
    %polyfit function
    coeff(i,:)=polyfit(x(i,:),log(x(i,:)),2);
    %this function gives us required co-efficients c0,c1,c2
    y(i,:)=polyval(coeff(i,:),l(i));
    %f= polyval(p,x)
    %this function gives us log value constructed from coefficients
    %generated in above function
end
coeff(256,:)=0;
y(256,:)=0;

% fi- fixed point function is used to store data to precesion fraction from
% generated coefficients to c0,c1,c2
c0=fi(coeff(:,3),1,30,28);
c1=fi(coeff(:,2),1,22,20);

c2=fi(coeff(:,1),1,13,11);

%saving coefficients to text file
file1=fopen('c0_log.txt','w');
file2=fopen('c1_log.txt','w');
file3=fopen('c2_log.txt','w');

for i=1:256 
    c0_log(i,:)=hex(c0(i));
    c1_log(i,:)=hex(c1(i));
    c2_log(i,:)=hex(c2(i));
    fprintf(file3, '%s  \n', c2_log(i,:));
    %this records data into a text file in column of hexadecimal numbers 
    fprintf(file2, '%s  \n', c1_log(i,:));
    fprintf(file1, '%s  \n', c0_log(i,:));
end
fclose(file1);
%this closes file after writing all coefficients
fclose(file2);
fclose(file3);

% Error analysis- 

for i=1:(256)

    z(i,1)=y(i,:)-log(l(i));
    % difference between generated value and original function
    if( z(i,1)<=(2^-29))
        display('function satisfied and coefficients are accurate')
    
    else
        display('coefficients are not accurate and final results may vary')
    end
end
