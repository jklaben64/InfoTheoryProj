%% Statistics

matfiles = dir("*.mat");

info = cell(length(matfiles), 2);

for i = 1:length(matfiles)
    load(matfiles(i).name);
    info{i,1} = correlation;
    info{i,2} = groupCorrelation;
end

% correlation info for avg k1 to k4 for each genre

% avg total correlation information for each genre (sum of k1 to k4, others
% are small enough to ignore and statistically significant)

% correlation information of greater than k4 for group correlation info
% and compare between genres

% total correlation information (aka sum of km) for group correlation info
% and compare between genres

% plots:
% Bar charts for comparison

% most popular "tunes" for each genre?