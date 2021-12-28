clc;

FileList = dir('**/*.asc');  % lists data files as struct
for index = 1:numel(FileList) % loop to convert data
    data = textread(fullfile(FileList(index).folder, FileList(index).name)); % read data
    l = data(:,1).*1.0E-9; % wavelength [m]
    i = data(:,2); % intensity [count]
    h = 4.135667696*10^(-15); % plank's constant [eV*s]
    c = 3.0 * 10^8; % speed of light [m/s]
    E = h*c./l; % energy [eV]
    fi = i*(h*c)./(E.^2); % adjusted intensity [count]
    data_convert = [E fi]; % array of converted data
    newname = sprintf('%s.txt',FileList(index).name(1:end-4));
    folder = FileList(index).folder;
    save = fullfile(folder, newname); % new file directory
    dlmwrite(save, data_convert, 'delimiter', ' '); % save converted data
end
