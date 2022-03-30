%% Prepare
clear, clc;
% orignGraph = readmatrix('SJTU.xlsx');
%orignGraph = [1 0 0 0 1 1 1 0 1 1 1;1 0 0 0 1 0 0 0 1 0 0;1 0 0 0 1 0 0 0 1 1 1;1 1 1 0 1 1 1 0 1 0 0;].*(-2) + 1;
%orignGraph = [1 1 1 0 1 1 1 0 1 1 1 0 1 0 1;1 0 0 0 0 1 0 0 0 1 0 0 1 0 1;1 1 1 0 0 1 0 0 0 1 0 0 1 0 1;0 0 1 0 0 1 0 0 0 1 0 0 1 0 1;1 1 1 0 1 1 0 0 0 1 0 0 1 1 1;].*(-2) + 1;
orignGraph = [1 0 0 1 1 0 1 1 1 0 1];
% subplot(3,2,1);
% imshow(orignGraph);
% title('Origin');

T = 4;
inT = 16;
arrayNum = 10; % number of antennas
aimTheta = 35; % deg
ang1 = -90; % Harmonic 
ang2 = 90; % Harmonic

fp = 1e7; % pulse frequency
fs = 1e11; %采样频率
fd = 1e6; %数据频率
fLO = 4.21e9; % local carrier
c = 3e8;
lambda = c/fLO;
% pulse parameters
Tp = 1/fp;
tau = Tp/3;
beta = 2*pi/lambda;

A0 = 0.2;

lambda = c/fLO;
z = lambda/T; % distance between two antennas

fIF=4e6;%IF Carrier Frequency fc

data=orignGraph(:);
dataLen=length(data)/fd;%data length 40*Td
t = 0:1/fs:dataLen;

dataTemp=ones((fs/fd),1)*data';%Dealing with Each Bit Td/Ts = fs/fd
dataPlot=dataTemp(:);%Makes data vector fit the time vector 扩展一下使得时间符合
t = t(1:length(dataPlot));

ModulatedData = A0.*cos((2*pi*(fLO)).*t)'.*dataPlot;

%% MetaSurface simulation (Modified)

theta = aimTheta; % target location
alpha = theta; % observe location

delta_modify = lambda*sind(theta)/inT/c;
% 
delta_t = z*sind(alpha)/c; % time delay of two signal
delta_tt = delta_t/(1/fs); % transfer the time delay to the array index 这个时间里能跑多少数据量

