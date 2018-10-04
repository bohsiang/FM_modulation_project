%-----------------------------2018 only-----------------------------------%
clear all;
close all;
clc;

[x,fs]=audioread('lightning.wav');
ts=1/fs; 
df=0.3;
m=x(:,1);
[M,m1,df1]=fftseq(m',ts,df);%快速傅立葉轉換
f=[0:df1:df1*(length(m1')-1)]-fs/2;%橫軸點數
%plot(f,abs(fftshift(M)))
%--------------------------------------------------------------------------
my_M=x(:,1);
N_short = length(x) ;
ts_short = 1/fs ;
fc = fs/5;  
fDev = fc;
t1 = ((0:N_short-1)*ts_short)';
y = fmmod(x,fc,fs,fDev);
%--------method----------%
z = fmdemod(y,fc,fs,fDev); 
%-----------------------------------------
figure;
subplot(2,1,1)
plot(t1,m)
xlabel('Time')
title('The message signal')
subplot(2,1,2)
plot(t1,z)
xlabel('Time')
title('The demodulated signal')
%sound(z, fs);	% 播放音訊
figure;
plot(t1,my_M,'b--',t1,z,'c');
xlabel('Time (s)')
ylabel('Amplitude')
legend('Original Signal','Demodulated Signal')
%----------------------------------
audioFile='test_music.wav';	
audiowrite(audioFile, z, fs);
%-----------------------------------
[x_1,fs]=audioread('lightning.wav');
figure;
plot(t1,x_1);
title('Demodilated sound file')
%-----------------------------------
[MOD_x, mod1,df1]=fftseq(x_1',ts,df);
f_x=[0:df1:df1*(length(mod1')-1)]-fs/2;
figure;
plot(f_x,abs(fftshift(MOD_x)))
title('Magnitude spectrum of the demodulated signal')
xlabel('Frequency')






