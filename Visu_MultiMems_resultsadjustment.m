clear all
close all
clc


% Visualization of Multi MEMS Data


D = importdata('kalibpara_9_result.txt');


ID = isnan(D);

D_ = D(find(ID(:,1)==0),:); % NAN Sensoren herausgekommen: Hier Platine 0 Sensoren 1+10 sowie Platine 4 Sensoren 2+10


figure(1)

h1 = histogram(D_(:,1))
hold on
h2 = histogram(D_(:,3))
h3 = histogram(D_(:,5))
title('scale (x = red, y = green, z = blue)')
xlabel('[ ]')
ylabel('number of sensors')
fontsize(16,"points")
%h1.Normalization = 'pdf';
h1.BinWidth = 0.0005;
h1.FaceColor = [1 0 0];
%h2.Normalization = 'pdf';
h2.BinWidth = 0.0005;
h2.FaceColor = [0 1 0];
%h3.Normalization = 'pdf';
h3.BinWidth = 0.0005;
h3.FaceColor = [0 0 1];

figure(3)

h1 = histogram(D_(:,10))
hold on
h2 = histogram(D_(:,12))
h3 = histogram(D_(:,14))
title('stddev. scale  (x = red, y = green, z = blue)')
xlabel('[ ]')
ylabel('number of sensors')
fontsize(16,"points")
%h1.Normalization = 'pdf';
h1.BinWidth = 0.00001;
h1.FaceColor = [1 0 0];
%h2.Normalization = 'pdf';
h2.BinWidth = 0.00001;
h2.FaceColor = [0 1 0];
%h3.Normalization = 'pdf';
h3.BinWidth = 0.00001;
h3.FaceColor = [0 0 1];

figure(2)

h1 = histogram(D_(:,2))
hold on
h2 = histogram(D_(:,4))
h3 = histogram(D_(:,6))
title('bias  (x = red, y = green, z = blue)')
xlabel('[m/s²]')
ylabel('number of sensors')
fontsize(16,"points")
%h1.Normalization = 'pdf';
h1.BinWidth = 0.05;
h1.FaceColor = [1 0 0];
%h2.Normalization = 'pdf';
h2.BinWidth = 0.05;
h2.FaceColor = [0 1 0];
%h3.Normalization = 'pdf';
h3.BinWidth = 0.05;
h3.FaceColor = [0 0 1];

figure(4)

h1 = histogram(D_(:,11))
hold on
h2 = histogram(D_(:,13))
h3 = histogram(D_(:,15))
title('stddev. bias  (x = red, y = green, z = blue)')
xlabel('[m/s²]')
ylabel('number of sensors')
fontsize(16,"points")
%h1.Normalization = 'pdf';
h1.BinWidth = 0.0001;
h1.FaceColor = [1 0 0];
%h2.Normalization = 'pdf';
h2.BinWidth = 0.0001;
h2.FaceColor = [0 1 0];
%h3.Normalization = 'pdf';
h3.BinWidth = 0.0001;
h3.FaceColor = [0 0 1];

figure(5)

h1 = histogram(D_(:,7))
hold on
h2 = histogram(D_(:,8))
h3 = histogram(D_(:,9))
title('orthogonality  (r_{xy} = red, r_{xz} = green, r_{yz} = blue)')
xlabel('[ ]')
ylabel('number of sensors')
fontsize(16,"points")
%h1.Normalization = 'pdf';
h1.BinWidth = 0.0005;
h1.FaceColor = [1 0 0];
%h2.Normalization = 'pdf';
h2.BinWidth = 0.0005;
h2.FaceColor = [0 1 0];
%h3.Normalization = 'pdf';
h3.BinWidth = 0.0005;
h3.FaceColor = [0 0 1];

figure(6)

h1 = histogram(D_(:,16))
hold on
h2 = histogram(D_(:,17))
h3 = histogram(D_(:,18))
title('stddev. orthogonality  (r_{xy} = red, r_{xz} = green, r_{yz} = blue)')
xlabel('[ ]')
ylabel('number of sensors')
fontsize(16,"points")
%h1.Normalization = 'pdf';
h1.BinWidth = 0.00001;
h1.FaceColor = [1 0 0];
%h2.Normalization = 'pdf';
h2.BinWidth = 0.00001;
h2.FaceColor = [0 1 0];
%h3.Normalization = 'pdf';
h3.BinWidth = 0.00001;
h3.FaceColor = [0 0 1];
