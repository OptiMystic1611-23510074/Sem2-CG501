disp(' ')
disp('||||||||||||||||||||||||||ScriptPipeline.m||||||||||||||||||||||||||||')
disp(' ')


disp(' ')
disp('||||||||||||||||||||||||||A_PreprocessingRerefFilterResample.m|||||||||||||||||||||||||||||||')
run('A_PreprocessingRerefFilterResample.m')


disp(' ')
disp('||||||||||||||||||||||||||||||||B_CleanRawDataUsingASR.m||||||||||||||||||||||||||||||||||||||')
run('B_CleanRawDataUsingASR.m')


disp(' ')
disp('|||||||||||||||||||||||||||C_IndependentComponentAnalysis.m|||||||||||||||||||||||||||||||||||')
run('C_IndependentComponentAnalysis.m')


disp(' ')
disp('|||||||||||||||||||||||||||||||||||D_BaselineRemoval.m||||||||||||||||||||||||||||||||||||||||')
run('D_BaselineRemoval.m')


disp(' ')
disp('|||||||||||||||||||||||||||||E_ExtractEpochsSaveSETandEDF.m|||||||||||||||||||||||||||||||||||')
run('E_ExtractEpochsSaveSETandEDF.m')

disp(' ')
disp('||||||||||||||||||||||||||F_FeatureAverageFrequencyBandPower.m||||||||||||||||||||||||||||||||')
run('F_FeatureAverageFrequencyBandPower.m')


disp(' ')
disp('||||||||||||||||||||||||||||||||||||||||||DONE||||||||||||||||||||||||||||||||||||||||||||||||')
disp(' ')