clc;
clear;
close all;

disp ('-------------------Choose Dataset CK+ , OR Jappan Dataset -----------------------------')
disp (' Enter No. 1 for   JAFFA dataset:')
disp (' Enter No. 2 for    CK Datatset :')

method= input('No of Method : ' ) ;
if method==1
     imageFolder=fullfile('JAFFA_DataSet\');%
end
if method == 2
     imageFolder=fullfile('CK_DataSet\');%
end

imds = imageDatastore(imageFolder, 'LabelSource', 'foldernames', 'IncludeSubfolders',true);
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.8,'randomized');
trainingSet=imdsTrain;
[imdsTrain33,imdsValidation] = splitEachLabel(imds,0.8,'randomized');

testSet=imdsValidation;


numTrainImages = numel(imdsTrain.Labels);
figure(1)
idx = randperm(numTrainImages,16);
figure
for i = 1:16
    subplot(4,4,i)
    I = readimage(imdsTrain,idx(i));
    imshow(I)
end

%-------------------------------------------
%% 
 net = squeezenet;
inputSize = net.Layers(1).InputSize
layersTransfer = net.Layers(1:end-3);
numClasses = numel(categories(imdsTrain.Labels));

imageSize = net.Layers(1).InputSize;
augmentedTrainingSet = augmentedImageDatastore(imageSize, trainingSet, 'ColorPreprocessing', 'gray2rgb');
augmentedTestSet = augmentedImageDatastore(imageSize, testSet, 'ColorPreprocessing', 'gray2rgb');

%------- Extract Training Features Using CNN --------------

% Get the network weights for the second convolutional layer
w1 = net.Layers(2).Weights;

% Scale and resize the weights for visualization
w1 = mat2gray(w1);
w1 = imresize(w1,5); 

% % Display a montage of network weights. There are 96 individual sets of
% % weights in the first layer.
% figure
% montage(w1)
% title('First convolutional layer weights')
% %-------------------------------------------------------------
% featureLayer = 'fc8';
% featureLayer='pool10';
featureLayer='fire9-concat';
trainingFeatures = activations(net, augmentedTrainingSet, featureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');
%%--------Train A Multiclass SVM Classifier Using CNN Features

% Get training labels from the trainingSet
trainingLabels = trainingSet.Labels;

disp("-------------------- Start SVM ---------------")
figure(2)
%---------- Start SVM -------------------------
% Train multiclass SVM classifier using a fast linear solver, and set
% 'ObservationsIn' to 'columns' to match the arrangement used for training
% features.
classifier = fitcecoc(trainingFeatures, trainingLabels, ...
    'Learners', 'Linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns');
%%-----------------------------------------------------------------------------
%Evaluate Classifier
% Extract test features using the CNN
testFeatures = activations(net, augmentedTestSet, featureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');
% Pass CNN image features to trained classifier
YPred = predict(classifier, testFeatures, 'ObservationsIn', 'columns');
% Get the known labels
testLabels = testSet.Labels;
% fig = figure;
%cm = confusionchart(testLabels,YPred,'RowSummary','row-normalized');
%accuracy = mean(YPred == testLabels)
C = confusionmat(testLabels,YPred);
cm= confusionchart(C,'ColumnSummary','column-normalized', ...
'RowSummary','row-normalized');
PRTable = helperPrecisionRecall(C)

if method==1
save info_sequenzee\JAFFA\info_SVM  classifier C
end
if method == 2
save info_sequenzee\CK\info_SVM  classifier C
end

%%------------- end SVM ----------------------------------
disp("-------------------- End SVM ---------------")

%%
%%% --------------  Strat Decison Tree ------------------
disp("-------------------- Strat Decison Tree ---------------")
figure(2)
testFeatures = activations(net, augmentedTestSet, featureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');
treeMd = fitctree(trainingFeatures', trainingLabels);
treePredicate = predict(treeMd,testFeatures');
%accuracy = mean(treePredicate == testLabels)
C = confusionmat(testLabels,treePredicate);
cm= confusionchart(C,'ColumnSummary','column-normalized', ...
'RowSummary','row-normalized');
PRTable = helperPrecisionRecall(C)
if method==1
save info_sequenzee\JAFFA\info_tree treeMd C
end
if method == 2
save info_sequenzee\CK\info_tree treeMd C
end


disp("-------------------- End Decison Tree ---------------")
%%
%% --------------- strat KNN -----------------------
disp("-------------------- Start KNN ---------------")

figure(3)
knnMd = fitcknn(trainingFeatures', trainingLabels);
knnPredicate = predict(knnMd,testFeatures');
%plotconfusion(testLabels,knnPredicate,"KNN")
%accuracy = mean(knnPredicate == testLabels)
C = confusionmat(testLabels,knnPredicate);
cm= confusionchart(C,'ColumnSummary','column-normalized', ...
'RowSummary','row-normalized');
PRTable = helperPrecisionRecall(C)
if method==1
save info_sequenzee\JAFFA\info_knn  knnMd C
end
if method == 2
save info_sequenzee\CK\info_knn  knnMd C
end
disp("-------------------- End KNN ---------------")
