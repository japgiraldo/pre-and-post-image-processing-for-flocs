% FlocCounter
% Info: This code counts flocs using batch images.
% Author: Penaloza-Giraldo, Jorge A. 2021 CACR University of Delaware
% Copyrigth (C) 2021 

clear; close all; clc;

% 1. Insert image path to count

ImaFolderMicroscope = 'C:\Users\japg\Google Drive\RESEARCH\FLOCMOD\IMAGES_POST\FLOC_CLASS\CroppedImages1'; 

% 2. Insert Number of series in the raw images 
nSeries = 2;

% 3. Insert Folder name to move the images trained 
TrNameFolder = 'tr1';

a=dir([ImaFolderMicroscope '/*.jpg']);
nImatif = numel(a);

% 4. Adjust the experiment time 

t1 = 0.5:0.5:5;
t2 = t1(end)+1:1:10;
t3 = t2(end)+2:2:30;
TimeSample = [t1,t2,t3]';

% 5. Insert the missing images. 0 = No missing images

MisTime = 0; 

% Output ==============================================

[MissingID,~] = find(TimeSample == MisTime);

cd(ImaFolderMicroscope)

if ~exist(TrNameFolder, 'dir')
    mkdir(TrNameFolder)
else
    warning(['The folder ' TrNameFolder ' Already exists'])
    return 
end 

for ser = 1:nSeries
    
    index = 0;
        for i = ser:nSeries:nImatif   

            index = index + 1;
            ReadTif = [num2str(i,'%04.f') '_Probabilities.tif'];
            I = imread(ReadTif);

            movefile(ReadTif, TrNameFolder)        

            level = graythresh(I(:,:,1));
            Ibw = im2bw(I(:,:,1),level);        % binirizes the images 
            Ifill = imfill(Ibw,'holes');        % fills the holes

            seD = strel('diamond',1);
            Iero = imerode(Ifill,seD);          % Erodes images 
            Irem = bwareaopen(Iero,10);         % Removes small objects from binary images
            Itra = bwboundaries(Irem);          % Traces region boundaries in binary image. 

            IcounterS(index,ser) = length(Itra);
   
        end    
    n_IcounterS(:,ser) = IcounterS(:,ser)./IcounterS(1,ser);
       
end 

if MissingID ~= 0 
    NaNvalues = nan(1,nSeries);
    n_IcounterS = [ n_IcounterS(1:MissingID-1,:); NaNvalues; n_IcounterS(MissingID:end,:)];
end 

%% Checking the plot 
fig1 = figure(1);
fig1.Position = [635 500 783 420];

for ser = 1:nSeries
    semilogx(TimeSample,n_IcounterS(:,ser),'-o','LineWidth',1.5)
    hold on 
    LegT{ser} = ("Serie " + ser);
end 
xlim([0 max(TimeSample)])
ax = gca; ax.FontSize = 20; ax.FontName = 'Times'; 
legend(LegT,'location','northeast')
xlabel('$Time$ [min]','Interpreter','Latex','FontSize',25)
ylabel('$\frac{N}{\max(N)}$ [per image unit]','Interpreter','Latex','FontSize',25)

cd(TrNameFolder)
save('n_IcounterS','n_IcounterS')

