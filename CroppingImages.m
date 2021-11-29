% CroppingImages
%
% Info: This code crops the batch images.
% Author: Penaloza-Giraldo, Jorge A. 2021 CACR University of Delaware
% Copyrigth (C) 2021 

clear; close all; clc;

% Input Information ===================================================================


% 1. Insert image path to crop
ImaFolderMicroscope = 'C:\Users\japg\Google Drive\RESEARCH\FLOCMOD\IMAGES_POST\FLOC_CLASS'; 

% 2. Insert size of images to crop. 
TargetSize = [1000 1000];   

% 3. Specify Folder Name 
FoldName = 'CroppedImages1';


% Output ==============================================================================

cd(ImaFolderMicroscope)
mkdir(FoldName)
a=dir([ImaFolderMicroscope '/*.jpg']);
nIma = numel(a); 

for i = 1:nIma

    ReadIma = [num2str(i,'%04.f') '.jpg'];    
    I = imread(ReadIma);
    r = centerCropWindow2d(size(I) ,TargetSize);
    J = imcrop(I,r);    
    cd(FoldName)
    imwrite(J,ReadIma);    
    cd ..
end 

