% cette fonction crée un graphique des phases d'un ménage sur une
% journée
% 
% Open the file
fid=fopen('C:\Users\colin\Desktop\APEAS1\data\ID13\energyBox-021_2013-10-25.csv','r');

% Lire les valeurs de puissance de la phase
% jour    phase 1     phase 2     phase 3     Wh
donnees=textscan(fid,'%*s %s %*f %*f %*f %*f %*f %*f %d %d %d %*d %*d %*d %*f %*f %*f %d','Headerlines',1,'Delimiter',';');

% colonne 3Phases et temps
temps=datenum(donnees{1});
temps_ech=((temps-floor(temps(1)))*24);

Phase1=donnees{2};
Phase2=donnees{3};
Phase3=donnees{4};

% % Adjustament pour le graphique de la Phase2
% for g=1:length(Phase2)
% Phase2_gr(g)=Phase2(g)+6000;
% end
% 
% % Adjustament pour le graphique de la Phase3
% for g=1:length(Phase3)
% Phase3_gr(g)=Phase3(g)+12000;
% end


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

    

% axe_y=[0:500:12000];
% h=[0:500:6000];
% for f=1:length(axe_y)
%     if axe_y(f)==6000
%         axe_y(f:end)=h(:);
%     end
% end

hold on
plot(temps_ech,Phase1,'g')
plot(temps_ech,Phase2,'r')
plot(temps_ech,Phase3,'b')


% axis([0,23,0,12000])
% set(gca,'YTick',1:25,'YTickLabel',axe_y(1:end)); 


title('Maision ID01 Puissance des Phases par jour')
xlabel('Heures [h]')
ylabel('Puissance [W]')
grid on
grid minor
