if ~exist('a','var')
    a=xlsread('spectrum.xlsx','sheet1','a1:a32768');
end
N=length(a); %样点个数
fs=5000;%采样频率
df=(N-1)*fs/(N-1);%分辨率
f=(0:N-1)*df;%其中每点的频率
Y=fft(a(1:N))/N*2;%真实的幅值
%Y=fftshift(Y);
figure(2)
plot(f(1:N/2),abs(Y(1:N/2)));
f=f';
sum=[f(1:N/2),abs(Y(1:N/2))];
xlswrite('y.xlsx',sum);