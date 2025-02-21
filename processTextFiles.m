function songList = processTextFiles(varargin)
    % Open a dialog to select a folder

    if nargin == 0
        folderPath = uigetdir('', 'Select a Folder');
    else
        folderPath = varargin{1};
    end

    % Check if a folder was selected
    if folderPath == 0
        error('No folder selected.');
    end

    % Get a list of all text files in the folder
    files = dir(fullfile(folderPath, '*.txt'));

    % Initialize the output structure
    songList = struct();

    % Loop through each file and call convertTextToArr
    for k = 1:length(files)
        % Get the file name without extension
        [~, fileName, ~] = fileparts(files(k).name);

        % Call the existing function to convert text to array
        charArray = convertTextToDiffArr(fullfile(folderPath, files(k).name));

        % Store the result in the structure
        songList.(fileName) = charArray;
    end
end