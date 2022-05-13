clc
clear

figure
camera = webcam;
no_of_img=100;
nametemplate = 'Maher_%04d.png';  %name pattern

disp ('-------------------Create Real DataBase  -----------------------------')
disp (' Enter No. 1 angry :')
disp (' Enter No. 2 disgust :')
disp (' Enter No. 3 fear :')
disp (' Enter No. 4 happy :')
disp (' Enter No. 5 neutral :')
disp (' Enter No. 6 sad :')
disp (' Enter No. 7 surprise :')
method= input('No of Method : ' ) ;
if method==1
        savepath = 'Real_DataSet\angry';  %the folder
        %nametemplate = 'image_%04d.png';  %name pattern
        imnum = 0;        %starting image number
        for K = 1 : no_of_img    %if you want to do this 50 times
           YourImage = snapshot(camera);
           image(YourImage)
           img2=cropface(YourImage);
           %img3=imhist(img2,64)
          % YourImage = ... %capture the image
           imnum = imnum + 1;
           thisfile = sprintf(nametemplate, imnum);  %create filename
           fullname = fullfile(savepath, thisfile);  %folder and all
           imwrite( img2, fullname);  %write the image there as tif
        end
end

if method==2
        savepath = 'Real_DataSet\disgust';  %the folder
        %nametemplate = 'image_%04d.png';  %name pattern
        imnum = 0;        %starting image number
        for K = 1 : no_of_img    %if you want to do this 50 times
           YourImage = snapshot(camera);
           image(YourImage)
           img2=cropface(YourImage);
           %img3=imhist(img2,64)
          % YourImage = ... %capture the image
           imnum = imnum + 1;
           thisfile = sprintf(nametemplate, imnum);  %create filename
           fullname = fullfile(savepath, thisfile);  %folder and all
           imwrite( img2, fullname);  %write the image there as tif
        end
end

if method==3
        savepath = 'Real_DataSet\fear';  %the folder
        %nametemplate = 'image_%04d.png';  %name pattern
        imnum = 0;        %starting image number
        for K = 1 : no_of_img    %if you want to do this 50 times
           YourImage = snapshot(camera);
           image(YourImage)
           img2=cropface(YourImage);
           %img3=imhist(img2,64)
          % YourImage = ... %capture the image
           imnum = imnum + 1;
           thisfile = sprintf(nametemplate, imnum);  %create filename
           fullname = fullfile(savepath, thisfile);  %folder and all
           imwrite( img2, fullname);  %write the image there as tif
        end
end

if method==4
        savepath = 'Real_DataSet\happy';  %the folder
        %nametemplate = 'image_%04d.png';  %name pattern
        imnum = 0;        %starting image number
        for K = 1 : 50    %if you want to do this 50 times
           YourImage = snapshot(camera);
           image(YourImage)
           img2=cropface(YourImage);
           %img3=imhist(img2,64)
          % YourImage = ... %capture the image
           imnum = imnum + 1;
           thisfile = sprintf(nametemplate, imnum);  %create filename
           fullname = fullfile(savepath, thisfile);  %folder and all
           imwrite( img2, fullname);  %write the image there as tif
        end
end

if method==5
        savepath = 'Real_DataSet\neutral';  %the folder
        %nametemplate = 'image_%04d.png';  %name pattern
        imnum = 0;        %starting image number
        for K = 1 : no_of_img    %if you want to do this 50 times
           YourImage = snapshot(camera);
           image(YourImage)
           img2=cropface(YourImage);
           %img3=imhist(img2,64)
          % YourImage = ... %capture the image
           imnum = imnum + 1;
           thisfile = sprintf(nametemplate, imnum);  %create filename
           fullname = fullfile(savepath, thisfile);  %folder and all
           imwrite( img2, fullname);  %write the image there as tif
        end
end

if method==6
        savepath = 'Real_DataSet\sad';  %the folder
        %nametemplate = 'image_%04d.png';  %name pattern
        imnum = 0;        %starting image number
        for K = 1 : no_of_img    %if you want to do this 50 times
           YourImage = snapshot(camera);
           image(YourImage)
           img2=cropface(YourImage);
           %img3=imhist(img2,64)
          % YourImage = ... %capture the image
           imnum = imnum + 1;
           thisfile = sprintf(nametemplate, imnum);  %create filename
           fullname = fullfile(savepath, thisfile);  %folder and all
           imwrite( img2, fullname);  %write the image there as tif
        end
end

if method==7
        savepath = 'DataSet\surprise';  %the folder
        %nametemplate = 'image_%04d.png';  %name pattern
        imnum = 0;        %starting image number
        for K = 1 : no_of_img    %if you want to do this 50 times
           YourImage = snapshot(camera);
           image(YourImage)
           img2=cropface(YourImage);
           %img3=imhist(img2,64)
          % YourImage = ... %capture the image
           imnum = imnum + 1;
           thisfile = sprintf(nametemplate, imnum);  %create filename
           fullname = fullfile(savepath, thisfile);  %folder and all
           imwrite( img2, fullname);  %write the image there as tif
        end
end