resSig = zeros(1, length(ModulatedData));
% 
% for i = 1:arrayNum
%         t1i = (((i-1)*beta*z*sind(theta))/pi-1/3)/2*Tp;
% %         Sigi = ModulatedData'.*( pulse1(t11,tau,t11+Tp/2,Tp,t,fs,delta)... 
% %                                + 1i.*pulse2(t11,tau,t11+Tp/2,Tp,t,fs,delta)... 
% %                                - pulse3(t11,tau,t11+Tp/2,Tp,t,fs,delta)...
% %                                - 1i.*pulse4(t11,tau,t11+Tp/2,Tp,t,fs,delta) );
%                            
%         Sigi1 = pulseNew(t1i, tau,Tp,t,fs, -3/2*delta_modify, ModulatedData'); % t1n, -3/2
%         Sigi2 = 1i.* pulseNew(t1i + Tp/4, tau,Tp,t,fs, -1/2*delta_modify, ModulatedData'); %t2n', -1/2
%         Sigi3 = pulseNew(t1i + Tp/2, tau,Tp,t,fs, 1/2*delta_modify, ModulatedData'); % t2n, 1/2
%         Sigi4 =  1i.* pulseNew(t1i - Tp/4, tau,Tp,t,fs, 3/2*delta_modify, ModulatedData'); % t1n', 3/2
%         
%         resSig = resSig + circshift(Sigi1, -floor(delta_tt*(i-1) + 1.5*lambda/inT*sind(theta)/c/(1/fs) ))...
%                         + circshift(Sigi2, -floor(delta_tt*(i-1) + 0.5*lambda/inT*sind(theta)/c/(1/fs) ))...
%                         - circshift(Sigi3, -floor(delta_tt*(i-1) - 0.5*lambda/inT*sind(theta)/c/(1/fs) ))...
%                         - circshift(Sigi4, -floor(delta_tt*(i-1) - 1.5*lambda/inT*sind(theta)/c/(1/fs) ));
% end
% 
% RFReceived=real(resSig'); % received signal
% 
% % final received data
% DownReceived=RFReceived.*cos((2*pi*(fLO + fp)).*t)';
% RFFiltered=lowpass(DownReceived,fd,fs);
% 
% [ro, co] = size(orignGraph);
% FinalData = reshape((2*RFFiltered(1:fs/fd:end)),[ro, co]);

%% Harmonic
step = 0.1;
p1 = [];
p_1 = [];
p5 = [];
p_7 = [];
p_3 = [];
p3 = [];
p2 = [];
p_5 = [];
p7 = [];
p9 = [];
p_9 = [];
for alpha = ang1:step:ang2
    disp(alpha);
    
    delta_t = z*sind(alpha)/c; % time delay of two signal
    delta_tt = delta_t/(1/fs); % transfer the time delay to the array index 这个时间里能跑多少数据量
    
    
%     for i = 1:arrayNum
%         t1i = (((i-1)*beta*z*sind(theta))/2/pi-1/6)*Tp;
% %         Sigi = ModulatedData'.*( pulse1(t11,tau,t11+Tp/2,Tp,t,fs,delta)... 
% %                                + 1i.*pulse2(t11,tau,t11+Tp/2,Tp,t,fs,delta)... 
% %                                - pulse3(t11,tau,t11+Tp/2,Tp,t,fs,delta)...
% %                                - 1i.*pulse4(t11,tau,t11+Tp/2,Tp,t,fs,delta) );
%                            
%         Sigi1 = pulseNew(t1i, tau,Tp,t,fs, -3/2*delta_modify, ModulatedData'); % t1n, -3/2
%         Sigi2 = pulseNew(t1i + Tp/4, tau,Tp,t,fs, -1/2*delta_modify, ModulatedData'); %t2n', -1/2
%         Sigi3 = pulseNew(t1i + Tp/2, tau,Tp,t,fs, 1/2*delta_modify, ModulatedData'); % t2n, 1/2
%         Sigi4 = pulseNew(t1i - Tp/4, tau,Tp,t,fs, 3/2*delta_modify, ModulatedData'); % t1n', 3/2
%         
%         resSig = resSig +circshift(Sigi1, -floor(delta_tt*(i-1) - 1.5*lambda/inT*sind(theta)/c/(1/fs) )).*ModulatedData'...
%                         + 1i.*circshift(Sigi2, -floor(delta_tt*(i-1) - 0.5*lambda/inT*sind(theta)/c/(1/fs) )).*ModulatedData'...
%                         - circshift(Sigi3, -floor(delta_tt*(i-1) + 0.5*lambda/inT*sind(theta)/c/(1/fs) )).*ModulatedData'...
%                         - 1i.*circshift(Sigi4, -floor(delta_tt*(i-1) + 1.5*lambda/inT*sind(theta)/c/(1/fs) )).*ModulatedData';
%     end


    delta_t = z*sind(alpha)/c; % time delay of two signal
    delta_tt = delta_t/(1/fs); % transfer the time delay to the array index 这个时间里能跑多少数据量
    t11 = -Tp/6;
    delta = Tp/1000;
    resSig = ModulatedData'.* (pulse(t11,tau,t11+Tp/2,Tp,t,fs,delta) - 1i.*pulse(t11-Tp/4,tau,t11+Tp/4,Tp,t,fs,delta ) );
    for i=2:arrayNum
        t1i = (((i-1)*beta*z*sind(theta))/pi-1/3)/2*Tp;
        Sigi = ModulatedData'.* ( pulse(t1i,tau,t1i+Tp/2,Tp,t,fs,delta) - 1i.*pulse(t1i-Tp/4,tau,t1i+Tp/4,Tp,t,fs,delta) );
        resSig = resSig + circshift(Sigi, -floor(delta_tt*(i-1)));
    end
    
    
    
    [f2,FFTsig]=SSBFFT(resSig,fs);
    
     p11 = find(f2>(fLO+0.7*fp),1);
     p12 = find(f2>(fLO+1.3*fp),1);
     p1 = [p1,sum(abs(FFTsig(p11:p12)))];
     
     p_11 = find(f2>(fLO-1.3*fp),1);
     p_12 = find(f2>(fLO-0.7*fp),1);
     p_1 = [p_1,sum(abs(FFTsig(p_11:p_12)))];
     
     p51 = find(f2>(fLO+4.7*fp),1);
     p52 = find(f2>(fLO+5.3*fp),1);
     p5 = [p5,sum(abs(FFTsig(p51:p52)))];
     
     p_71 = find(f2>(fLO-7.3*fp),1);
     p_72 = find(f2>(fLO-6.7*fp),1);
     p_7 = [p_7,sum(abs(FFTsig(p_71:p_72)))];
     
%      p21 = find(f2>(fLO+1.7*fp),1);
%      p22 = find(f2>(fLO+2.3*fp),1);
%      p2 = [p2,sum(abs(FFTsig(p21:p22)))];
%      
%      p_21 = find(f2>(fLO-2.3*fp),1);
%      p_22 = find(f2>(fLO-1.7*fp),1);
%      p_2 = [p_2,sum(abs(FFTsig(p_21:p_22)))];
%      
%      p31 = find(f2>(fLO+2.7*fp),1);
%      p32 = find(f2>(fLO+3.3*fp),1);
%      p3 = [p3,sum(abs(FFTsig(p31:p32)))];
%      
%      p_31 = find(f2>(fLO-3.3*fp),1);
%      p_32 = find(f2>(fLO-2.7*fp),1);
%      p_3 = [p_3,sum(abs(FFTsig(p_31:p_32)))];

     p_51 = find(f2>(fLO-5.3*fp),1);
     p_52 = find(f2>(fLO-4.7*fp),1);
     p_5 = [p_5,sum(abs(FFTsig(p_51:p_52)))];
     
     p71 = find(f2>(fLO+6.7*fp),1);
     p72 = find(f2>(fLO+7.3*fp),1);
     p7 = [p7,sum(abs(FFTsig(p71:p72)))];
     
     p91 = find(f2>(fLO+8.7*fp),1);
     p92 = find(f2>(fLO+9.3*fp),1);
     p9 = [p3,sum(abs(FFTsig(p91:p92)))];
     
     p_91 = find(f2>(fLO-9.3*fp),1);
     p_92 = find(f2>(fLO-8.7*fp),1);
     p_9 = [p_3,sum(abs(FFTsig(p_91:p_92)))];
end


figure(1)
hold on
box on
set(gca,'linewidth',1.5,'FontSize',13,'FontWeight','bold')
grid on

hold on;
m = max(p1);
% subplot(3,2,6);
%plot(ang1:step:ang2, p1,ang1:step:ang2,p_1,ang1:step:ang2,p5,ang1:step:ang2,p_7);
p_1 = 20.*log(p_1./m)/log(10);
p1 = 20.*log(p1./m)/log(10);
p_5 = 20.*log(p_5./m)/log(10);
p7 = 20.*log(p7./m)/log(10);
p_9 = 20.*log(p_9./m)/log(10);
p9 = 20.*log(p9./m)/log(10);
p5 = 20.*log(p5./m)/log(10);
p_7 = 20.*log(p_7./m)/log(10);

x00 = -35;
p1(p1<x00) = x00;
p_1(p_1<x00) = x00;
p7(p7<x00) = x00;
p_5(p_5<x00) = x00;
p9(p9<x00) = x00;
p_9(p_9<x00) = x00;
p5(p5<x00) = x00;
p_7(p_7<x00) = x00;

plot(ang1:step:ang2,p1,'-','LineWidth',1.5);
plot(ang1:step:ang2,p_1,'--','LineWidth',1.5);
plot(ang1:step:ang2,p5,'--','LineWidth',1.5);
plot(ang1:step:ang2,p_5,'--','LineWidth',1.5);
plot(ang1:step:ang2,p_7,'--','LineWidth',1.5);
xlabel('\textbf{$\theta (^{\circ})$}','Interpreter','Latex','FontSize',15);
ylabel('\textbf{Normalized Power (dB)}','Interpreter','Latex','FontSize',15);
legend({'$f_0 + f_h$','$f_0 - f_h$','$f_0 + 5f_h$',...
    '$f_0 - 5f_h$','$f_0 - 7f_h$'},'FontSize',12,'Interpreter','Latex')


%% ========================FFT Function=====================================
function [f1,FFTSSB]=SSBFFT(signal1,fs)
    L=length(signal1);
    NFFY=2^nextpow2(L);
    %To make FFT efficient, we want NFFY to be the 2's integer's power.
    FFTSSB=fft(signal1,NFFY);%to last several terms pad with zeros
    %To divide the spectrum into 2 while taking the DC term into considering 
    NumUniquePts=ceil((NFFY+1)/2);
    FFTSSB=FFTSSB(1:NumUniquePts);
    FFTSSB=abs(FFTSSB)*2/L;%*2 for SSB, /length for normalize
    %Cut the DC part and the last Part since they belongs to both sides
    FFTSSB(1)=FFTSSB(1)/2;FFTSSB(end)=FFTSSB(end)/2;
    %for SSB, divide Sampling Rate by 2
    f1=(fs/2*linspace(0,1-1/NumUniquePts,NumUniquePts))';
end

%% pulse function (Two)
function res=pulseNew(t1,tau,Tp,totalTime,fs,delta_modify, ModulatedData)

    pp(1 : floor((tau)*fs)) = 1;
    pp( (floor((tau)*fs)+1) : (floor(Tp*fs)+1) ) = 0;
    
    pp = circshift(pp, floor(t1*fs) ); 

    pp = repmat(pp, 1, ceil(totalTime(length(totalTime))/Tp)+1);
    pp = pp(1:length(totalTime));

    res = circshift(pp, floor(delta_modify*fs) );  %减去的话输入需为负
end

function res=pulse(t1,tau,t2,Tp,totalTime,fs,delta)
    % repmat
    temp = 0:1/fs:delta;
    slope = temp/delta;
    len = length(slope);
    
    pp(1:len) = slope;
    pp(floor((delta)*fs)+1 : floor((tau)*fs)+1) = 1;
    
    
    pp(floor((tau)*fs)+1 : floor((tau)*fs)+len) = 1-slope;
    pp(floor((tau+delta)*fs)+1 : floor((t2-t1)*fs)+1) = 0;
%     % debug
%     floor((tau+delta)*fs)+1
%     floor((Tp/2)*fs)+1
%     floor((t2-t1)*fs)+1
       
    pp(floor((t2-t1)*fs)+1 : floor((t2-t1)*fs)+len) = -slope;   
    pp(floor((t2-t1+delta)*fs)+1 : floor((t2-t1+tau)*fs)+1) = -1;
       
    
    pp(floor((t2-t1+tau)*fs)+1 : floor((t2-t1+tau)*fs)+len) = slope-1;
    pp(floor((t2-t1+tau)*fs+len)+1 : (floor(Tp*fs)+1)) = 0;

%         plot(pp(1:length(pp)));
    
    pp = circshift(pp, floor(t1*fs));
    pp = repmat(pp, 1, ceil(totalTime(length(totalTime))/Tp)+1);

    res = pp(1:length(totalTime));
end