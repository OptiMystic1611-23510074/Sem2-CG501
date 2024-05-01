disp(' ')
disp('||||||||||||||||||||||||||ScriptPipeline.m||||||||||||||||||||||||||||')
disp(' ')


disp(' ')
disp('||||||||||||||||||||||||||A_PreprocessingRerefFilterResample.m|||||||||||||||||||||||||||||||')
run('E:\Dataset\EEG+Pupillometry\A_PreprocessingRerefFilterResample.m')


disp(' ')
disp('||||||||||||||||||||||||||||||||B_CleanRawDataUsingASR.m||||||||||||||||||||||||||||||||||||||')
run('E:\Dataset\EEG+Pupillometry\B_CleanRawDataUsingASR.m')


disp(' ')
disp('|||||||||||||||||||||||||||C_IndependentComponentAnalysis.m|||||||||||||||||||||||||||||||||||')
run('E:\Dataset\EEG+Pupillometry\C_IndependentComponentAnalysis.m')


disp(' ')
disp('|||||||||||||||||||||||||||||||||||D_BaselineRemoval.m||||||||||||||||||||||||||||||||||||||||')
run('E:\Dataset\EEG+Pupillometry\D_BaselineRemoval.m')


disp(' ')
disp('|||||||||||||||||||||||||||||E_ExtractEpochsSaveSETandEDF.m|||||||||||||||||||||||||||||||||||')
run('E:\Dataset\EEG+Pupillometry\E_ExtractEpochsSaveSETandEDF.m')

disp(' ')
disp('||||||||||||||||||||||||||F_FeatureAverageFrequencyBandPower.m||||||||||||||||||||||||||||||||')
run('E:\Dataset\EEG+Pupillometry\F_FeatureAverageFrequencyBandPower.m')


disp(' ')
disp('||||||||||||||||||||||||||||||||||||||||||DONE||||||||||||||||||||||||||||||||||||||||||||||||')
disp(' ')