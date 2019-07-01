t=0:1/256:1;%采样步长
N=length(t); %样点个数
for i=1:N
    y(i)=2+3*10*t(i)*cos(2*pi*50*t(i)-pi*30/180)+1.5*10*t(i)*cos(2*pi*75*t(i)+pi*90/180);
end
plot(t,y);
fs=256;%采样频率
df=fs/(N-1);%分辨率
f=(0:N-1)*df;%其中每点的频率
Y=fft(y(1:N))/N*2;%真实的幅值
%Y=fftshift(Y);
figure(2)
plot(f(1:N/2),abs(Y(1:N/2)));