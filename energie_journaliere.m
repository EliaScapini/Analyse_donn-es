%cette fonction cr�e un graphique de la consommation en Wh d'un m�nage sur une
%journ�e
function energie_journaliere(file_name1,file_name2)
%Open the file
fid1=fopen(strcat('E:\APEAS1\data\',file_name1,'.csv'),'r');
fid2=fopen(strcat('E:\APEAS1\data\',file_name2,'.csv'),'r');

%Lire les valeurs de puissance de la phase
%   temps     phase 1     phase 2     phase 3     Wh
donnees1=textscan(fid1,'%*s %s %*f %*f %*f %*f %*f %*f %d %d %d %*d %*d %*d %*f %*f %*f %d','Headerlines',1,'Delimiter',';');
donnees2=textscan(fid2,'%*s %s %*f %*f %*f %*f %*f %*f %d %d %d %*d %*d %*d %*f %*f %*f %d','Headerlines',1,'Delimiter',';');

%colonne Watt heure et temps
Wh1=donnees1{5};
Wh2=donnees2{5};

%valeur de correction pour le d�but de journ�e
startvalue1=Wh1(1,1);
startvalue2=Wh2(1,1);

%nombre d'overflow
flowcounter1=0;
flowcounter2=0;
%hauteur d'overflow
overflow=10000;

% mise � z�ro lors du d�but de journ�e File1
for i=1:length(Wh1)
    Wh1(i)=Wh1(i)-startvalue1;
end
% mise � z�ro lors du d�but de journ�e File2
for j=1:length(Wh2)
    Wh2(j)=Wh2(j)-startvalue2;
end

%correction de l'overflow pour la mise en forme du graphique File1
for m=2:length(Wh1)
    if (Wh1(m)<Wh1(m-1))
        flowcounter1=flowcounter1+1;
        Wh1(m:end)=Wh1(m:end)+(overflow*flowcounter1);
    end
end
%correction de l'overflow pour la mise en forme du graphique File2
for n=2:length(Wh2)
    if (Wh2(n)<Wh2(n-1))
        flowcounter2=flowcounter2+1;
        Wh2(n:end)=Wh2(n:end)+(overflow*flowcounter2);
    end
end

% elimination des val n�gatives Energie File1
for s=1:length(Wh1)
    if Wh1(s)<0
        Wh1(s)=0;
    end
end
% elimination des val n�gatives Energie File2
for o=1:length(Wh2)
    if Wh2(o)<0
        Wh2(o)=0;
    end
end

%trouver l'energie max File1
max_Wh1=0;
for w=1:length(Wh1)
    if Wh1(w)>max_Wh1
        max_Wh1=Wh1(w);
    end
end
%trouver l'energie max File2
max_Wh2=0;
for k=1:length(Wh2)
    if Wh2(k)>max_Wh2
        max_Wh2=Wh2(k);
    end
end

if max_Wh1>max_Wh2
    max_Wh=max_Wh1;
else
    max_Wh=max_Wh2;
end

% modification des valeurs en plus (Wh1)
for z=1:length(Wh1)
    if length(Wh1)>86400
        delete(Wh1(86401:end))
    end
end

% modification des valeurs en plus (Wh2)
for z=1:length(Wh2)
    if length(Wh2)>86400
        delete(Wh2(86401:end))
    end
end

temps1=datenum(donnees1{1});
% modification des valeurs de temps
for z=1:length(temps1)
    if length(temps1)>86400
        delete(temps1(86401:end))
    end
end
temps_ech1=((temps1-floor(temps1(1)))*24);

temps2=datenum(donnees2{1});
% modification des valeurs de temps
for z=1:length(temps2)
    if length(temps2)>86400
        delete(temps2(86401:end))
    end
end
temps_ech2=((temps2-floor(temps2(1)))*24);

% affichage automatique nome maison 
nome_mais=0;
if length(file_name1)==30
    nome_mais=5;
elseif length(file_name1)<30
    nome_mais=4;
end

% graphique et options
table_x=[0:1:23];
hold on
plot(temps_ech1,Wh1)
plot(temps_ech2,Wh2)
axis([0,23,0,max_Wh])
title(strcat('Energie par jour, Maison-',file_name1(1:nome_mais),',  Date1:',file_name1(end-9:end),',  Date2:',file_name2(end-9:end)),'Fontsize',15)
xlabel('Heures [h]','Fontsize',15)
xticks(table_x)
ylabel('Energie [Wh]','Fontsize',15)
grid on
grid minor
legend(file_name1(end-9:end),file_name2(end-9:end),'Location','northwest','Fontsize',15)
