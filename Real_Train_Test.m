
clc
clear

disp ('-------------------Real Test Facial Expresion -----------------------------')
disp (' Enter No. 1 for   Train Real DataSet:')
disp (' Enter No. 2 for   Test Real Time :')

method= input('No of Method : ' ) ;
if method==1
     imageFolder=fullfile('Real_DataSet\');%
     imds = imageDatastore(imageFolder, 'LabelSource', 'foldernames', 'IncludeSubfolders',true);
    [imdsTrain,imdsValidation] = splitEachLabel(imds,0.99,'randomized');
     trainingSet=imdsTrain;
     %testSet=imdsValidation;
     
    net = squeezenet;
    inputSize = net.Layers(1).InputSize
    layersTransfer = net.Layers(1:end-3);
    numClasses = numel(categories(imdsTrain.Labels));

    imageSize = net.Layers(1).InputSize;
    augmentedTrainingSet = augmentedImageDatastore(imageSize, trainingSet, 'ColorPreprocessing', 'gray2rgb');
featureLayer='fire9-concat';
trainingFeatures = activations(net, augmentedTrainingSet, featureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');

% Get training labels from the trainingSet
trainingLabels = trainingSet.Labels;
%---------- Start SVM -------------------------
classifier = fitcecoc(trainingFeatures, trainingLabels, ...
    'Learners', 'Linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns');
     
     save classifier classifier
end
if method == 2
    
    h = figure;
    while ishandle(h)
       camera = webcam;
        net = squeezenet;
        load classifier
        featureLayer='fire9-concat';
            YourImage = snapshot(camera);
           image(YourImage)
           img2=cropface(YourImage);
        imageSize = net.Layers(1).InputSize;
        augmentedTestSet = augmentedImageDatastore(imageSize, img2, 'ColorPreprocessing', 'gray2rgb');
        testFeatures = activations(net, augmentedTestSet, featureLayer, ...
        'MiniBatchSize', 32, 'OutputAs', 'columns');
        % Pass CNN image features to trained classifier
            YPred = predict(classifier, testFeatures, 'ObservationsIn', 'columns');
            disp(YPred)
            drawnow
    end
end