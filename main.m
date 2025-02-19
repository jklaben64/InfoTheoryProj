%% Parameters


% Questions:
% what is our log base? -> alphabet size of all possible? What is alphabet
% size?
% do we ignore the last one since there is no xm, so we go until length-1-lengthofcorrelation?

alphabetSize = 10;
maxCorrelationLength = 8;
folderLocation = 'C:\Users\naido\Documents\ChalmersCourses\0_TIF150_InformationTheory\Project\InfoTheoryProj\Music\AltRock';

%% Song text processing

songs = processTextFiles(folderLocation);
songNames = fields(songs);
numSongs = length(songNames);

%% Correlation calculation

correlation = zeros([1 maxCorrelationLength]);

for i = 1:numSongs

    % Select song
    songName = songNames{i};
    song = songs.(songName);
    songLength = length(song);

    % Calculate frequency of single symbols
    [symbols, firstLocation, symbolLocation] = unique(song);
    symbolsCounts = accumarray(symbolLocation,1);

    % Find all unique sequences and the symbol following the unique
    % sequence
    [symbolSequences, followers] = charArrToAlphabetFollower(song, maxCorrelationLength);

    % Calculate K(1)
    px = symbolsCounts / sum(symbolsCounts);
    correlation(1) = sum(px .* log(px) ./ log(sum(symbols)) ...
        ./ sum(symbolsCounts)); % log base change and k1 calc

    % Calculate K(2)

    for j = 1:(songLength - (j-1))

    end

    % Calculate K(3) through K(maxCorrelationLength)
    for j = 3:maxCorrelationLength

    end

end