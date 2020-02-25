function donnees=extrait_donnees(nom_fic)
clear all;
close all;
%Open the file
fid=fopen(nom_fic,'r');
%Lire les valeurs de puissance de la phase 2
donnees=textscan(fid,'%*s %s %*f %*f %*f %*f %*f %*f %d %d %d %*d %*d %*d %*f %*f %*f %d','Headerlines',1,'Delimiter',';');
