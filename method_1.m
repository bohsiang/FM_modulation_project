
clear all;
close all;
clc;

[x,fs]=audioread('lightning.wav');
m=x(:,1);                               
fc = fs/5;                              
ts=1/fs; 
df=0.1;                              	
y=interp(m,1);
t = (0:1/fs:((size(y,1)-1)/fs))';
kf=fc;                              	

[M,m1,df1]=fftseq(m',ts,df);           	
M=M/fs;                              	
f=[0:df1:df1*(length(m1)-1)]-fs/2;    	
%--------method----------%
u=cos(2*pi*fc*t+2*pi*kf*cumsum(m)/fs);  
[U,u,df1]=fftseq(u',ts,df);           	
U=U/fs;                              	
[v,phase]=env_phas(u,ts,fc);        	
phi=unwrap(phase);                      
dem=(1/(2*pi*kf))*(diff(phi)/ts);    	
%----------------------------------
figure;
subplot(2,1,1)
plot(t,m(1:length(t)))
xlabel('Time')
title('The message signal')
subplot(2,1,2)
plot(t,dem(1:length(t)))
xlabel('Time')
title('The demodulated signal')
%----------------------------------
figure;
plot(t,m,'b--',t,dem(1:length(t)),'c');
xlabel('Time (s)')
ylabel('Amplitude')
legend('Original Signal','Demodulated Signal')
%----------------------------------
audioFile='test_music.wav';	
audiowrite(audioFile, dem(1:length(t)), fs);
%-----------------------------------
[x_1,fs]=audioread('test_music.wav');
figure;
plot(t,x_1);
title('Demodilated sound file')
%-----------------------------------
[MOD_x, mod1,df1]=fftseq(x_1',ts,df);
f_x=[0:df1:df1*(length(mod1')-1)]-fs/2;
figure;
plot(f_x,abs(fftshift(MOD_x)))
title('Magnitude spectrum of the demodulated signal')
xlabel('Frequency')


