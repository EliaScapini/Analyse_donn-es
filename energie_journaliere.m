%cette fonction cr�e un graphique de la consommation en Wh d'un m�nage sur une
%journ�e
%function Wh=energie_journaliere(filename)
%Open the file
fid=fopen('C:\Users\elias\Documents\INFO\ANALYSE DES DONNEES\energyBox-020_2013-05-23.csv','r');
%Lire les valeurs de puissance de la phase 2
%   jour    phase 1     phase 2     phase 3     Wh
donnees=textscan(fid,'%*s %s %*f %*f %*f %*f %*f %*f %d %d %d %*d %*d %*d %*f %*f %*f %d','Headerlines',1,'Delimiter',';');
%correction des donn�es : overflow (10'000) et remise � z�ro du compteur en
%d�but de journ�e

tableau_temps=[1:1:23;1:1:23];

%colonne Watt heure et temps
Wh=donnees{5};
temps=datenum(donnees{1});

for k=1:size(temps,1)
    tableau_temps(2,k)=temps(3600*k);
end


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
        Wh(i:end)=Wh(i:end)+(overflow*flowcounter);
    end
end

% %correction de l'overflow pour la mise en forme du graphique
% for i=2:length(temps)
%     if (temps(i)<temps(i-1))
%         flowcounter=flowcounter+1;
%         temps(i:end)=temps(i:end)+(overflow*flowcounter);
%     end
% end

%mise � z�ro lors du d�but de journ�e
for i=1:length(Wh)
    Wh(i)=Wh(i)-startvalue;
end

