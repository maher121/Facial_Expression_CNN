clc;
clear;
close all;

disp ('-------------------Choose Dataset CK+ , OR Jappan Dataset -----------------------------')
disp (' Enter No. 1 for   JAFFA dataset and KNN:')
disp (' Enter No. 2 for   JAFFA dataset and SVM:')
disp (' Enter No. 3 for   JAFFA dataset and TREE:')
disp (' Enter No. 4 for   CK dataset and KNN:')
disp (' Enter No. 5 for   CK dataset and SVM:')
disp (' Enter No. 6 for   CK dataset and TREE:')
method= input('No of Method : ' ) ;
if method==1
load info_alexnet/JAFFA/info_Knn
cm= confusionchart(C,'ColumnSummary','column-normalized', ...
'RowSummary','row-normalized');
PRTable = helperPrecisionRecall(C)
%pause()
end
if method == 2
load info_alexnet/JAFFA/info_SVM
cm= confusionchart(C,'ColumnSummary','column-normalized', ...
'RowSummary','row-normalized');
PRTable = helperPrecisionRecall(C)
end

if method == 3
load info_alexnet/JAFFA/info_tree
cm= confusionchart(C,'ColumnSummary','column-normalized', ...
'RowSummary','row-normalized');
PRTable = helperPrecisionRecall(C)
end

if method==4
load info_alexnet/CK/info_Knn
cm= confusionchart(C,'ColumnSummary','column-normalized', ...
'RowSummary','row-normalized');
PRTable = helperPrecisionRecall(C)
%pause()
end
if method == 5
load info_alexnet/CK/info_SVM
cm= confusionchart(C,'ColumnSummary','column-normalized', ...
'RowSummary','row-normalized');
PRTable = helperPrecisionRecall(C)
end

if method == 6
load info_alexnet/CK/info_tree
cm= confusionchart(C,'ColumnSummary','column-normalized', ...
'RowSummary','row-normalized');
PRTable = helperPrecisionRecall(C)
end

