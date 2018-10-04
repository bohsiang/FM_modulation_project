[x,fs]=audioread('lightning.wav');
fc = fs/5;
m=x(:,1);                       	
y=interp(m,1);
t = (0:1/fs:((size(y,1)-1)/fs))';
fDev = fc;
int_x = cumsum(m)/fs;
xfm = cos(2*pi*fc*t).*cos(2*pi*fDev*int_x)-sin(2*pi*fc*t).*sin(2*pi*fDev*int_x);
xi=cos(2*pi*fDev*int_x);
xq=sin(2*pi*fDev*int_x) ;
t2 = (0:1/fs:((size(xfm,1)-1)/fs))';
t2 = t2(:,ones(1,size(xfm,2)));
%--------method----------%
xfmq = hilbert(xfm).*exp(-j*2*pi*fc*t2);
z = (1/(2*pi*fDev))*[zeros(1,size(xfmq,2)); 
diff(unwrap(angle(xfmq)))*fs];
%-----------------------------------
figure;
plot(t,x,'b--',t2,z,'c');
xlabel('time ');
ylabel('amplitude');
legend('Original Signal','Demodulated Signal');
grid on
%----------------------------------
audioFile='test_music.wav';	
audiowrite(audioFile, z, fs);
%-----------------------------------
[x_1,fs]=audioread('lightning.wav');
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