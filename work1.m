%% ����ͼ���� ��ҵ1 (3/4)
% ��ȪԴ 201930033629 ��һ��
%% 1.ͬʱ�Աȶ�ʵ��
%%
clear; close all;clc;

N=5;k=1;

figure;

before1= 128;ground1=64;
img1 = uint8(ground1*ones(N,N));
img1(ceil(N/2)-floor(k/2):ceil(N/2)+floor(k/2),ceil(N/2)-floor(k/2):ceil(N/2)+floor(k/2)) = before1;
subplot(1,2,1);
imshow(img1);
title(sprintf("Before:%d Ground:%d",before1,ground1))

before2= 128;ground2=192;
img2 = uint8(ground2*ones(N,N));
img2(ceil(N/2)-floor(k/2):ceil(N/2)+floor(k/2),ceil(N/2)-floor(k/2):ceil(N/2)+floor(k/2)) = before2;
subplot(1,2,2);
imshow(img2);
title(sprintf("Before:%d Ground:%d",before2,ground2))

suptitle('Simultaneous Contrast Experiment')
%% 
% ���������
% 
%     ����ͬ���ȵĴ̼��£����ڱ������Ȳ�ͬ�����ۿ�������������Ҳ��ͬ��
%% 2.�ռ�ֱ���ʵ��
%     dpi��ָDots Per Inch,����ͼƬ��С���䣬ͨ���²����ķ�ʽ�ܹ��ı�ͼƬ��dpi��
%%
clear; close all;clc;

img_coser = imread('coser.jpg');

img_coser = rgb2gray(img_coser);

figure;

subplot(2,3,1);
imshow(img_coser)
title('512x512')

[w,h] = size(img_coser);

img2 = img_coser(1:2:w,1:2:h);
subplot(2,3,2);
imshow(img2)
title('256x256')

img3 = img_coser(1:4:w,1:4:h);
subplot(2,3,3);
imshow(img3)
title('128x128')

img4 = img_coser(1:8:w,1:8:h);
subplot(2,3,4);
imshow(img4)
title('64x64')

img5 = img_coser(1:16:w,1:16:h);
subplot(2,3,5);
imshow(img5)
title('32x32')

img6 = img_coser(1:32:w,1:32:h);
subplot(2,3,6);
imshow(img6)
title('16x16')

suptitle('Space Sensitive Experiment')
%% 
% ���������
% 
%     ����ͨ����ֵ�²����ķ�ʽ����õ׿ռ�ֱ��ʵ�ͼ��
% 
%     �ռ�ֱ���Խ�ͣ�ͼ��Խģ����
%% 3. ���ȷֱ���ʵ��
%     ͼƬ�ǰ���8λ�������������飬ͨ�����ε�λ���ݿ��Եõ���ͬ�ռ�ֱ��ʵ�ͼƬ��
%%
clear; close all;clc;

img_coser = imread('coser.jpg');

img_coser = rgb2gray(img_coser);

figure;

subplot(2,3,1);
imshow(img_coser)
title('256 level')

% ��λ��
% ��յ�λ����
img2 = bitor(img_coser, 3);
subplot(2,3,2);
imshow(img2)
title('64 level')

img3 = bitor(img_coser, 15);
subplot(2,3,3);
imshow(img3)
title('16 level')

img4 = bitor(img_coser, 31);
subplot(2,3,4);
imshow(img4)
title('8 level')

img5 = bitor(img_coser, 63);
subplot(2,3,5);
imshow(img5)
title('4 level')

img6 = bitor(img_coser, 127);
subplot(2,3,6);
imshow(img6)
title('2 level')

suptitle('Amplitude Sensitive Experiment')
%% 
% ���������
% 
%     ����ͨ��λ���㽫ͼ���λ�������������õ���ͬ���ȷֱ��ʵ�ͼ�񡣵���������ȱ���ǣ����ͼ������ƫ��������ƫ���Ļ�������ʧ�϶��ͼƬϸ�ڡ