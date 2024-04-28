
memory = {
'6001050' '6002050' '6003050' '6004050' '6005050' '6001090' '6002090' '6003090' '6004090' '6005090' '6006090' '6007090' '6008090' '6009090' '6001130' '6002130' '6003130' '6004130' '6005130' '6006130' '6007130' '6008130' '6009130' '6010130' '6011130' '6012130' '6013130' '6001051' '6002051' '6003051' '6004051' '6005051' '6001091' '6002091' '6003091' '6004091' '6005091' '6006091' '6007091' '6008091' '6009091' '6001131' '6002131' '6003131' '6004131' '6005131' '6006131' '6007131' '6008131' '6009131' '6010131' '6011131' '6012131' '6013131' 
};

control = {
'500105' '500205' '500305' '500405' '500505' '500109' '500209' '500309' '500409' '500509' '500609' '500709' '500809' '500909' '500113' '500213' '500313' '500413' '500513' '500613' '500713' '500813' '500913' '501013' '501113' '501213' '501313' 
};

inRootDir = 'E:\Dataset\EEG+Pupillometry\DS003838-PRE-CRD-ICA-BLR';
outRootDir = 'E:\Dataset\EEG+Pupillometry\DS003838-PRE-CRD-ICA-BLR-EPH';

for i = 98:-1:32

	subjectDir = strcat('sub-0', num2str(i));
	inEEGFile = strcat(subjectDir, '_task_PRE-CRD-ICA-BLR_eeg.set');
	inFileDir = fullfile(inRootDir, subjectDir, inEEGFile);


	disp(' ');
	disp('==================================');
	disp(subjectDir);
	disp('==================================');


    % Load the EEG data
    if ~exist(inFileDir, 'file')
        disp(['File not found: ', inEEGFile]);
        continue;
    end

	EEG = pop_loadset('filename',inFileDir);
	
    try
	    memoryEEG = pop_epoch( EEG, {  memory{:} }, [-1.5  3.5], 'newname', 'memory', 'epochinfo', 'yes');
    catch ERR
        diary('pipeline_logfile.txt');
        disp('==================================');
        disp(['Error doing EPOCHING of memory condition for subject ', subjectDir]);
        disp(ERR.message); 
        disp('==================================');
        disp(' ');
        diary off;
        continue;
    end

    try
	    controlEEG = pop_epoch( EEG, {  control{:} }, [-1.5  3.5], 'newname', 'control', 'epochinfo', 'yes');
    catch ERR
        diary('pipeline_logfile.txt');
        disp('==================================');
        disp(['Error doing EPOCHING of control condition for subject ', subjectDir]);
        disp(ERR.message); 
        disp('==================================');
        disp(' ');
        diary off;
        continue;
    end

	%saving Epochs

    if ~exist(strcat(fullfile(outRootDir, subjectDir))) %create new subject folder if doesn't exist
	    mkdir(strcat(fullfile(outRootDir, subjectDir)))
    end
    

	%saving SET epochs

	outEEGFile = strcat(subjectDir, '_memory_PRE-CRD-ICA-BLR-EPH_eeg.set');
	outFileDir = fullfile(outRootDir, subjectDir, outEEGFile);
	pop_saveset(memoryEEG, 'filename', outFileDir);
	disp(['memory condition .set data saved to: ' outFileDir]);


	outEEGFile = strcat(subjectDir, '_control_PRE-CRD-ICA-BLR-EPH_eeg.set');
	outFileDir = fullfile(outRootDir, subjectDir, outEEGFile);
	pop_saveset( controlEEG, 'filename', outFileDir);
	disp(['control condition .set data saved to: ' outFileDir]);
	

	%saving EDF epochs

	%outEEGFile = strcat(subjectDir, '_memory_PRE-CRD-ICA-BLR-EPH_eeg.edf');
	%outFileDir = fullfile(outRootDir, subjectDir, outEEGFile);
	%pop_writeeeg(memoryEEG, outFileDir, 'TYPE','EDF');
	%disp(['memory condition .edf data saved to: ' outFileDir]);


	%outEEGFile = strcat(subjectDir, '_control_PRE-CRD-ICA-BLR-EPH_eeg.edf');
	%outFileDir = fullfile(outRootDir, subjectDir, outEEGFile);
	%pop_writeeeg(controlEEG, outFileDir, 'TYPE','EDF');
	%disp(['control condition .edf data saved to: ' outFileDir]);
	
end