%% ����ͼ���� ��ҵ5 (4/1)
% ��ȪԴ 201930033629
%% ͼ����Ҷ�任
%     ���Ƚ���ͼ���ȡ��

im_coser = imread('coser.jpg');

im_coser = rgb2gray(im_coser);

im_coser = im2double(im_coser);

[w, h] = size(im_coser);
%% 
%     �������м������裺
% 
% # ����$x+y$�ľ���
% # ��ԭͼ����${\left(-1\right)}^{x+y}$��ˣ��õ�Ƶ��ͼ��
% # �ֱ��x������y�����ͼ�����FFT�任���õ�fft�任���
% # ͨ�������任ѹ�����ݷ�Χ����ʾfftͼ��
%%
% generate x+y matrix
[x, y] = meshgrid(0:h-1, 0:w-1);

x_plus_y = x+y;

% multiply the original image and -1^(x+y)
im_scale = im_coser.*(-1).^(x_plus_y);

im_fft = zeros(w, h);

% MxN times FFT with one axis to tackle FFT with two axes
for i=1:h
    im_fft(:,i)=fft(im_scale(:,i));
end

for i=1:w
    im_fft(i,:)=fft(im_fft(i,:));
end

% zip the range of data
zip_im_fft = log(1+im_fft);

% display
figure;
imagesc(real(zip_im_fft))
title('FFT with two axes by MxN FFT with one axes')
%% 
%     Ϊ����֤�������ȷ�ԣ�ʹ��MATLAB�Դ��ĺ������ж�άFFT�������ͼ��ʾ�����Կ������һ�¡�
%%
im_fft2 = fft2(im_coser);
im_fft2 = fftshift(im_fft2);

im_fft2_zip = log(1+im_fft2);

figure;
imagesc(real(im_fft2_zip));
title('FFT by  software')
%% 
%     ������֤ͼ��ĸ���Ҷ�任�����ȷ��