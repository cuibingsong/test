V=double(rand(256,64));
W=double(rand(64,10));
delta_V=double(rand(256,64));
delta_W=double(rand(64,10));

yita=0.2;%����ϵ�����е����³�ѧϰ��
yita1=0.05;%���Լ��ӵĲ��������ż�������Ա�����ֹ���������뺯���ı�����������ȥ�����һ�±仯
train_number=9;%ѵ�������У��ж��ٸ����֣�һ��9����û��0
train_num=30;%ѵ�������У�ÿ�����ֶ�����ͼ��һ��100��
x=double(zeros(1,256));%�����
y=double(zeros(1,64));%�м�㣬Ҳ�����ز�
output=double(zeros(1,10));%�����
tar_output=double(zeros(1,10));%Ŀ����������������
delta=double(zeros(1,10));%һ���м���������Բ���

%��¼�ܵľ�������ڻ�ͼ
s_record=1:1000;
tic %��ʱ
for train_control_num=1:10   %ѵ���������ƣ��ڵ��ε������1000����ʵ�ж��ˣ����400����ȫ����
    s=0;
    %��ͼ����������
    for number=0:train_number
        ReadDir=['E:\Matlab\recognize_handwiting_numbers\train_lib\'];%��ȡ������·��
        for num=1:train_num  %���ƶ�����
            photo_name=[num2str(number),num2str(num,'%05d'),'.png'];%ͼƬ��
            photo_index=[ReadDir,photo_name];%·����ͼƬ���õ��ܵ�ͼƬ����
            photo_matrix=imread(photo_index);%ʹ��imread�õ�ͼ�����
            photo_matrix=rgb2gray(photo_matrix);
            thresh=graythresh(photo_matrix);
            photo_matrix=im2bw(photo_matrix,thresh);
            tmp=photo_matrix';
            tmp=tmp(:);%�������������ͼ���ά����ת��Ϊ��������256ά����Ϊ����
            %�������������
            x=double(tmp');%ת��Ϊ��������Ϊ�����X�������������һ�Ϊ������
            %�õ���������
            y0=x*V;
            %����
            y=1./(1+exp(-y0*yita1));
            %�õ����������
            output0=y*W;
            output=1./(1+exp(-output0*yita1));
            %����Ԥ�����
            tar_output=double(zeros(1,10));
            tar_output(number)=1.0;
            %�������
            %���չ�ʽ����W��V�ĵ�����Ϊ�˱���ʹ��forѭ���ȽϺķ�ʱ�䣬���������ֱ�Ӿ���˷�������Ч
            delta=(tar_output-output).*output.*(1-output);
            delta_W=yita*repmat(y',1,10).*repmat(delta,64,1);
            tmp=sum((W.*repmat(delta,64,1))');
            tmp=tmp.*y.*(1-y);
            delta_V=yita*repmat(x',1,64).*repmat(tmp,256,1);
            %���������
            s=s+sum((tar_output-output).*(tar_output-output))/10;
            %����Ȩֵ
            W=W+delta_W;
            V=V+delta_V;
        end
    end
    s=s/train_number/train_num  %���ӷֺţ���ʱ������ۿ��������
    train_control_num           %���ӷֺţ���ʱ������������ۿ�����״̬
    s_record(train_control_num)=s;%��¼
end
toc %��ʱ����
plot(1:1000,s_record);