%% ����ͼ���� ��ҵ9 (�ڰ���)
% ��ȪԴ 201930033629

img = imread('coser.jpg');
img = rgb2gray(img);
img = im2double(img);

imshow(img);
%%
[w, h] = size(img);

N = 8;
%%
zonal_encode = zeros(w, h);
thres_encode = zeros(w, h);

dct_zonal = zeros(w, h);
dct_thres = zeros(w, h);
%% 
% ��������������Ĥ��ֻ�������Ͻǵ�$\frac{N^2 }{2}$������
%%
zonal_mask = zeros(N);
for i=1:N
    if i>N/2
        for j=1:N-i
            zonal_mask(i, j) = 1;
        end
    else
        for j=1:N-i+1
            zonal_mask(i, j) = 1;
        end
    end 
end
disp(zonal_mask);
%% 
% ����������DCT�任��Ȼ��ֱ���������������ֵ���롣
% 
% �������ʱ��ʹ��8x8��DCT������Ĥ���е�����㣬ȡ��ǰ50%��ϵ����
% 
% ��ֵ����ʱ����Ҫ�Ƚ�DCT��չƽΪһά������Ȼ����ݾ���ֵ�������򣬱�������������ֵ����50%��Ԫ�أ�����Ԫ�����㣬Ȼ���ٽ���������ָ���8x8��DCT�顣ע�⵽*ȡ����ֵ�Ĳ����Ǳز����ٵ�*����Ϊ��ЩԪ���Ǹ�ֵ�����������Ԫ����Ϊ��С��ֵ�Ļ����ᵼ������������λ���Գƣ����ֲ�����ͼ�����쳣�����㡣
% 
% �������������DCT�������DCT���任�����Իָ���ԭʼͼ��
%%
for i=1:N:w
    for j=1:N:h
        % DCT transfer
        subimg = img(i:i+N-1, j:j+N-1);
        sub_dct = my_dct2dim(subimg);
        
        % by zonal encoding
        sub_dct_zonal_encode = sub_dct.*zonal_mask;
        dct_zonal(i:i+N-1, j:j+N-1) = sub_dct_zonal_encode;
        % inverse DCT transfer
        sub_img_zonal_decode = idct2(sub_dct_zonal_encode);
        zonal_encode(i:i+N-1, j:j+N-1) = sub_img_zonal_decode;
        
        % by threshold encoding
        sub_dct_fattern = reshape(sub_dct, [N*N, 1]);
        % Abs is important! Without abs, the result will be vary different.
        [~, index] = sort(abs(sub_dct_fattern));
        thres_rebulid = zeros(1, N*N);
        for k=1:N*N
            if k<N*N/2
                % set the 50% minimum element to zero
                thres_rebulid(index(k)) = 0;
            else
                % retain the 50% maximum element
                thres_rebulid(index(k)) = sub_dct_fattern(index(k));
            end
        end
        thres_rebulid = reshape(thres_rebulid, [N, N]);
        dct_thres(i:i+N-1, j:j+N-1) = thres_rebulid;
        % inverse DCT transfer
        sub_img_thres_decoder = idct2(thres_rebulid);
        thres_encode(i:i+N-1, j:j+N-1) = sub_img_thres_decoder;
    end
end
%%
figure;
subplot(1,2,1);
imshow(abs(dct_zonal).^0.3);
title('DCT Transfer through Zonal Encoding');
subplot(1,2,2);
imshow(abs(dct_thres).^0.3);
title('DCT Transfer through Threshold Encoding');
suptitle('DCT Transfer')
%% 
% ���㷴�任��ľ���������ʾ�����Կ�����ͨ����ֵ����Ľ����������С����Ϊ��ֵ���뻹��Ҫ��λ�ý��б��룬��Ҫʹ�ø������Ϣ��
%%
rms_zonal = abs(zonal_encode-img);
figure;
subplot(1,2,1);
imshow(zonal_encode);
title('IDCT Image');
subplot(1,2,2);
imshow((rms_zonal).^0.3);
title('MAE Error')
suptitle('IDCT Image by Zonal Encoding')
rms_thres = abs(thres_encode-img);
figure;
subplot(1,2,1);
imshow(thres_encode);
title('IDCT Image')
subplot(1,2,2);
imshow((rms_thres).^0.3);
title('MAE Error')
suptitle('IDCT Image by Threshold Encoding')
%% 
% ֱ�۶Ա����ֽ�������Կ������ֽ���Ļ�ԭ�ȶ�����������ͷ������֮��Ƚ�ϸ�ڵ����ݣ�������벻�ܹ��ܺõر��֡�
%%
figure;
subplot(1,2,1);
imshow(zonal_encode(220:290, 320:390))
title('Rebuild Image of Zonal Encoding')
subplot(1,2,2);
imshow(thres_encode(220:290, 320:390))
title('Rebuild Image of Threshold Encoding')
suptitle('Comparation of Zonal Encoding and Threshold Encoding')
%% 
% ����ͨ������һάDCT�任ʵ�ֶ�άDCT�任������dim��dimension����д��
%%
function y = my_dct1dim(x)
    % dct transfer in one dimentions
    [N, ~] = size(x);
    y = zeros(N, 1);
    for u=0:N-1
        y(u+1) = cos((1:2:2*N-1)*pi*u/2/N)*x;
        if u==0
            y(u+1) = y(u+1)*sqrt(1/N);
        else
            y(u+1) = y(u+1)*sqrt(2/N);
        end
    end
end


function y = my_dct2dim(x)
    [N, M] = size(x);
    y = zeros(N, M);
    for u=1:N
        y(u,:) = my_dct1dim(x(u,:)')';
    end
    for v=1:N
        y(:,v) = my_dct1dim(y(:,v));
    end
end