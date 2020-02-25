%Task 7
clear all;
close all;
%Open the file
fid=fopen(['D:\APEAS1\data\ID01\energyBox-020_2013-05-23.csv'],'r');
%Lire les valeurs de puissance de la phase 2
=textscan(fid,'%*s %s %*f %*f %*f %*f %*f %*f %d %d %d %*d %*d %*d %*f %*f %*f %d','Headerlines',1,'Delimiter',';');