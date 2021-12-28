function subtractgraphs01(inputfile, basefile, outputfile)

FileList = dir(inputfile); % lists ref data txt files as struct
BaseList = dir(basefile);
basegraph = textread(fullfile(BaseList(1).folder, BaseList(1).name));
B = max(basegraph(:,2)); % establishes max intensity as that from baseline graph
ExI = figure;
set(ExI,'visible','off'); % keep plots invisible
for index = 1:numel(FileList) % loop to plot ref data
    data = textread(fullfile(FileList(index).folder, FileList(index).name)); % read data
    data(:,2) = B*data(:,2)/max(data(:,2)); % adjusts all data according to baseline graph
    % Energy Against Intensity graph
    plot(data(:,1),data(:,2)-basegraph(:,2));
    longname = strrep(sprintf(FileList(index).name),'_',' ');
    h{index} = longname(60:end-8);
    xlabel('Energy (eV)');
    ylabel('Normalized Intensity');
    %ylim([0 inf]) % only plot intensity larger than 0
    hold on
end
legend(h(1:index));
basename = strrep(sprintf(basefile),'_',' ');
basename = strrep(sprintf(basename),'*',' ');
longname = strrep(sprintf(longname),'l',' ');
title([longname(22:34) ', Baseline Exposure:' basename(end-18:end-8)]);
print('-dpng',fullfile(outputfile(1:5),outputfile)); % save as png
