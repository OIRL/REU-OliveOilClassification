%Code created by Ana Doblas - September 14, 2022

%This code reads RGB images of olive oil  blends and automatically classify
%them into five classes (no olive oil, light olive oil, medium olive oil,
%olive oil, and extra virgin olive oil). The proposed image processing is
%based on an indirect measurement of the chlorophyll molecules by quantifying 
% the normalized intensity values between the green and red channels.

close all
clear all
clc

numb = 1:50; %index to run through the number of RGB images

total=length(numb);

for i=1:total
img = double(imread(strcat('IMG_',num2str(numb(i)),'.jpg'))); %read RGB images
[Rimg Gimg Bimg]=imsplit(img); %split each channel generating a R, G, and B images
% figure;subplot(1,3,1);imagesc(Rimg);axis image
% subplot(1,3,2);imagesc(Gimg);axis image
% subplot(1,3,3);imagesc(Bimg);axis image


% figure;subplot(1,2,1);colormap gray;imagesc(Rimg);axis image
% subplot(1,2,2);colormap gray;imagesc(Gimg);axis image

% 
% Gimg_crop=Gimg(610:620,200:300);
% Rimg_crop=Rimg(610:620,200:300);

Gimg_crop = Gimg (610:625, 100:400); %cropping laser illumination area
Rimg_crop = Rimg (610:625, 100:400);


%display cropping lasesr illumination to verify that it has been performed
%properly
% figure;subplot(1,2,1);colormap gray;imagesc(Rimg_crop);axis image
% subplot(1,2,2);colormap gray;imagesc(Gimg_crop);axis image

[NXGimg NYGimg] = size(Rimg_crop);
Gvalue(i) = mean(Gimg_crop(:))/(NXGimg * NYGimg); %estimate the normalized intensity for the Green channel
Rvalue(i) = mean(Rimg_crop(:))/(NXGimg * NYGimg); %estimate the normalized intensity for the Red channel


QualityClassifier(i) = Rvalue(i)/Gvalue(i); %Classifier function is the ration of the normalized mean intensity values between the red and green channels

clear Gimg Rimg Bimg Gimg_crop Rimg_crop NXGimg NYGimg img
end

figure;plot(QualityClassifier)

%% Create label vector to automatically classify the olive blends

label = zeros(1,length(QualityClassifier3));

for i=1:length(QualityClassifier)
    
    if QualityClassifier(i) <= 1
        label(i)=1;%no olive oil
    elseif QualityClassifier(i)>1 && QualityClassifier(i)<=1.5
        label(i)=2;%light
   elseif QualityClassifier(i)>1.5 && QualityClassifier(i)<=2
        label(i)=3;%medium
   elseif QualityClassifier(i)>2 && QualityClassifier(i)<=2.5
        label(i)=4; %olive oil
    else QualityClassifier(i)>2.5
        label(i)=5; %extra olive oil
    end
    
end

label
        