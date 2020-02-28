%ce script cr�e un graphique de la consommation en Wh d'un m�nage sur une
%moins
function donnees_moins=extrdata_moins(num_maison)

%Open the file
liste=dir(['D:\APEAS1\data\ID',num2str(num_maison)]);
for j=1:length(liste)
    cour_jour=liste(j).name;
    fid=fopen(['D:\APEAS1\data\ID',num2str(num_maison),'\',cour_jour],'r');
end  

%Lire les valeurs de puissance de la phase 2
%   jour    phase 1     phase 2     phase 3     Wh
donnees_moins=textscan(fid,'%*s %s %*f %*f %*f %*f %*f %*f %d %d %d %*d %*d %*d %*f %*f %*f %d','Headerlines',1,'Delimiter',';');
%correction des donn�es : overflow (10'000) et remise � z�ro du compteur en
%d�but de journ�e

%colonne Watt heure
Wh=donnees_moins{5};

%valeur de correction pour le d�but de journ�e
startvalue=Wh(1:1);

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
