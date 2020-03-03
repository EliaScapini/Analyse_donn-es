%ce script cr�e un graphique de la consommation en Wh d'un m�nage sur une
%moins
%function Wh=extrdata_moins(num_maison)

%Open the file

%liste=dir(['E:\APEAS1\data\ID',num2str(num_maison),'\energyBox*.csv']);
liste=dir(['C:\Users\colin\Desktop\APEAS1\data\ID01','\energyBox*.csv']);
Wh=[];
temps=[];

for j=1:length(liste)
    cour_jour=liste(j).name;
    
%save(['E:\APEAS1\data\ID01','\',cour_jour,'.csv'],'-mat');
%donnees_moins_mat=load(['E:\APEAS1\data\ID01','\',cour_jour,'.csv'],'-mat');
    
    fid=fopen(['C:\Users\colin\Desktop\APEAS1\data\ID01\',cour_jour],'r');
    %Lire les valeurs de puissance de la phase 2
    %   jour    phase 1     phase 2     phase 3     Wh
    donnees_moins=textscan(fid,'%*s %s %*f %*f %*f %*f %*f %*f %d %d %d %*d %*d %*d %*f %*f %*f %d','Headerlines',1,'Delimiter',';');
    %correction des donn�es : overflow (10'000) et remise � z�ro du compteur en
    %d�but de journ�e
    
    %colonne Watt heure
     Wh=[Wh; double(donnees_moins{5})];
temps=[temps; datenum(str2double(donnees_moins{1}),'yyyy-mm-dd HH:MM:SS')];
%     
    %valeur de correction pour le d�but de journ�e
    startvalue=Wh(1,1);
    
    %nombre d'overflow
    flowcounter=0;
    
    %hauteur d'overflow
    overflow=10000;
    
    %correction de l'overflow pour la mise en forme du graphique
    for i=2:length(Wh)
        if (Wh(i)<Wh(i-1))
            flowcounter=flowcounter+1;
            Wh(i:end)=Wh(i:end)+overflow;
        end
    end
    
    %mise � z�ro lors du d�but de journ�e
    for i=1:length(Wh)
        Wh(i)=Wh(i)-startvalue;
    end
 end

