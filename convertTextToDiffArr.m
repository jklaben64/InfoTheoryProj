function stepArr = convertTextToDiffArr(fileLocation)
% outputs char array of the note difference in song as
%  a positive change in note value. Encodes the value
%  as a ASCII character array.

filetext = fileread(fileLocation);

symbolArr = [];
symbolArrLen = 0;

noteLine = 0;
wordLine = 0;
otherLine = 1;

for i = 1:length(filetext)

    if(filetext(i) == 10) %newline
        if(noteLine)
            wordLine = 1;
            noteLine = 0;
        elseif(wordLine)
            wordLine = 0;
            otherLine = 1;
        end
    end

    if (filetext(i) > 64) && (filetext(i) < 72) % in the range of 'A' to 'G'

        if(otherLine)
            otherLine = 0;
            noteLine = 1;
        end

        if(noteLine) % only write down notes if in a line with notes
            symbolArrLen = symbolArrLen + 1;
            
            symbol = filetext(i);
            switch symbol %determine value on chromatic scale for note
                case 'C'
                    noteval = 0;
                case 'D'
                    noteval = 2;
                case 'E'
                    noteval = 4;
                case 'F'
                    noteval = 5;
                case 'G'
                    noteval = 7;
                case 'A'
                    noteval = 9;
                case 'B'
                    noteval = 11;
            end

    
            if(i+1 < length(filetext)) && (filetext(i+1) == 142) % b symbol
               % subtract one from noteval
               noteval = noteval - 1;
               
            elseif(i+1 < length(filetext)) && (filetext(i+1) == 35) % # symbol
               % add one to noteval
               noteval = noteval + 1;    
            end

            % append noteval to array
            symbolArr(symbolArrLen) = noteval;
        end

    end


end %end for loop through file


%find steps between notes
stepArr = '';

for i = 2:symbolArrLen

    step = symbolArr(i) - symbolArr(i-1);
    if(step < 0)
        step = step + 12;
    end

    stepArr(i-1) = '0'+step;

end