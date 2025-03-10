function [symbols, followers] = charArrToAlphabetFollower(inputStrArr, sequenceLength)
    % Takes in the string arr and the maximum correlation length
    %  to check for. Outputs 2 arrays, one of the unique symbol
    %  permutations present in the char arr and of the char that
    %  follows the permutation in all locations in the char arr.
    %  Ignores the end of the array permutations that do not 
    %  have a char following it. If the string arr is multiple strings, it
    %  will concatenate the results.

    % Validate input
    if sequenceLength < 1
        error('sequenceLength must be at least 1.');
    end

     % Initialize map to store sequences and their followers
    seqMap = containers.Map('KeyType', 'char', 'ValueType', 'any');

    % Loop through each sequence length from sequenceLength down to 1
    for len = sequenceLength:-1:1
        for s = 1:length(inputStrArr)
            inputStr = char(inputStrArr(s));
            for i = 1:length(inputStr) - len
                seq = inputStr(i:i + len - 1);
                if i + len <= length(inputStr)
                    nextChar = inputStr(i + len);
    
                    % Check if the sequence already exists in the map
                    if isKey(seqMap, seq)
                        % Append the new follower to the existing entry
                        seqMap(seq) = [seqMap(seq), nextChar]; %#ok
                    else
                        % If not found, add new sequence and follower
                        seqMap(seq) = nextChar; %#ok
                    end
                end
            end
        end
    end

    % Convert the map to cell arrays for output
    symbols = keys(seqMap);
    followers = values(seqMap);

    % Sort symbols by length and then alphabetically
    % Convert cell array to a character array for sorting
    symbolsChar = char(symbols);
    [~, sortIdx] = sort(symbolsChar, 'ascend');

    % Get lengths and sort by length
    lengths = cellfun(@length, symbols);
    [~, lengthSortIdx] = sort(lengths);

    % Combine sorting indices
    sortedIdx = lengthSortIdx(sortIdx);

    % Reorder symbols and followers based on the sorted indices
    symbols = symbols(sortedIdx);
    followers = followers(sortedIdx);

    % Remove duplicate entries in symbols and corresponding followers
    [symbols, uniqueIdx] = unique(symbols, 'stable');
    followers = followers(uniqueIdx);

    % Convert cell arrays to string arrays if needed
    symbols = string(symbols);
    followers = string(followers);

    % % Convert cell arrays to character arrays if needed
    % symbols = char(symbols);
    % followers = char(followers);
end