%cette fonction crée un graphique de la consommation en Wh d'un ménage sur une
%journée
function energie_journaliere(file_name)
%Open the file
fid=fopen(strcat('E:\APEAS1\data\',file_name,'.csv'),'r');

%Lire les valeurs de puissance de la phase
%   jour    phase 1     phase 2     phase 3     Wh
donnees=textscan(fid,'%*s %s %*f %*f %*f %*f %*f %*f %d %d %d %*d %*d %*d %*f %*f %*f %d','Headerlines',1,'Delimiter',';');


%colonne Watt heure et temps

Wh=donnees{5};
temps=datenum(donnees{1});
temps_ech=((temps-floor(temps(1)))*24);

%valeur de correction pour le début de journée
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

% mise à zéro lors du début de journée
for i=1:length(Wh)
    Wh(i)=Wh(i)-startvalue;
end

%trouver l'energie max
max_Wh=0;
for w=1:length(Wh)
    if Wh(w)>max_Wh
        max_wh=Wh(w);
    end
end

table_x=[0:1:23];
plot(temps_ech,Wh)
axis([0,23,0,max_wh])
title(strcat('Energie par jour, Maision-',file_name(1:4),',Date:',file_name(20:end)))
xlabel('Heures [h]')
xticks(table_x)
ylabel('Energie [Wh]')
grid on
grid minor
