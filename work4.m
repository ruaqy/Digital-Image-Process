%% ����ͼ���� ��ҵ4 (3/25)
% ��ȪԴ 201930033629 
%% 1 ƽ��ȥ��˹������

im_coser = imread('coser.jpg');

[w, h, d] = size(im_coser);


depth = [1,16,64,128];

figure;

for N=depth
    
    im_coser_noise = zeros(w, h, d, N);
    
    for i=1:N
        im_coser_noise(:,:,:,i) = imnoise(im_coser, 'gaussian', 0, 1);
    end
    
    im_mean = zeros(w, h, d);
    
    for i=1:N
        im_mean = im_mean + im_coser_noise(:,:,:,i)/N;
    end
    
    im_mean = uint8(im_mean);
    
    subplot(2,2,find(N==depth))
    imshow(im_mean);
    title(['Depth:',num2str(N)])
end
suptitle('Different Depth Average of Image with Gaussian Noise')
%% 
% ���������
% 
%     ԭʼͼ����Ͼ�ֵΪ0������Ϊ1�ĸ�˹���������廭����ģ�����壬����ܹ����ö��ŵ�����������ͼƬ���о�ֵ�������ܹ�����������������Ч�������ŵ���ͼƬ���������������ߡ�
%% 2 ��ֵ�˲�ȥ��˹������
%%
im_coser_noise = imnoise(im_coser, 'gaussian', 0, 1);

kernel_size = [1,2,4,8];

figure;

for N=kernel_size
    kernel = ones(N,N)/(N^2);
    
    im_out = convn(im_coser_noise, kernel);
    
    im_out = uint8(im_out);
    
    subplot(2, 2, find(N==kernel_size));
    imshow(im_out);
    title(['Kernel Size:',num2str(N)]);
end
suptitle('Average Filter of Image with Gaussian Noise')
%% 
% ���������
% 
%     ���þ�ֵ��ȥ��˹�������ķ�����һ����Ч������Ч�������á��������ϴ�ʱ���ɴ����Ŵ�����ģ����
%% 3 ��ֵ�˲�ȥ��������
%%
im_coser_noise = imnoise(im_coser, 'salt & pepper');

win_size = [1,2,3,4];

figure;

for N = win_size
    
    im_max = zeros(w+floor(N/2)*2, h+floor(N/2)*2, d);
    im_max(1+floor(N/2):w+floor(N/2), 1+floor(N/2):h+floor(N/2), :) = im_coser_noise;
    
    if N ~= 1
        im_out = zeros(w, h, d);
        for j = 1:w
            for k = 1:h
                im_cut = im_max(j:j+N-1,k:k+N-1,:);
                im_cut = reshape(im_cut,N^2,3);
                im_cut_sort = sort(im_cut);
                if  mod(N^2/2,2) == 0
                    im_out(j,k,:) = [mean([im_cut_sort(floor(N^2/2),1),im_cut_sort(floor(N^2/2)+1,1)]);
                        mean([im_cut_sort(floor(N^2/2),2),im_cut_sort(floor(N^2/2)+1,2)]);
                        mean([im_cut_sort(floor(N^2/2),3),im_cut_sort(floor(N^2/2)+1,3)])];
                else
                    im_out(j,k,:) = [im_cut_sort(floor(N^2/2)+1,1);
                        im_cut_sort(floor(N^2/2)+1,2);
                        im_cut_sort(floor(N^2/2)+1,3)];
                end
            end
        end
    else
        im_out = im_coser_noise;
    end
    subplot(2,2,find(N==win_size));
    im_out = uint8(im_out);
    imshow(im_out);
    title(['Kernel Size:', num2str(N)]);    
end
suptitle('Median Filter of Image with Impulse Noise');
%% 
% ���������
% 
%     ������ֵ�˲��ķ����������������������������ǳ���Ч��������ѡ�񴰿ڵ�����ͼƬ����ģ�����塣
%% 4 ͼ������ǿ
%%
im_moon = imread('moon.jpeg');
im_moon = imresize(im_moon,0.5);

Laplacian_4 = [0, -1, 0; -1, 5 -1; 0, -1, 0];
Laplacian_8 = [-1, -1, -1; -1, 9 -1; -1, -1, -1];

Sobel_x = [-1, 0, 1;-2, 1, 2;-1, 0, 1];
Sobel_y = [-1, -2, -1;0, 1, 0;1, 2, 1];

im_L4 = convn(im_moon,Laplacian_4);
im_L8 = convn(im_moon,Laplacian_8);
im_Sx= convn(im_moon,Sobel_x);
im_Sy = convn(im_moon,Sobel_y);

im_L4 = uint8(im_L4);
im_L8 = uint8(im_L8);
im_Sx = uint8(im_Sx);
im_Sy = uint8(im_Sy);

for i=1:1
    figure;
    imshow(im_moon);
    suptitle('Original Image without process');
    
    figure;
    subplot(1,2,1);
    imshow(im_L4);
    title(' 4 neiberhood Laplacian Kernel')
    
    subplot(1,2,2);
    imshow(im_L8);
    title(' 8 neiberhood Laplacian Kernel')
    
    suptitle('Sharpen Enhancing of Image with Laplacian Kernel')
    
    figure;
    subplot(1,2,1);
    imshow(im_Sx);
    title('Sobel Kernel in X-axis')
    
    subplot(1,2,2);
    imshow(im_Sy);
    title('Sobel Kernel in Y-axis')
    
    suptitle('Sharpen Enhancing of Image with Sobel Kernel')
end
%% 
% ���������
% 
%     �����ԭʼͼƬ���񻯺��ͼƬ��Ե��ø������ԡ�
% 
%     ������������˹���ӵ�Ч�����������Ч�����ã�ͼƬ��Ե��ø���ͻ����
% 
%     �����������˹���ӣ����������ӵ���Ч����Ϊ������