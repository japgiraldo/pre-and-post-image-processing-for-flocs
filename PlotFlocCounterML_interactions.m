% PlotFlocCounterML_interactions
%
% Info:  This code shows the evolution of each training.
% Author: Penaloza-Giraldo, Jorge A. 2021 CACR University of Delaware
% Copyrigth (C) 2021 

clear; close all; clc;

% 1. Insert image path to count
ImaFolderMicroscope = 'C:\Users\japg\Google Drive\RESEARCH\FLOCMOD\IMAGES_POST\FLOC_CLASS\CroppedImages1';

% 2. Number of series in the raw images 
nSeries = 2;

% 3. Adjust the experiment time 

t1 = 0.5:0.5:5;
t2 = t1(end)+1:1:10;
t3 = t2(end)+2:2:30;
TimeSample = [t1,t2,t3]';

% 4. Number of trainings 
nTrains = 2;

cd(ImaFolderMicroscope)
for i = 1:nTrains
    
    cd(['tr'  num2str(i)])
    load('n_IcounterS')
    
    nIcounS{i} = n_IcounterS;
    
    cd ..
end 

for j = 1:nSeries
    
    fig{j} = figure(j);
    fig{j}.Position = [635 500 783 420];
    
    for i = 1:nTrains
        semilogx(TimeSample,nIcounS{i}(:,j),'-o','LineWidth',1.5,'MarkerSize',5)
        hold on 
        if j == 1
            LegT{i} = ("TrML" + i);
        end 
    end     
    
    ax = gca; ax.FontSize = 20; ax.FontName = 'Times'; 
    axis([0 60 0 1.5])
    legend(LegT,'location','northwest')
    xlabel('$Time$ [min]','Interpreter','Latex','FontSize',25)
    ylabel('$\frac{N}{\max(N)}$ [per image unit]','Interpreter','Latex','FontSize',25)
    
    print(fig{j},'-dpng','-r250',['TrainingSeries' num2str(j)])    
end 







