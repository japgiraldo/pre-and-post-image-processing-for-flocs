
% ContourOverlayImage
% Info: This code performs a delimitation of the edges of the detected flocs.
% Author: Penaloza-Giraldo, Jorge A. 2021 CACR University of Delaware
% Copyrigth (C) 2021 

clear; close all; clc;

% Input =============================================
% 1. Insert image path to count. Recall images format must be .tif
ImaFolderMicroscope = 'C:\Users\japg\Google Drive\RESEARCH\FLOCMOD\IMAGES_POST\FLOC_CLASS\CroppedImages1'; 
% 2. Select the Training Flocder
TrainFol = 'tr1';
% 3. Select the image number to conter
Npicture = [3 4];


% Outpunt ==============================================

for i = 1:length(Npicture)
    cd([ImaFolderMicroscope '\' TrainFol ])
    Iori = imread(['../' num2str(Npicture(i),'%04.f') '.jpg']);

    ReadTif = [num2str(Npicture(i),'%04.f') '_Probabilities.tif'];
    I = imread(ReadTif);
    level = graythresh(I(:,:,1));
    Ibw = im2bw(I(:,:,1),level);        % binirizes the images 
    Ifill = imfill(Ibw,'holes');        % fills the holes

    seD = strel('diamond',1);
    Iero = imerode(Ifill,seD);          % Erodes images 
    Irem = bwareaopen(Iero,10);         % Removes small objects from binary images

    dim = size(Ibw);
    col = round(dim(2)/2)-90;
    row = find(Ibw(:,col), 1 );

    fig1 = figure(1);
    fig1.Position = [200 200 423 420];
    axes('Units', 'normalized', 'Position', [0 0 1 1]);
    Itra = bwboundaries(Irem);          % Traces region boundaries in binary image. 
    disp("N flocs = " + length(Itra))
    imshow(Iori);
    hold on
    for k = 1:length(Itra)
       boundary = Itra{k};
       plot(boundary(:,2), boundary(:,1), '-r', 'LineWidth', 1.5)
    end
    text(50,50,['Images #' num2str(Npicture(i)) ' N flocs = ' num2str(length(Itra))],'fontsize',15,'color',[0.2 1.0 0],'FontWeight','bold')


    %% save 
    print('-dpng','-r300',['Contour_' num2str(Npicture(i),'%04.f') TrainFol ])

end 




