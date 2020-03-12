%consommation moyenne journalière et consommation totale mensuelle

%Open the file

%file number
n='57'
%liste=dir(['E:\APEAS1\data\ID',num2str(num_maison),'\energyBox*.csv']);
liste=dir(['C:\Users\colin\Desktop\APEAS1\data\ID61\energyBox*.csv']);
Wh=[];
temps=[];
WhDay=[]
Day=[]

for j=1:length(liste)
    
    cour_jour=liste(j).name;
    
    %save(['E:\APEAS1\data\ID01','\',cour_jour,'.csv'],'-mat');
    %donnees_moins_mat=load(['E:\APEAS1\data\ID01','\',cour_jour,'.csv'],'-mat');
    ['C:\Users\colin\Desktop\APEAS1\data\ID61\',cour_jour]
    fid=fopen(['C:\Users\colin\Desktop\APEAS1\data\ID61\',cour_jour],'r');
    %Lire les valeurs de puissance de la phase 2
    %   jour    phase 1     phase 2     phase 3     Wh
    donnees_moins=textscan(fid,'%*s %s %*f %*f %*f %*f %*f %*f %d %d %d %*d %*d %*d %d','Headerlines',1,'Delimiter',';');
    %correction des données : overflow (10'000) et remise à zéro du compteur en
    %début de journée
    
    %colonne Watt heure
    Wh=[Wh; double(donnees_moins{5})];
    
    
    
    %
    %valeur de correction pour le début de journée
    
    startvalue=donnees_moins{5}(1);
    
    %nombre d'overflow
    flowcounter=0;
    
    %hauteur d'overflow
    overflow=10000;
    
    %interval de correction pour l'overflow et la valeur de départ
    p=length(Wh)-86398
    r=length(Wh)
    
    
    %correction de l'overflow pour la mise en forme du graphique
    for i=p+2:r
        if (Wh(i)<Wh(i-1))
            flowcounter=flowcounter+1;
            Wh(i:end)=Wh(i:end)+overflow;
        end
    end
    
    
    %mise à zéro lors du début de journée
    for i=p:r
        Wh(i)=Wh(i)-startvalue;
    end
    WhDay=[WhDay;Wh(r)];

end

moyenne_jour= mean(WhDay)
cons_tot_mens= sum(WhDay)
