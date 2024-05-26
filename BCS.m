clc
clear
close all

%% Compression-encryption stage
imgOrg = double(imread('.\images\Lena.bmp'));                              % load plain image
[row,col] = size(imgOrg);
[h0,h1,f0,f1] = daub(8);                                                   % seting parameters for waveletpacket decomposition
basis2d = [3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3 ...
           3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3 ...
           3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3 ...
           3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3];
Iv = [0.123,0.231,0.445];
[phi] = Sbox(Iv);                                                          % constructing measurement matrix using S-box
y_1 = [0.1,0.1,0.1,0.1,0.1,0.1];
[~,yy] = ode45('FHN',(0:0.1:0.1*row*col),y_1);                             % constructing secret code streams
[~,z1] = sort([yy(:,1),yy(:,2)]);
imgCompact = zeros(row/2,col);
imgSpa = wpk2d(imgOrg,h0,h1,basis2d);                                      % sparse processing
imgCat = EnscrCat(imgSpa,z1);                                              % 2-D cat permutation
for i = 1:row/64
    for j = 1:col/64
        imgtmp1 = imgCat(64*i-63:64*i,64*j-63:64*j); 
        imgCompact(32*i-31:32*i,64*j-63:64*j) = phi*imgtmp1;               % compressed sampling
    end
end
mmax = max(imgCompact(:)); mmin = min(imgCompact(:));
imgQua = round(255*(imgCompact-mmin)/(mmax-mmin));                         % linear quantization
s1 = mod(floor((yy(end-row*col/2+1:end,3)+10)*10^10),256);
s2 = mod(floor((yy(end-row*col/2+1:end,4)+10)*10^10),256);
imgEnc = Diff(imgQua,s1,s2);                                               % Diffusion algorithm

%% Decryption-reconstruction stage
imgIdif = Idiff(imgEnc,s1,s2);                                             % Inverse diffusion algorithm
rec = zeros(64,64);
imgtmp2 = zeros(row,col);
for j = 1:row/64
    for k = 1:col/64
        for i = 1:64                                                       
            imgiQuantization = double(imgIdif(32*j-31:32*j,64*k-63:64*k))*(mmax-mmin)/255+mmin; % inverse quantization
%             rec(:,i) = OMP(imgiQuantization(:,i),phi,64);                  % OMP reconstruction algorithm
            rec(:,i) = SL0(phi,imgiQuantization(:,i),0.004);               % SL0 reconstruction algorithm
        end
        imgtmp2(64*j-63:64*j,64*k-63:64*k) = rec;
    end
end
imgiCat = DescrCat(imgtmp2,z1);                                            % inverse 2-D cat permutation 
imgDec = iwpk2d(imgiCat,f0,f1,basis2d);                                    % inverse sparse processing

%% Performance test stage
figure(2);
subplot(131); imshow(uint8(imgOrg)); title('Plain image');
subplot(132); imshow(uint8(imgEnc)); title('Encrypted image');
subplot(133); imshow(uint8(imgDec)); title('Reconstruction image');

psnr = PSNR(uint8(imgOrg),uint8(imgDec));                                                                                       
mssim = Mssim(uint8(imgOrg),uint8(imgDec));
fprintf('The MSSIM between plain image and decrypted image:\n');                                                                                                           
disp(mssim);
fprintf('The PSNR between plain image and decrypted image:\n');                                                                                                           
disp(psnr); 