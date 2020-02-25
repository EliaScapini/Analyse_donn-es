function donnees=extdata
i=3;
j=1;
while true
    fid=fopen(['D:\APEAS1\data\ID',num2str(j),'\energyBox-020_2013-05-2',num2str(i),'.csv'],'r');
    if feof(fid)==1
        i=i+1;
        continue
    end
    %if maison 1 terminée, prochaine ficher ID
        %j=j+1;
        %continue
    %end
    if j==50
        break
    end
    donnees=textscan(fid,'%*s %s %*f %*f %*f %*f %*f %*f %d %d %d %*d %*d %*d %*f %*f %*f %d','Headerlines',1,'Delimiter',';');
end