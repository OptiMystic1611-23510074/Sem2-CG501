
inRootDir = 'E:\Dataset\EEG+Pupillometry\DS003838-PRE-CRD';
outRootDir = 'E:\Dataset\EEG+Pupillometry\DS003838-PRE-CRD-ICA';

for i = 98:-1:32

	subjectDir = strcat('sub-0', num2str(i));
	inEEGFile = strcat(subjectDir, '_task_PRE-CRD_eeg.set');
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
	    EEG = pop_runica(EEG, 'icatype', 'picard', 'maxiter',256,'mode','standard');
	    EEG = pop_iclabel(EEG, 'default');
	    EEG = pop_icflag(EEG, [NaN NaN;0.9 1;0.9 1;NaN NaN;NaN NaN;NaN NaN;NaN NaN]);
	    EEG = pop_subcomp( EEG, [], 0);
    catch ERR
        diary('pipeline_logfile.txt');
        disp('==================================');
        disp(['Error doing ICA for subject ', subjectDir]);
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

	outEEGFile = strcat(subjectDir, '_task_PRE-CRD-ICA_eeg.set');
	outFileDir = fullfile(outRootDir, subjectDir, outEEGFile);
	pop_saveset(EEG, 'filename', outFileDir);
	disp(['SET data saved to: ' outFileDir]);

end