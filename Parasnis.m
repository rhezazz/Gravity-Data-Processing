%Perhitungan densitas rata - rata parasnis
%Mohammad Rheza Zamani
clear all;
clc;
d = importdata('Template Parasnis.dat');
FAA = d(:,1); %Free Air Anomaly
X = d(:,2); % (BC-TC)/rho
k = zeros(length(X), 1);
for i = 1 : length(X) 
    k(:, 1 ) = zeros(length(X), 1) + 1;
end

%Kernel Matrix
x = [X k]; 

% Inversion
m=inv(x'*x)*x'*FAA;

%RSME
FAAcal=x*m; % Y hitung
t=FAA-FAAcal ;
rmse=sqrt(mean(t.^2));

plot(x(:,1),FAA,'ro') 


hold on 
%Plotting
for i=1:200
    Xreg(i)=i;
    FAAreg(i)=Xreg(i)*m(1)+m(2);
end
plot(Xreg,FAAreg,'g');
xlabel('(BC - TC) / rho','Fontweight','bold')
ylabel('FAA','Fontweight','bold')
title('Regresi linear untuk penentuan densitas rata - rata parasnis ')
subtitle(['Densitas rata - rata Parasnis : ',num2str(m(1)),' gr/cc'])
grid on
hold off
