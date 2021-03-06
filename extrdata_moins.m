clear all
close all

%ce script cr�e un graphique de la consommation en Wh d'un m�nage sur une
%moins
%function Wh=extrdata_moins(num_maison)

%Open the file
n='41'

%liste=dir(['E:\APEAS1\data\ID',num2str(num_maison),'\energyBox*.csv']);
liste=dir(['C:\Users\colin\Desktop\APEAS1\data\ID',n,'\energyBox*.csv']);
Wh=[];
temps=[];
WhDay=[]
Day=[]

for j=1:length(liste)
    
    cour_jour=liste(j).name;
    
    %save(['E:\APEAS1\data\ID01','\',cour_jour,'.csv'],'-mat');
    %donnees_moins_mat=load(['E:\APEAS1\data\ID01','\',cour_jour,'.csv'],'-mat');
    ['C:\Users\colin\Desktop\APEAS1\data\ID',n,'\',cour_jour]
    fid=fopen(['C:\Users\colin\Desktop\APEAS1\data\ID',n,'\',cour_jour],'r');
    %Lire les valeurs de puissance de la phase 2
    %   jour    phase 1     phase 2     phase 3     Wh
    donnees_moins=textscan(fid,'%*s %s %*f %*f %*f %*f %*f %*f %d %d %d %*d %*d %*d %*f %*f %*f %d','Headerlines',1,'Delimiter',';');
    %correction des donn�es : overflow (10'000) et remise � z�ro du compteur en
    %d�but de journ�e
    
    %colonne Watt heure
    Wh=[Wh; double(donnees_moins{5})];
    
    %     temps=[temps; datestr(donnees_moins{1},'mm.dd')];
    
    
    %
    %valeur de correction pour le d�but de journ�e
    
    startvalue=donnees_moins{5}(1);
    
    %nombre d'overflow
    flowcounter=0;
    
    %hauteur d'overflow
    overflow=10000;
    
    %interval de correction pour l'overflow et la valeur de d�part
    p=length(Wh)-86399
    r=length(Wh)
    
    
    %correction de l'overflow pour la mise en forme du graphique
    for i=p+1:r
        if (Wh(i)<Wh(i-1))
            flowcounter=flowcounter+1;
            Wh(i:end)=Wh(i:end)+overflow;
        end
    end
    
    
    %mise � z�ro lors du d�but de journ�e
    for i=p:r
        Wh(i)=Wh(i)-startvalue;
    end
    WhDay=[WhDay;Wh(r)];
    %     Day=[Day;temps(p)];
    Day=[Day;datestr(donnees_moins{1}(1),'mm.dd')]
    
end

% Transformation kWh
WhDay=WhDay/1000


%R�cup�ration des dates de d�but en fin de mesure
a=char(Day(1,1),Day(1,2),Day(1,3),Day(1,4),Day(1,5))
from= convertCharsToStrings(a)

b=char(Day(length(Day),1),Day(length(Day),2),Day(length(Day),3),Day(length(Day),4),Day(length(Day),5))
to= convertCharsToStrings(b)
% Graphique
bar(WhDay)
% Create title
title(strcat('Consommation journali�re ID',n,' du',' ', from,' au ',' ',to),'Fontsize',15)
% title({'Consommation journali�re ID57 du 01.02 au 07.03'})
% Create ylabel
ylabel('Consommation [kWh]','Fontsize',15)
% Create xlabel
xlabel('Jour','Fontsize',15)

strcat('Consommation journali�re ID',n,' du ',' ', from,' au ',' ',to)