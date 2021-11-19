%Mohammad Rheza Zamani
%Processing Gravity Data
clc;
clear all;
%Input Data
d = xlsread('Template Gravity.xlsx');
utmx = d(:,1); %m
utmy = d(:,2); %m
lat = d(:,3); %radians
long = d(:,4); %radians
elev = d(:,5); %m
gukur = d(:,7); %mGal
tide_correction = d(:,8); %mGal
waktu = d(:,6); %Hari
%Input rho asumsi
rho = 2.67; %Densitas rata2 dari daerah gr/cc
%Input gbase (menyesuaikan)
gbase = ; %mGal
%Koreksi medan 
terrain = d(:,9);
%Koreksi pasut
for i = 1 : length(gukur)
    gcor_1(i) = gukur(i) + tide_correction(i);
end
%Menghitung drift correction
for j = 1 : length(gcor_1)
    drift_cor(j) = ((waktu(j)-waktu(1))/(waktu(length(gcor_1))-waktu(1)))*(gcor_1(length(gcor_1))-gcor_1(1));
end
%Koreksi drift
for k = 1 : length(drift_cor)
    gcor_3(k) = gcor_1(k) - drift_cor(k);
end
%Menghitung delta g
for l = 1 : length(gcor_3)
    deltag(l) = gcor_3(l) - gcor_3(1);
end
%Menghtung Gobs
for i = 1 : length(deltag)
    gobs(i) = gbase + deltag(i);
end
%Menghitung G latitude
for j = 1 : length(lat)
    glat(j) =  978031.846*(1 + 0.0053024* sin(lat(j))^2 - 0.0000058*sin(2*lat(j))^2 );
end
%Koreksi udara bebas
for k = 1 : length(glat)
    gcor_4(k) = gobs(k) - glat(k) + 0.3086*elev(k);
end
%Simple Bouger Anomaly
for l = 1 : length(gcor_4)
    gcor_5(l)= gcor_4(l) - 0.04193*elev(l)*rho;
end
%CBA
for i = 1 : length(gcor_5)
    gcor_final(i) = gcor_5(i)+terrain(i);
end
CBA = gcor_final'; %Hasil dalam mGal

Hasil_Gravity = [utmx utmy CBA];
writematrix(Hasil_Gravity,'CBA.dat','Delimiter','tab')

