if ~exist('a','var')
    a=xlsread('spectrum.xlsx','sheet1','a1:a32768');
end
N=length(a); %�������
fs=5000;%����Ƶ��
df=(N-1)*fs/(N-1);%�ֱ���
f=(0:N-1)*df;%����ÿ���Ƶ��
Y=fft(a(1:N))/N*2;%��ʵ�ķ�ֵ
%Y=fftshift(Y);
figure(2)
plot(f(1:N/2),abs(Y(1:N/2)));
f=f';
sum=[f(1:N/2),abs(Y(1:N/2))];
xlswrite('y.xlsx',sum);