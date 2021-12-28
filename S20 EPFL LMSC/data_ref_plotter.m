close all; clc;

FileList = dir('**/*_ref.txt'); % lists ref data txt files as struct
for index = 1:numel(FileList) % loop to plot ref data
    data = textread(fullfile(FileList(index).folder, FileList(index).name)); % read data
    % Energy Against Intensity graph
    ExI = figure;
    set(ExI,'visible','off'); % keep plots invisible
    plot(data(:,1),data(:,2));
    xlabel('Energy (eV)');
    ylabel('Intensity');
    ylim([0 inf]) % only plot intensity larger than 0
    newname = sprintf('%s.png',FileList(index).name(1:end-4));
    folder = FileList(index).folder;
    save = fullfile(folder, newname); % new file directory
    print('-dpng',save); % save as png
end
