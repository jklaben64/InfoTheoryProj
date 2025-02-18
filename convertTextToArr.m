function symbolArr = convertTextToArr(fileLocation)

filetext = fileread([fileLocation]);

symbolArr = '';
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
    
            if(i+1 < length(filetext)) && (filetext(i+1) == 142) % b symbol
               % append letter plus 7
    
               symbolArr(symbolArrLen) = filetext(i)+7;
               
            elseif(i+1 < length(filetext)) && (filetext(i+1) == 35) % # symbol
               % append letter plus 14
    
               symbolArr(symbolArrLen) = filetext(i)+14;
    
            else
                %append letter
    
                symbolArr(symbolArrLen) = filetext(i);
    
            end
        end

    end


end