function [PRTable,accuracy] = helperPrecisionRecall(confmat)
% This function is only in support of XpwWaveletMLExample. It may change or
% be removed in a future release.
precision_f1 = confmat(1,1)/sum(confmat(:,1))*100;
precision_f2 = confmat(2,2)/sum(confmat(:,2))*100 ;
precision_f3 = confmat(3,3)/sum(confmat(:,3))*100 ;
precision_f4 = confmat(4,4)/sum(confmat(:,4))*100;
precision_f5 = confmat(5,5)/sum(confmat(:,5))*100 ;
precision_f6 = confmat(6,6)/sum(confmat(:,6))*100 ;
precision_f7 = confmat(7,7)/sum(confmat(:,7))*100 ;

recallf1 = confmat(1,1)/sum(confmat(1,:))*100;
recallf2 = confmat(2,2)/sum(confmat(2,:))*100;
recallf3 = confmat(3,3)/sum(confmat(3,:))*100;
recallf4 = confmat(4,4)/sum(confmat(4,:))*100;
recallf5 = confmat(5,5)/sum(confmat(5,:))*100;
recallf6 = confmat(6,6)/sum(confmat(6,:))*100;
recallf7 = confmat(7,7)/sum(confmat(7,:))*100;

F1_score_f1 = 2*precision_f1*recallf1/(precision_f1+recallf1);
F1_score_f2 = 2*precision_f2*recallf2/(precision_f2+recallf2);
F1_score_f3 = 2*precision_f3*recallf3/(precision_f3+recallf3);
F1_score_f4 = 2*precision_f4*recallf4/(precision_f4+recallf4);
F1_score_f5 = 2*precision_f5*recallf5/(precision_f5+recallf5);
F1_score_f6 = 2*precision_f6*recallf6/(precision_f6+recallf6);
F1_score_f7 = 2*precision_f7*recallf7/(precision_f7+recallf7);

accuracy=[F1_score_f1+F1_score_f2+F1_score_f3+F1_score_f4+...
         F1_score_f5+F1_score_f6+F1_score_f7]/7;
% disp('total accuracy of F1-Score=')
% disp(accuracy)
% % F1CHF = 2*precisionCHF*recallCHF/(precisionCHF+recallCHF);
% % F1NSR = 2*precisionNSR*recallNSR/(precisionNSR+recallNSR);
% % % Construct a MATLAB Table to display the results.
PRTable = array2table([precision_f1 recallf1 F1_score_f1;...
                       precision_f2 recallf2 F1_score_f2;
                       precision_f3 recallf3 F1_score_f3;
                       precision_f4 recallf4 F1_score_f4;
                       precision_f5 recallf5 F1_score_f5;
                       precision_f6 recallf6 F1_score_f6;
                       precision_f7 recallf7 F1_score_f7;...
                       ],'VariableNames',{'Precision','Recall','F1_Score'},'RowNames',...
    {'1','2','3','4','5','6','7'});

% ],'VariableNames',{'Precision','Recall','F1_Score'},'RowNames',...
%     {'facial 1','facial 2','facial 3','facial 4','facial 5','facial 6','facial 7'});

disp('total accuracy of F1-Score=')
disp(accuracy)
end