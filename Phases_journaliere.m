% cette fonction crée un graphique des phases d'un ménage sur une
% journée
function Phases_journaliere(file_name)
% Open the file
fid=fopen(strcat('E:\APEAS1\data\',file_name,'.csv'),'r');

% Lire les valeurs de puissance de la phase
% jour    phase 1     phase 2     phase 3     Wh
donnees=textscan(fid,'%*s %s %*f %*f %*f %*f %*f %*f %d %d %d %*d %*d %*d %*f %*f %*f %d','Headerlines',1,'Delimiter',';');

% colonne 3Phases et temps
temps=datenum(donnees{1});
temps_ech=((temps-floor(temps(1)))*24);

Phase1=donnees{2};
Phase2=donnees{3};
Phase3=donnees{4};

% elimination des val négatives Phase1
for s=1:length(Phase1)
    if Phase1(s)<0
        Phase1(s)=0;
    end
end
% elimination des val négatives Phase2
for s=1:length(Phase2)
    if Phase2(s)<0
        Phase2(s)=0;
    end
end
% elimination des val négatives Phase3
for s=1:length(Phase3)
    if Phase3(s)<0
        Phase3(s)=0;
    end
end

%trouver la P max, phase 1,2,2
max_Phase1=0;
max_Phase2=0;
max_Phase3=0;
max_Phase=0;
for w=1:length(Phase1)
    if Phase1(w)>max_Phase1
        max_Phase1=Phase1(w);
    end
    if Phase2(w)>max_Phase2
        max_Phase2=Phase2(w);
    end
    if Phase3(w)>max_Phase3
        max_Phase3=Phase3(w);
    end
end
if max_Phase1>max_Phase2 && max_Phase1>max_Phase3
    max_Phase=max_Phase1;
end
if max_Phase2>max_Phase3 && max_Phase2>max_Phase1
    max_Phase=max_Phase2;
end
if max_Phase3>max_Phase2 && max_Phase3>max_Phase1
    max_Phase=max_Phase3;
end

%echantillonage 
b = (1/100)*ones(1,100);
Phase1_ft=filter(b,1,Phase1);
Phase2_ft=filter(b,1,Phase2);
Phase3_ft=filter(b,1,Phase3);


hold on
plot(temps_ech,Phase1_ft,'g')
plot(temps_ech,Phase2_ft,'r')
plot(temps_ech,Phase3_ft,'b')

table_x=[0:1:23];
axis([0,23,0,max_Phase])
title(strcat('Puissance des phases par jour, Maision-',file_name(1:4),',Date:',file_name(20:end)))
xticks(table_x)
xlabel('Heures [h]')
ylabel('Puissance [W]')
grid on
grid minor
legend('Phase1','Phase2','Phase3')
