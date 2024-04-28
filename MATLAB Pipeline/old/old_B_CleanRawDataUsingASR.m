
inRootDir = 'E:\Dataset\EEG+Pupillometry\DS003838-PRE';
outRootDir = 'E:\Dataset\EEG+Pupillometry\DS003838-PRE-CRD';

for i = 98:-1:32

	subjectDir = strcat('sub-0', num2str(i));
	inEEGFile = strcat(subjectDir, '_task_PRE_eeg.set');
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
	    EEG = pop_clean_rawdata(EEG, 'FlatlineCriterion',5,'ChannelCriterion',0.8,'LineNoiseCriterion',4,'Highpass','off','BurstCriterion',20,'WindowCriterion',0.25,'BurstRejection','on','Distance','Euclidian','WindowCriterionTolerances',[-Inf 7] );
    catch ERR
        diary('pipeline_logfile.txt');
        disp('==================================');
        disp(['Error processing CRD for subject ', subjectDir]);
        disp(ERR.message); 
        disp('==================================');
        disp(' ');
        diary off;
        continue;
    end

	%saving SET

    if ~exist(strcat(fullfile(outRootDir, subjectDir))) %create new subject folder if doesn't exist
	    mkdir(strcat(fullfile(outRootDir, subjectDir)))
    end
    
	outEEGFile = strcat(subjectDir, '_task_PRE-CRD_eeg.set');
	outFileDir = fullfile(outRootDir, subjectDir, outEEGFile);
	pop_saveset(EEG, 'filename', outFileDir);
	disp(['SET data saved to: ' outFileDir]);

end