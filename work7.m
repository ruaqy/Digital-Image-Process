%% ����ͼ���� ��ҵ6 (4/16)
% ��ȪԴ 201930033629
%% ����Ӧ��ֵ�˲�
% ��ȡͼƬ

im_circuit = imread('circuit.jpg');
im_circuit = rgb2gray(im_circuit);
im_circuit = im2double(im_circuit);
im_noise = imnoise(im_circuit, 'gaussian', 0, 0.1);
figure;
imshow(im_noise);
%% 
% �������ķ���Ϊ$\sigma_{\eta \;}^2$���ֲ���ֵΪ$m_L$���ֲ�����Ϊ$\sigma {\;}_L^2$���ֲ�����Ĵ�СΪ$N\times 
% N$��������ͼƬ�д����оֲ������С�����ƽ̹���򣬴�ʱ��$\sigma_{\eta \;}^2 \le \sigma {\;}_L^2$���ڡ�
% 
% ��˶�ͼƬ���б�����������ȡ��С�����򷽲����Ϊ�������Ϊ������ţ�ѡ����С�����0.5%~1%��ƽ��ֵ��Ϊ��������Ĺ��ơ�
%%
N = 7;
[w, h] = size(im_noise);

win = floor(N/2);

% real_var = var(reshape(im_noise-im_circuit, 1, []));

im_sigma_L = zeros(floor(w/N), floor(h/N));

for i = 1:floor(w/N)
    for j = 1:floor(h/N)
        sub_im = im_noise(1+(i-1)*N:1+i*N, 1+(j-1)*N:1+j*N);
        sub_im = reshape(sub_im, 1, []);
        im_sigma_L(i, j) = var(sub_im);
    end
end

im_sigma_L = reshape(im_sigma_L, 1, []);
n = length(im_sigma_L);

im_sigma_L = sort(im_sigma_L);
sigma_eta = im_sigma_L(floor(n/200):floor(n/100));
sigma_eta = mean(sigma_eta);
%% 
% ����ͼƬ���д�������$\hat{\;f} \left(x,y\right)=g\left(x,y\right)-\frac{\sigma_{\eta 
% \;}^2 }{\sigma_L^2 \;}\left(g\left(x,y\right)-m_L \right)$���õ�ԭʼͼƬ�Ĺ��ơ�
%%
im_out = im_noise;

for i = 1+win:w-win
    for j = 1+win:h-win
        sub_im = im_noise(i-win:i+win, j-win:j+win);
        sub_im = reshape(sub_im, 1, []); 
        m_L = mean(sub_im);
        sigma_L = var(sub_im-m_L);
        im_out(i,j) = im_noise(i,j)*(1-sigma_eta/sigma_L)+m_L*(sigma_eta/sigma_L);
    end
end
figure;
imshow(im_out)
%%
im_mean = conv2(im_noise, ones(N, N)/(N*N));
im_mean = im_mean(win+1:win+w, win+1:win+h);

figure;
subplot(1,2,1)
imshow(im_out)
title('Auto-Fit Average Filter')
subplot(1,2,2)
imshow(im_mean)
title('Average Filter')
suptitle('Output through Different Filters')
figure;
subplot(1,2,1)
imshow(abs(im_circuit-im_out).^0.3)
title('noise image')
title('Auto-Fit Average filter')
subplot(1,2,2)
imshow(abs(im_circuit-im_mean).^0.3)
title('Average Filter')
suptitle('Residue Among Output through filter and Orignal Image')
%% 
% ���������⣺�������Ĺ��Ʋ�̫��ȷ��
% 
% ���������ͨ�����ֵ���й��ơ�
%% �������
% ���Կ���������Ӧ��ֵ�˲�����Ч������ͨ��ֵ�˲���Ҫ���ã������ȸ����Լ������ԭʼͼƬ�Ĳв��С��