# pre-and-post-image-processing-for-flocs

You will find MATLAB219b (or later) codes to process your images. <br />   
Pre-processing: CroppingImages <br /> 
Post-processing: FlocCounter, PlotFlocCounterML_interactions, ContourOverlayImage, Code Descriptions <br />
## Code Descriptions  
CroppingImages: This code crops the batch images. <br /> 
FlocCounter: This code counts flocs using batch images. <br />
PlotFlocCounterML_interactions: This code shows the evolution of each training. <br />
ContourOverlayImage: This code performs a delimitation of the edges of the detected flocs. <br />
## Example: Bentonite images
Number of images: 80 <br />
Number of time series: 2 <br />
Sampling rate: <br />
              t1 = 0.5:0.5:10; <br />
              t2 = t1(end)+1:1:30; <br />
              TimeSample = [t1,t2]'; <br />
