correct_num=0;%��¼��ȷ������
incorrect_num=0;%��¼��������
test_number=9;%���Լ��У�һ���������֣�9����û��0
test_num=100;%���Լ��У�ÿ�����ֶ��ٸ������100��
% load W;%%֮ǰѵ���õ���W�����ˣ�����ֱ�Ӽ��ؽ���
% load V;
% load yita1;

%��¼ʱ��
tic %��ʱ��ʼ
for number=1:test_number
ReadDir=['E:\Matlab\recognize_handwiting_numbers\test_lib\'];
for num=1:test_num  %���ƶ�����
photo_name=[num2str(number),num2str(num,'%05d'),'.png'];
photo_index=[ReadDir,photo_name];
photo_matrix=imread(photo_index);
%��С�ı�
photo_matrix=imresize(photo_matrix,[16 16]);
%��ֵ��
photo_matrix=uint8(photo_matrix<=230);%��ɫ��1
%������
tmp=photo_matrix';
tmp=tmp(:);
%�������������
x=double(tmp');
%�õ���������
y0=x*V;
%����
y=1./(1+exp(-y0*yita1));
%�õ����������
o0=y*W;
o=1./(1+exp(-o0*yita1));
%�����������ʶ�𵽵�����
[o,index]=sort(o);
if index(10)==number
    correct_num=correct_num+1
else
    incorrect_num=incorrect_num+1;
    %��ʾ���ɹ������֣���ʾ��Ƚϻ�ʱ��
%     figure(incorrect_num)
%     imshow((1-photo_matrix)*255);
%     title(num2str(number));
end
end
end
correct_rate=correct_num/test_number/test_num
toc %��ʱ����