% square root coefficients generation
%Pradeep Patil

%linspace(x,y,n)
% function divides numbers from 1 to 4 in 256 equal segments
a=linspace(1,2,65);  
b=linspace(2,4,65);  

%p = polyfit(x,y,n)
for i=1:(64)
    x(i,:)= linspace(a(i),a(i+1),128);
    w(i,:)=linspace (b(i),b(i+1),128);
    %we use linspace here for generating accurate coefficients using
    %polyfit function
    coeff1(i,:)=polyfit(x(i,:),log(x(i,:)),1);
    coeff2(i,:)=polyfit(w(i,:),log(w(i,:)),1);

    %this function gives us required co-efficients c0,c1,c2
    y(i,:)=polyval(coeff1(i,:),a(i));
    v(i,:)=polyval(coeff2(i,:),b(i));
    %f= polyval(p,x)
    %this function gives us log value constructed from coefficients
    %generated in above function
end


% fi- fixed point function is used to store data to precesion fraction from
% generated coefficients to c0,c1,c2
c0=fi(coeff1(:,1),1,20,15);
c1=fi(coeff1(:,2),1,20,15);
c2=fi(coeff2(:,1),1,12,7);
c3=fi(coeff2(:,2),1,12,7);

%saving coefficients to text file
file1=fopen('c0_sqrt.txt','w');
file2=fopen('c1_sqrt.txt','w');
file3=fopen('c2_sqrt.txt','w');
file4=fopen('c3_sqrt.txt','w');
for i=1:64 
    c1_sqrt(i,:)=hex(c0(i));
    c0_sqrt(i,:)=hex(c1(i));
    %this records data into a text file in column of hexadecimal numbers
    fprintf(file2, '%s  \n', c1_sqrt(i,:)');
    fprintf(file1, '%s  \n', c0_sqrt(i,:)');
    c2_sqrt(i,:)=hex(c3(i));
    c3_sqrt(i,:)=hex(c2(i));
    %this records data into a text file in column of hexadecimal numbers
    fprintf(file4, '%s  \n', c3_sqrt(i,:)');
    fprintf(file3, '%s  \n', c2_sqrt(i,:)');
end
fclose(file1);
%this closes file after writing all coefficients
fclose(file2);
fclose(file3);
%this closes file after writing all coefficients
fclose(file4);

% Error analysis- 

for i=1:(64)

    z0(i,1)=y(i,:)-sqrt(a(i));
    % difference between generated value and original function
    if( z0(i,1)<=(2^-17))
        display('for [1,2)function satisfied and coefficients are accurate')
    
    else
        display('for [1,2) coefficients are not accurate and final results may vary')
    end
    z1(i,1)=v(i,:)-sqrt(b(i));
    % difference between generated value and original function
    if( z1(i,1)<=(2^-17))
        display('for [2,4)function satisfied and coefficients are accurate')
    
    else
        display('for [2,4)coefficients are not accurate and final results may vary')
    end
end
