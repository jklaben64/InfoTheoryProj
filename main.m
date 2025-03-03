%% Parameters


% Questions:
% what is our log base? -> alphabet size of all possible? What is alphabet
% size?
% do we ignore the last one since there is no xm, so we go until length-1-lengthofcorrelation?

alphabetSize = 12; %alphabet size is 21 when using song notes directly
maxCorrelationLength = 8;
folderLocation = 'C:\Users\naido\Documents\ChalmersCourses\0_TIF150_InformationTheory\Project\InfoTheoryProj\Music\AltRock';

%% Song text processing

% Leave processTextFiles() empty for folder selection to pop up
%  or add in the folderLocation variable with your selected folder path.
songs = processTextFiles();
songNames = fields(songs);
numSongs = length(songNames);

%% Correlation calculation

correlation = zeros([numSongs maxCorrelationLength]);

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
    correlation(i,1) = sum(px .* log(px .* alphabetSize) ...
        ./ log(sum(alphabetSize))); % log base change and k1 calc

    % Calculate K(2)
    %probability x1
    singles = strlength(symbolSequences)==1;
    singleSymbols = symbolSequences(singles);
    singleFollowers = followers(singles);

    px1 = strlength(singleFollowers) ./ sum(strlength(singleFollowers));

    %probability x1x2
    doubles = strlength(symbolSequences)==2;
    doubleSymbols = symbolSequences(doubles);
    doubleFollowers = followers(doubles);

    px1x2 = strlength(doubleFollowers) ./ sum(strlength(doubleFollowers));

    %probability x2 | x1
    k2 = 0;
    px2Givenx1 = zeros(size(doubleSymbols, 1), 1);
    for symbol = 1:size(doubleSymbols, 1)
        x1 = extract(doubleSymbols(symbol), 1);
        x2 = extract(doubleSymbols(symbol), 2);

        [~, x1index] = ismember(x1, singleSymbols);
        x1followers = singleFollowers(x1index);
        px2Givenx1(symbol) = count(x1followers, x2) / strlength(x1followers);

        [~, x2index] = ismember(x2, singleSymbols);
        k2 = k2 + px1(x1index) * px2Givenx1(symbol) * log(px2Givenx1(symbol)/px1(x2index))/log(alphabetSize);

    end

    correlation(i,2) = k2;



    % Calculate K(3) through K(maxCorrelationLength)
    for j = 3:maxCorrelationLength
        % Calculate K(m)
        %probability xm-1
        xm1s = strlength(symbolSequences)==j-1;
        xm1Symbols = symbolSequences(xm1s);
        xm1Followers = followers(xm1s);

        pxm1 = strlength(xm1Followers) ./ sum(strlength(xm1Followers));

        %probability xm | x1...xm-1
        % check xm1 arr, go through all the followers for each of the
        % xm1 to calculate pxm given x1...xm-1
        % Also do pxm given x2...xm-1. Search at each xm1 arr for the
        % x2...xm1 symbol sequence, get the followers, and then calculate
        % the conditional probability for each follower
        % Calculate additional value to km after finding these.
        km=0;
        pxmGx1xm1 = zeros(size(xm1Symbols, 1), 1);
        for x1xm1Loc = 1:size(xm1Symbols, 1)
            x1xm1 = xm1Symbols(x1xm1Loc);
            x2xm1 = extractAfter(x1xm1, 1);

            % TODO: get followers for x1xm1
            % TODO: get followers for x2xm1
            [~, x1index] = ismember(x1, singleSymbols);
            x1followers = singleFollowers(x1index);
            % TODO: get pxm given x1...xm-1
            % TODO: get pxm given x2...xm-1
            px2Givenx1(symbol) = count(x1followers, x2) / strlength(x1followers);

            [~, x2index] = ismember(x2, singleSymbols);
            % TODO: get km additives
            % k2 = k2 + px1(x1index) * px2Givenx1(symbol) * log(px2Givenx1(symbol)/px1(x2index))/log(alphabetSize);

        end
    end


end