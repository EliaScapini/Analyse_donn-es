%cette fonction cr�e un graphique de la consommation en Wh d'un m�nage sur une
%journ�e
%function Wh=energie_journaliere(filename)
%Open the file
fid=fopen('C:\Users\elias\Documents\INFO\ANALYSE DES DONNEES\energyBox-020_2013-05-23.csv','r');

%Lire les valeurs de puissance de la phase
%   jour    phase 1     phase 2     phase 3     Wh
donnees=textscan(fid,'%*s %s %*f %*f %*f %*f %*f %*f %d %d %d %*d %*d %*d %*f %*f %*f %d','Headerlines',1,'Delimiter',';');


%colonne Watt heure et temps
Wh=donnees{5};
temps=str2num(datestr(datenum(donnees{1}),'HH'));

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
        Wh(i:end)=Wh(i:end)+(overflow*flowcounter);
    end
end

% mise � z�ro lors du d�but de journ�e
for i=1:length(Wh)
    Wh(i)=Wh(i)-startvalue;
end

plot(temps,Wh)
axis([0,24,0,11000])
