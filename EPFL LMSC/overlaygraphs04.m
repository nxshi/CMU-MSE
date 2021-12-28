function overlaygraphs04(inputfile, outputfile)

FileList = dir(inputfile); % lists ref data txt files as struct
graph1 = textread(fullfile(FileList(1).folder, FileList(1).name));
M = max(graph1(:,2)); % establishes max intensity as that from data set 1
ExI = figure;
set(ExI,'visible','off'); % keep plots invisible
for index = 1:numel(FileList) % loop to plot ref data
    data = textread(fullfile(FileList(index).folder, FileList(index).name)); % read data
    data(:,2) = M*data(:,2)/max(data(:,2)); % adjusts all data according to data set 1
    % Energy Against Intensity graph
    plot(data(:,1),data(:,2));
    longname = strrep(sprintf(FileList(index).name),'_',' ');
    if strlength(longname) > 90
        h{index} = 'ND3-0';
    else
        h{index} = 'No ND3-0';
    end
    xlabel('Energy (eV)');
    ylabel('Normalized Intensity');
    ylim([0 inf]) % only plot intensity larger than 0
    hold on
end
legend(h(1:index));
title(longname(22:34));
print('-dpng',fullfile(outputfile(1:5),outputfile)); % save as png