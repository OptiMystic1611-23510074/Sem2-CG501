
% Define frequency bands (Hz)
thetaBand = [4 5 6 7 8];
alphaBand = [9 10 11 12 13 14];

% Channel selection using labels
thetaChannel = 'Fz';
alphaChannels = {'Pz' 'P1' 'P2' 'P3' 'P4'};



outRootDir = 'E:\Dataset\EEG+Pupillometry\EEG_Features';
outFileDir = fullfile(outRootDir, 'BandPower.csv');
if exist(outFileDir, 'file')==2
	delete(outFileDir);
end
csv = fopen(outFileDir, 'a');
fprintf(csv, '%s,%s,%s,%s,%s,%s,%s,%s,%s\n', 'subject', 'condition', 'freqBandPowerThetaFz', 'freqBandPowerAlphaMean', 'freqBandPowerAlphaPz', 'freqBandPowerAlphaP1', 'freqBandPowerAlphaP2', 'freqBandPowerAlphaP3', 'freqBandPowerAlphaP4');
fclose(csv);

inRootDir = 'E:\Dataset\EEG+Pupillometry\DS003838-PRE-CRD-ICA-EPH';

condFileNames = {'_memory_PRE-CRD-ICA-EPH_eeg.set' '_control_PRE-CRD-ICA-EPH_eeg.set'};
conditions = {'memory' 'control'};



for i = 98:-1:32
	for cond = 1:length(condFileNames)
		condFile = string(condFileNames(cond));
		
		subjectDir = strcat('sub-0', num2str(i));
		inEEGFile = strcat(subjectDir, convertStringsToChars(condFile));
		inFileDir = fullfile(inRootDir, subjectDir, inEEGFile);


		disp(' ');
		disp('==================================');
		disp(inFileDir);
		

		% Load the EEG data
        if ~exist(inFileDir, 'file')
            disp(['File not found: ', inEEGFile]);
            continue;
        end
		EEG = pop_loadset('filename', inFileDir);



		% Find theta channel index
		thetaIdx = zeros(1, 1);
		for i = 1:length(EEG.chanlocs)
			if strcmp(EEG.chanlocs(i).labels, thetaChannel)
				thetaIdx = i;
				break;
			end
		end

		% Find alpha channel indices
		alphaIdxs = zeros(5, 1);
		for channelIdx = 1:length(alphaChannels)
			for i = 1:length(EEG.chanlocs)
				if strcmp(EEG.chanlocs(i).labels, alphaChannels{channelIdx})
					alphaIdxs(channelIdx) = i;
					break;
				end
            end
		end



		%% Calculate Frequency Band Power
		spectra = spectopo(EEG.data, EEG.pnts, EEG.srate, 'plot', 'off');
		
		% Initialize variables to store band power
		thetaPower = zeros(1, 1);
		alphaPower = zeros(length(alphaIdxs), 1);


		% Loop through channels and calculate average band power
		
		% Theta power
		for channelIdx = 1:length(thetaIdx)
			currentIdx = thetaIdx(channelIdx);
			
			for bandIdx = 1:length(thetaBand)
				band = thetaBand(bandIdx);
				
				thetaPower(channelIdx) = thetaPower(channelIdx) + spectra(currentIdx, band+1);
			end
			thetaPower(channelIdx) = thetaPower(channelIdx)/length(thetaBand);
		end
		

		% Alpha power
		for channelIdx = 1:length(alphaIdxs)
			currentIdx = alphaIdxs(channelIdx);
            if currentIdx == 0
                alphaPower(channelIdx) = 0
                continue;
            end
			
			for bandIdx = 1:length(alphaBand)
				band = alphaBand(bandIdx);
				
				alphaPower(channelIdx) = alphaPower(channelIdx) + spectra(currentIdx, band+1);
			end
			alphaPower(channelIdx) = alphaPower(channelIdx)/length(alphaBand);
		end
		
		

		% Print average power
		fprintf('Theta Power (%s):\t\t\t\t %f uV²/Hz\n', thetaChannel, thetaPower);
		fprintf('Alpha Power (%s):\t %f uV²/Hz\n', strjoin(string(alphaChannels)), mean(alphaPower));
		

		%fprintf('\nIndividual Alpha Power:\n');
		%for channelIdx = 1:length(alphaChannels)
		%	fprintf('\t%s: %f uV²/Hz\n', alphaChannels{channelIdx}, alphaPower(channelIdx));
		%end	


		% Write data for this subject to the CSV file
		csv = fopen(outFileDir, 'a');
		fprintf(csv, '%s,%s,%.6f,%.6f,%.6f,%.6f,%.6f,%.6f,%.6f\n', subjectDir, char(conditions(cond)), thetaPower, mean(alphaPower), alphaPower(1), alphaPower(2), alphaPower(3), alphaPower(4), alphaPower(5));
		
		% Close the file
		fclose(csv);
		disp(['---> ', subjectDir, ' ', char(conditions(cond)),' data saved!']);
		disp('==================================');
		end	
end
disp(['BandPower.csv saved to "', outRootDir, '" successfully!!']);