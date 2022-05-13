

 imageFolder=fullfile('CK+_maher2\');
    imds = imageDatastore(imageFolder, 'LabelSource', 'foldernames', 'IncludeSubfolders',true);
    
    for i=1:length(imds.Labels)
        our_images=readimage(imds,i);
        img2=cropface(our_images);
        imwrite(img2,cell2mat(imds.Files(i)));

    end
    