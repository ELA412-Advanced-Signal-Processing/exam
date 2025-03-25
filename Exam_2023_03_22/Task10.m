load fecg1.dat
load fecg2.dat
load mecg1.dat
load mecg2.dat
load noise1.dat
load noise2.dat


fs=256;
N=length(fecg1);
t=0:1/fs:(N-1)/fs;


sp1 = subplot(4,1,1)
plot(t,mecg1)
sp2 = subplot(4,1,2)
plot(t,fecg1)
sp3 = subplot(4,1,3)
plot(t,noise1)

%observation is fetal + maternal + noise
ecg = mecg1+fecg1+noise1;
sp4 = subplot(4,1,4)
plot(t,ecg)

linkaxes([sp1,sp2, sp3, sp4],'y');

close all

figure
pwelch(mecg1)
figure
pwelch(fecg1)
figure
pwelch(noise1)
%TODO (2P) Why do we use the function pwelch?
%ANSWER: pwelch is used on finite length signals as better estimate of the
%spectrum than normal FT. We need to do pwelch since we can only do
%estimate of random signals spectrum, we can never get the true spectrum.

close all

figure
hist(mecg1,100)
figure
hist(fecg1,100)
figure
hist(noise1,100)


%kurtosis is the measure of how heavy the teails are
kurtosis(mecg1)
kurtosis(fecg1)
kurtosis(noise1)
%TODO (1P) How is the kurtosis used for ICA?
%ANSWER: Kurtosis can be seen as a measure of non Gaussanity which is thus
%used by ICA since ICA can not be done for Gaussian sources. We calculate
%kurtosis and use gradient decent to update and recalculate cost function
%(Kurtosis) to try to maximize Kurtosis.

%TODO (1P) How do the 3 previous numbers of kurtosis relate to the 3
%previous histogram plots?
%ANSWER: It can clearly be seen that lower numbers of kurtosis is related
%to histograms which are more and more similar to a gaussian distribution.
%Higher numbers of kurtosis have histograms which are less similar to
%gaussian distributions.

close all

desired = fecg1;
observation=ecg;

%PCA
close all
load X.dat

[U,S,V] = svd(X);

figure
sp1 = subplot(3,1,1)
plot(t,U(:,1))
sp2 = subplot(3,1,2)
plot(t,U(:,2))
sp3 = subplot(3,1,3)
plot(t,U(:,3))

%eigenspectrum
figure
stem([S(1,1),S(2,2),S(3,3)])
%TODO (1P) What is the eigenspetrum?
%ANSWER: it showns the power and variance in each principal component, from
%this spectrum we can clearly see that a majority (roughly 50 percent) of the signal
%strenght/power is present in the first component. So for example, if this
%was a picture, only using the first/primary principal component would
%probably yield a pretty good picture while still reducing the amount of
%data by a good amount (helpfull when you dont want huge pictures stored
%with over 1gb).

%TODO (1P) What is the meaning of each eigen value?
%ANSWER: The eigen value in PCA is the variance in that principal
%component.

%TODO (1P) Why is the first eigen value the largest?
%ANSWER: Because it correspends to the principal component that has the
%maximum possible variance.
