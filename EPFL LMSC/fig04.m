close all; clc;

FigList = {'**/*Array1000-60*100x0-00003s_100uW*_ref.txt','fig04_01';...
    '**/*Array1000-90*0x0-00003s_100uW*_ref.txt','fig04_02';...
    '**/*Array1000-120*100x0-00003s_100uW*_ref.txt','fig04_03';...
    };
A = size(FigList);

for i = 1:A(1)
    inputfile = FigList{i,1};
    outputfile = FigList{i,2};
    overlaygraphs04(inputfile, outputfile)
end