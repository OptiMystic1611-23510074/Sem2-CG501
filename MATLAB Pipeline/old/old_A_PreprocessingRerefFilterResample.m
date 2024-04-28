
inRootDir = 'F:\Dataset\EEG+Pupillometry\ds003838';
outRootDir = 'E:\Dataset\EEG+Pupillometry\DS003838-PRE';

for i = 98:-1:32

	subjectDir = strcat('sub-0', num2str(i));
	inEEGFile = strcat(subjectDir, '_task-memory_eeg.set');
	inFileDir = fullfile(inRootDir, subjectDir, 'eeg', inEEGFile);


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

	EEG = pop_reref( EEG, []);

	EEG = pop_eegfiltnew(EEG, 'locutoff',2,'hicutoff',16,'plotfreqz',0);

	EEG = pop_resample(EEG, 128);

	%saving SET

    if ~exist(strcat(fullfile(outRootDir, subjectDir))) %create new subject folder if doesn't exist
	    mkdir(strcat(fullfile(outRootDir, subjectDir)))
    end

	outEEGFile = strcat(subjectDir, '_task_PRE_eeg.set');
	outFileDir = fullfile(outRootDir, subjectDir, outEEGFile);
	pop_saveset(EEG, 'filename', outFileDir);
	disp(['SET data saved to: ' outFileDir]);


end