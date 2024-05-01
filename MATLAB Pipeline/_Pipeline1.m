disp(' ')
disp('||||||||||||||||||||||||||ScriptPipeline.m||||||||||||||||||||||||||||')
disp(' ')

disp(' ')
disp('|||||||||||||||||||||||||||||||||||||||||||||||||||')
disp('A_PreprocessingRerefFilterResample.m')
disp('|||||||||||||||||||||||||||||||||||||||||||||||||||')
run('E:\Dataset\EEG+Pupillometry\A_PreprocessingRerefFilterResample.m')


disp(' ')
disp('|||||||||||||||||||||||||||||||||||||||||||||||||||')
disp('B_CleanRawDataUsingASR.m')
disp('|||||||||||||||||||||||||||||||||||||||||||||||||||')
run('E:\Dataset\EEG+Pupillometry\B_CleanRawDataUsingASR.m')


disp(' ')
disp('|||||||||||||||||||||||||||||||||||||||||||||||||||')
disp('C_IndependentComponentAnalysis.m')
disp('|||||||||||||||||||||||||||||||||||||||||||||||||||')
run('E:\Dataset\EEG+Pupillometry\C_IndependentComponentAnalysis.m')


disp(' ')
disp('|||||||||||||||||||||||||||||||||||||||||||||||||||')
disp('D_ExtractEpochsSaveSETandEDF.m')
disp('|||||||||||||||||||||||||||||||||||||||||||||||||||')
run('E:\Dataset\EEG+Pupillometry\D_ExtractEpochsSaveSETandEDF.m')

disp(' ')
disp('|||||||||||||||||||||||||||||||||||||||||||||||||||')
disp('E_FeatureAverageFrequencyBandPower.m')
disp('|||||||||||||||||||||||||||||||||||||||||||||||||||')
run('E:\Dataset\EEG+Pupillometry\E_FeatureAverageFrequencyBandPower.m')


disp('|||||||||||||||||||||||||||||||||||||||||||||||||||')
disp('DONE.')