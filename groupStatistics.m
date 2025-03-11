%% Statistics

matfiles = dir("*.mat");

info = cell(length(matfiles), 2);
names ="";

for i = 1:length(matfiles)
    load(matfiles(i).name);
    info{i,1} = correlation;
    info{i,2} = groupCorrelation;
    names(i) = erase(string(matfiles(i).name), "Correlations.mat");
end

numGenres = length(matfiles);

% correlation info for avg k1 to k4 for each genre
k1Avg = zeros(1, numGenres);
k2Avg = zeros(1, numGenres);
k3Avg = zeros(1, numGenres);
k4Avg = zeros(1, numGenres);
for i = 1:numGenres
    k1Avg(i) = mean(info{i}(:, 1));
    k2Avg(i) = mean(info{i}(:, 2));
    k3Avg(i) = mean(info{i}(:, 3));
    k4Avg(i) = mean(info{i}(:, 4));
end

figure();
bar([k1Avg; k2Avg; k3Avg; k4Avg])
legend(names)
title('Correlation Information for k1 - k4')

    

% avg total correlation information for each genre (sum of k1 to k4, others
% are small enough to ignore and statistically significant)

figure();
sumKAvgs = k2Avg + 2.*k3Avg + 3.*k4Avg;
bar(names, sumKAvgs)
title('Estimation of Correlation Complexity')

% correlation information of greater than k4 for group correlation info
% and compare between genres

k1 = zeros(1, numGenres);
k2 = zeros(1, numGenres);
k3 = zeros(1, numGenres);
k4 = zeros(1, numGenres);
k5 = zeros(1, numGenres);
k6 = zeros(1, numGenres);
k7 = zeros(1, numGenres);
k8 = zeros(1, numGenres);
k9 = zeros(1, numGenres);
k10 = zeros(1, numGenres);
for i = 1:numGenres
    k1(i) = info{i, 2}(1);
    k2(i) = info{i, 2}(2);
    k3(i) = info{i, 2}(3);
    k4(i) = info{i, 2}(4);
    k5(i) = info{i, 2}(5);
    k6(i) = info{i, 2}(6);
    k7(i) = info{i, 2}(7);
    k8(i) = info{i, 2}(8);
    k9(i) = info{i, 2}(9);
    k10(i) = info{i, 2}(10);
end

figure();
bar([k1; k2; k3; k4; k5; k6; k7; k8; k9; k10])
legend(names)
title('Correlation Information for groups of songs')

% total correlation information (aka sum of km) for group correlation info
% and compare between genres

% plots:
% Bar charts for comparison

% most popular "tunes" for each genre?