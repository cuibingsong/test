t=0:1/256:1;%��������
N=length(t); %�������
for i=1:N
    y(i)=2+3*10*t(i)*cos(2*pi*50*t(i)-pi*30/180)+1.5*10*t(i)*cos(2*pi*75*t(i)+pi*90/180);
end
plot(t,y);
fs=256;%����Ƶ��
df=fs/(N-1);%�ֱ���
f=(0:N-1)*df;%����ÿ���Ƶ��
Y=fft(y(1:N))/N*2;%��ʵ�ķ�ֵ
%Y=fftshift(Y);
figure(2)
plot(f(1:N/2),abs(Y(1:N/2)));