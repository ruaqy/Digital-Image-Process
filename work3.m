%% ����ͼ���� ��ҵ3 (3/18)
% ��ȪԴ 201930033629 ������
%% ֱ��ͼ���⻯

% ��ȡͼƬ
im_coser = imread('coser.jpg');

im_coser = rgb2gray(im_coser);

L = 256;
%% 
%     Ϊ����ʾЧ����������������Ҫ��ͼƬ����ѹ������Ŀ���ǽ��Ҷȼ���Ƶ���������м���������������Ҫ��ͼƬ��һΪ0~1֮�����ֵ��Ȼ��ȷ��һ�������������¼������ԣ�
% 
% # $T\left(1\right)=1$
% # $T\left(0\right)=0$
% # $T\left(0\ldotp 5\right)=0\ldotp 5$
% # ��0~0.5֮��Ϊ��͹����
% # ��0.5~1֮��Ϊ��͹����
% 
%     ���ǵ�������������${{T\left(r\right)=\sum_n \;a}_n r}^n$��һԪn�η��̣�ȡn=5��������$T\prime 
% \left(0\right)=T\prime \left(1\right)=5$����$T\prime \left(0\ldotp 5\right)=0\ldotp 
% 5$�������Եõ�����ʽ��ϵ����
%%
A = [1 1 1 1 1;5 4 3 2 1;
    0.5^5 0.5^4 0.5^3 0.5^2 0.5^1;
    5*0.5^4 4*0.5^3 3*0.5^2 2*0.5^1 1*0.5^0;
    0 0 0 0 1];
B = [1; 5; 0.5; 0.1; 5];
R = A\B;
x = 0:0.01:1;
y = R(1)*x.^5+R(2)*x.^4+R(3)*x.^3+R(4)*x.^2+R(5)*x.^1;
figure;
plot(x,y);
title('T(r)');
%% 
%     �ڽ��лҶ�ѹ��ǰ����Ҫ���Ҷ�ֵ��һ����0~1֮�䣬��������õ��ĺ���$T\left(r\right)$����ӳ�䣬���Եõ��Ҷȼ�ѹ�����ͼƬ��
%%
% �Ҷ�ѹ��
im_coser_norm = double(im_coser)/(L-1);

im_coser_zip = R(1)*im_coser_norm.^5+R(2)*im_coser_norm.^4+R(3)*im_coser_norm.^3+R(4)*im_coser_norm.^2+R(5)*im_coser_norm.^1;

im_coser_zip = uint8(255*im_coser_zip);

figure;
subplot(2,2,1)
imshow(im_coser)
title('before')

subplot(2,2,2)
imshow(im_coser_zip)
title('after')

subplot(2,2,3)
imhist(im_coser)
title('before')

subplot(2,2,4)
imhist(im_coser_zip)
title('after')
%% 
%     ��ͼ��ʾ�����Կ���ͼƬ���ģ�����塣���Ҷȼ�Ҳ��ѹ�����˱Ƚ��м��λ�á�
% 
%     ��������Ҫ�õ�ѹ�����ֱ��ͼ��
%%
hist_list = zeros(1,L);
for i=1:L
    hist_list(i) = sum(sum(im_coser_zip(:,:)==(i-1)));
end

[w,h] = size(im_coser_zip);
N = w*h;
hist_list = hist_list/N;
figure;
plot(hist_list)
%% 
%     �����������Ӧ�㷨�ָ�ͼƬ��
%%
im_out = zeros(w, h);

for i=1:L
    im_out(im_coser_zip==(i-1))=sum(hist_list(1:i));
end

im_out = uint8(round(im_out*(L-1)));

figure;
subplot(2,2,1)
imshow(im_coser_zip)
title('zip')

subplot(2,2,2)
imshow(im_out)
title('after')

subplot(2,2,3)
imhist(im_coser_zip)

subplot(2,2,4)
imhist(im_out)
%% 
%     ���Կ������ָ���ͼƬ��ѹ�����ͼƬ�Ӿ������Žϴ��������