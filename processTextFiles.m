function songList = processTextFiles()
    % Open a dialog to select a folder
    folderPath = uigetdir('', 'Select a Folder');

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
        charArray = convertTextToArr(fullfile(folderPath, files(k).name));

        % Store the result in the structure
        songList.(fileName) = charArray;
    end
end