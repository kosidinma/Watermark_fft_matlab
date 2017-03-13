%Color image watermarking based on FFT
clc
clear all
close all
%Read Original Image
Image = imread('lena.png');
if size(Image,3) == 3  %image is rgb...split into components
    red = Image(:,:,1); % Red component 
    green = Image(:,:,2); % Green component 
    blue = Image(:,:,3); % Blue component 
end
[ImageRows,ImageColoumns,~] = size(Image);
%Read Logo
Logo = imread('Logo.png'); 
Logo = imresize(Logo, [ImageRows/10 NaN]); %make logo width to be 1/10th of image
if size(Logo,3) == 3   %image is rgb...split into components
    logo_red = Logo(:,:,1); % Red component 
    logo_green = Logo(:,:,2); % Green component 
    logo_blue = Logo(:,:,3); % Blue component
end
[LogoRows,LogoColoumns,~] = size(Logo);
figure, subplot(2,3,1),imshow(cat(3, red, green, blue)); %show rgb image
title('Original Image')
 subplot(2,3,4),imshow(cat(3, logo_red, logo_green, logo_blue));
title('Logo')
%Water Mark Logo, lines 17 & 18 also can be used for Logo extraction.

%%%RED
ImageFFT_r = fft2(red);
ImageFFTshift_r = fftshift(ImageFFT_r);
ImageFFTshift2_r = ImageFFTshift_r;%Is used for inserting the Logo far from center of FFT.
%Inserting the Logo to center of the FFT shifted Image. 
ImageFFTshift_r((ImageRows / 2) - (LogoRows/2 - 1) :(ImageRows / 2) + (LogoRows/2), ...
ImageColoumns / 2 - (LogoColoumns/2 - 1):(ImageColoumns / 2 + LogoColoumns/2)) = logo_red;
%Inserting the Logo outside the center of the FFT shifted Image. 
ImageFFTshift2_r(10:(10 + LogoRows - 1),5 : 5 + LogoColoumns - 1)= logo_red;
% Reversing the FFT to obtain Image in spatial domain for centred logo.
WaterMArkedImage_r = ifftshift(ImageFFTshift_r);
WaterMArkedImage_r = ifft2(WaterMArkedImage_r);
% Reversing the FFT to obtain Image in spatial domain for side logo.
WaterMArkedImage2_r = ifftshift(ImageFFTshift2_r);
WaterMArkedImage2_r = ifft2(WaterMArkedImage2_r);
%%%%%%

%%%GREEN
ImageFFT_g = fft2(green);
ImageFFTshift_g = fftshift(ImageFFT_g);
ImageFFTshift2_g = ImageFFTshift_g;%Is used for inserting the Logo far from center of FFT.
%Inserting the Logo to center of the FFT shifted Image. 
ImageFFTshift_g((ImageRows / 2) - (LogoRows/2 - 1) :(ImageRows / 2) + (LogoRows/2), ...
ImageColoumns / 2 - (LogoColoumns/2 - 1):(ImageColoumns / 2 + LogoColoumns/2)) = logo_green;
%Inserting the Logo outside the center of the FFT shifted Image. 
ImageFFTshift2_g(10:(10 + LogoRows - 1),5 : 5 + LogoColoumns - 1)= logo_green;
% Reversing the FFT to obtain Image in spatial domain for centred logo.
WaterMArkedImage_g = ifftshift(ImageFFTshift_g);
WaterMArkedImage_g = ifft2(WaterMArkedImage_g);
% Reversing the FFT to obtain Image in spatial domain for side logo.
WaterMArkedImage2_g = ifftshift(ImageFFTshift2_g);
WaterMArkedImage2_g = ifft2(WaterMArkedImage2_g);
%%%%%%

%%%BLUE
ImageFFT_b = fft2(blue);
ImageFFTshift_b = fftshift(ImageFFT_b);
ImageFFTshift2_b = ImageFFTshift_b;%Is used for inserting the Logo far from center of FFT.
%Inserting the Logo to center of the FFT shifted Image. 
ImageFFTshift_b((ImageRows / 2) - (LogoRows/2 - 1) :(ImageRows / 2) + (LogoRows/2), ...
ImageColoumns / 2 - (LogoColoumns/2 - 1):(ImageColoumns / 2 + LogoColoumns/2)) = logo_blue;
%Inserting the Logo outside the center of the FFT shifted Image. 
ImageFFTshift2_b(10:(10 + LogoRows - 1),5 : 5 + LogoColoumns - 1)= logo_blue;
% Reversing the FFT to obtain Image in spatial domain for centred logo.
WaterMArkedImage_b = ifftshift(ImageFFTshift_b);
WaterMArkedImage_b = ifft2(WaterMArkedImage_b);
% Reversing the FFT to obtain Image in spatial domain for side logo.
WaterMArkedImage2_b = ifftshift(ImageFFTshift2_b);
WaterMArkedImage2_b = ifft2(WaterMArkedImage2_b);
%%%%%%

%%plots
subplot(2,3,2),imshow(uint8(cat(3, WaterMArkedImage_r, WaterMArkedImage_g, WaterMArkedImage_b)))
title('Watermark at Image Centre')
subplot(2,3,5),imshow(cat(3, ImageFFTshift_r, ImageFFTshift_g, ImageFFTshift_b));
title('Embeded Logo in FFT2')
subplot(2,3,3),imshow(uint8(cat(3, WaterMArkedImage2_r, WaterMArkedImage2_g, WaterMArkedImage2_b)));
title('Watermark at Image Top-left')
subplot(2,3,6),imshow(cat(3, ImageFFTshift2_r, ImageFFTshift2_g, ImageFFTshift2_b));
title('Embeded Logo in FFT2')
