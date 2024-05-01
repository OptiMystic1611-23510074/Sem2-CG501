
inRootDir = 'F:\Dataset\EEG+Pupillometry\ds003838';
outRootDir = 'E:\Dataset\EEG+Pupillometry\DS003838-REST';

for i = 98:-1:32

	subjectDir = strcat('sub-0', num2str(i));
	inEEGFile = strcat(subjectDir, '_task-rest_eeg.set');
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
	
	
    try
	    EEG = pop_clean_rawdata(EEG, 'FlatlineCriterion',5,'ChannelCriterion',0.8,'LineNoiseCriterion',4,'Highpass','off','BurstCriterion',20,'WindowCriterion',0.25,'BurstRejection','on','Distance','Euclidian','WindowCriterionTolerances',[-Inf 7] );
    catch ERR
        diary('pipeline_logfile.txt');
        disp('==================================');
        disp(['Error processing CRD for subject ', subjectDir, ' for REST']);
        disp(ERR.message); 
        disp('==================================');
        disp(' ');
        diary off;
        continue;
    end
	
	
    try
	    EEG = pop_runica(EEG, 'icatype', 'picard', 'maxiter',256,'mode','standard');
	    EEG = pop_iclabel(EEG, 'default');
	    EEG = pop_icflag(EEG, [NaN NaN;0.9 1;0.9 1;NaN NaN;NaN NaN;NaN NaN;NaN NaN]);
	    EEG = pop_subcomp( EEG, [], 0);
    catch ERR
        diary('pipeline_logfile.txt');
        disp('==================================');
        disp(['Error doing ICA for subject ', subjectDir, ' for REST']);
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

	outEEGFile = strcat(subjectDir, '_task_REST_eeg.set');
	outFileDir = fullfile(outRootDir, subjectDir, outEEGFile);
	pop_saveset(EEG, 'filename', outFileDir);
	disp(['SET data saved to: ' outFileDir]);


end



disp(' ')
disp('||||||||||||||||||||||||||REST_FeatureAverageFrequencyBandPower.m||||||||||||||||||||||||||||||||')
run('E:\Dataset\EEG+Pupillometry\REST_FeatureAverageFrequencyBandPower.m')