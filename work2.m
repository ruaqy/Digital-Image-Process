%% ����ͼ���� ��ҵ2 (3/11)
% ��ȪԴ 201930033629 �ڶ���
%% 1.1 ��ͨ�ĻҶȱ任��ǿ

im_moon = imread('moon.jpeg');

im_moon_norm = double(im_moon)/(L-1);

im_exp = uint8(255*im_moon_norm.^0.5);
im_log = uint8(255*log10(9*im_moon_norm+1));

figure;
subplot(2,3,1)
imshow(im_moon)
title('before')

subplot(2,3,2)
imshow(im_exp)
title('exp:c=1 and gamma=0.3')

subplot(2,3,3)
imshow(im_log)
title('log:c=1 and gamma=0.3')

subplot(2,3,4)
imhist(im_moon)

subplot(2,3,5)
imhist(im_exp)

subplot(2,3,6)
imhist(im_log)
%% 
% ���������
% 
%     ԭʼ������ͼƬ�У����½� ����Ӱ���ֽ����ʾ��Ч�����á�
% 
%     �����Ҷȱ任��ǿ�󣬿��Կ������½ǵ������������Եĸ��ơ�
%% 1.2 һ��ĻҶȱ任��ǿ
%     Ϊ��ʵ��3����Ҫ��ͼƬ�ĻҶȼ�����ѹ�������Ҷȼ���Ƶ���������м���������������Ҫ��ͼƬ��һΪ0~1֮�����ֵ��Ȼ��ȷ��һ������������${{T\left(r\right)=\sum_n 
% \;a}_n r}^n$��һԪn�η��̣�ȡn=5��������$T\prime \left(0\right)=T\prime \left(1\right)=5$����$T\prime 
% \left(0\ldotp 5\right)=0\ldotp 5$�������Եõ�����ʽ��ϵ����
% 
%     �ٽ��лҶ�ѹ��ǰ����Ҫ���Ҷ�ֵ��һ����0~1֮�䣬��������õ��ĺ���$T\left(r\right)$����ӳ�䣬���Եõ��Ҷȼ�ѹ�����ͼƬ��

A = [1 1 1 1 1;5 4 3 2 1;
    0.5^5 0.5^4 0.5^3 0.5^2 0.5^1;
    5*0.5^4 4*0.5^3 3*0.5^2 2*0.5^1 1*0.5^0;
    0 0 0 0 1];
B = [1; 5; 0.5; 0.5; 5];
R = A\B;
x = 0:0.01:1;
y = R(1)*x.^5+R(2)*x.^4+R(3)*x.^3+R(4)*x.^2+R(5)*x.^1;

% �Ҷ�ѹ��
im_moon_norm = double(im_moon)/(L-1);

im_moon_zip = R(1)*im_moon_norm.^5+R(2)*im_moon_norm.^4+R(3)*im_moon_norm.^3+R(4)*im_moon_norm.^2+R(5)*im_moon_norm.^1;

im_moon_zip = uint8(255*im_moon_zip);

figure;
subplot(2,2,1)
imshow(im_moon)
title('before')

subplot(2,2,2)
imshow(im_moon_zip)
title('after')

subplot(2,2,3)
imhist(im_moon)
title('before')

subplot(2,2,4)
imhist(im_moon_zip)
title('after')


%% 2.����ֱ��ͼ
%     �Ҷ�ͳ��ֱ��ͼ�ǶԻҶȵȼ���ͳ��Ƶ����������$p\left(r_k \right)=\frac{n_k }{n}$����ó���

im_moon = imread('moon.jpeg');

im_moon = rgb2gray(im_moon);

L = 256;

hist_list = zeros(1,L);
for i=1:L 
    hist_list(i) = sum(sum(im_moon(:,:)==(i-1)));
end

[w,h] = size(im_moon);
N = w*h;
hist_list = hist_list/N;

figure;
hold on;
area(hist_list)
hold off;


xlim([0,255])
ylabel('Probability')
xlabel('Grayscale')
title('Histogram')
%% 
% ���������
% 
%     ֱ��ͼ��ͼ��ʾ�������������ͼƬ�Ҷ���Ҫ�ֲ��ڵͻҶ�����ȱ���߻Ҷ�����