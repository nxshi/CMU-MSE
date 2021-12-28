close all; clc;

FigList = {'**/*Array400-*10x0-1s_1000uW_ref.txt','fig05_01';...
    '**/*Array400-*10x1s_100uW_ref.txt','fig05_02';...
    '**/*Array400*10x1s_3*uW_ref.txt','fig05_03';...
    '**/*Array600*100x0-00003s_100uW_ref.txt','fig05_04';...
    '**/*Array600*100x0-00003s_1000uW_ref.txt','fig05_05';...
    '**/*Array600*100x0-00003s_3000uW_ref.txt','fig05_06';...
    '**/*Array600*10x1s_10uW_ref.txt','fig05_07';...
    '**/*Array600*10x1s_100uW_ref.txt','fig05_08';...
    '**/*Array800*100x0-00003s_100uW_ref.txt','fig05_09';...
    '**/*Array800*100x0-00003s_1000uW_ref.txt','fig05_10';...
    '**/*Array800*100x0-00003s_3000uW_ref.txt','fig05_11';...
    '**/*Array800*10x1s_10uW_ref.txt','fig05_12';...
    '**/*Array800*10x1s_100uW_ref.txt','fig05_13';...
    '**/*Array800*30x1s_10uW_ref.txt','fig05_14';...
    '**/*Array1000*100x0-00003s_100uW_ref.txt','fig05_15';...
    '**/*Array1000*100x0-00003s_100uW_ND3-0_ref.txt','fig05_16';...
    '**/*Array1000*100x0-00003s_1000uW*ref.txt','fig05_17';...
    '**/*Array1000*100x0-00003s_3000uW*ref.txt','fig05_18';...
    '**/*Array1000*10x1s_10uW_ref.txt','fig05_19';...
    '**/*Array1000*30x1s_0-2uW_ref.txt','fig05_20';...
    '**/*Array1000*30x1s_1uW_ref.txt','fig05_21';...
    '**/*Array1000*30x1s_10uW_ref.txt','fig05_22';...
    '**/*Array2000*30x1s_100uW_ND3-0_ref.txt','fig05_23';...
    };
A = size(FigList);

for i = 1:A(1)
    inputfile = FigList{i,1};
    outputfile = FigList{i,2};
    overlaygraphs05(inputfile, outputfile)
end