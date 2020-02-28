%AFFICHAGE
while true
    avant=questdlg('Vous avez activé l analyse','Activation','Fermer');
    if strcmp(avant,'Fermer')==1
        break
    end
    while true
        moins_jour=questdlg('Analyser des:','Energie par moins','Energie par jour');
        switch moins_jour
            case 'Energie par moins'
                plus_men=questdlg('Voulez vous comparer 2 ménages en meme temps?');
                switch plus_men
                    case'yes'
                        plus_jours=questdlg('Voulez vous comparer 2 dates differentes pour ce ménages?');
                        if strcmp(plus_jours,'yes')==1
                            jours=str2double(cell2mat(inputdlg({'Jour 1','Jour 2'},'Jours')));
                            uiwait(msgbox('Graphique 2 men Energ par moins 2 jours'))
                            break
                        else
                            jour=str2double(cell2mat(inputdlg('Jour 1','Jours')));
                            uiwait(msgbox('Graphique 2 men Energ par moins 1 jour'))
                            break
                        end
                    case'no'
                        plus_jours=questdlg('Voulez vous comparer 2 dates differentes pour ce ménages?');
                        if strcmp(plus_jours,'yes')==1
                            jours=str2double(cell2mat(inputdlg({'Jour 1','Jour 2'},'Jours')));
                            uiwait(msgbox('Graphique 1 men Energ par moins 2 jours'))
                            break
                        else
                            jour=str2double(cell2mat(inputdlg('Jour 1','Jours')));
                            uiwait(msgbox('Graphique 1 men Energ par moins 1 jour'))
                            break
                        end
                end
            case 'Energie par jourì'
                plus_men=questdlg('Voulez vous comparer 2 ménages en meme temps?');
                switch plus_men
                    case'yes'
                        plus_jours=questdlg('Voulez vous comparer 2 dates differentes pour ce ménages?');
                        if strcmp(plus_jours,'yes')==1
                            jours=str2double(cell2mat(inputdlg({'Jour 1','Jour 2'},'Jours')));
                            uiwait(msgbox('Graphique 2 men Energ par jour 2 jours'))
                            break
                        else
                            jour=str2double(cell2mat(inputdlg('Jour 1','Jours')));
                            uiwait(msgbox('Graphique 2 men Energ par jour 1 jour'))
                            break
                        end
                    case'no'
                        plus_jours=questdlg('Voulez vous comparer 2 dates differentes pour ce ménages?');
                        if strcmp(plus_jours,'yes')==1
                            jours=str2double(cell2mat(inputdlg({'Jour 1','Jour 2'},'Jours')));
                            uiwait(msgbox('Graphique 1 men Energ par jour 2 jours'))
                            break
                        else
                            jour=str2double(cell2mat(inputdlg('Jour 1','Jours')));
                            uiwait(msgbox('Graphique 1 men Energ par jour 1 jour'))
                            break
                        end
                end
        end
    end
end

                            
                       
                            
                              
                            
                
                
                
    