%% Import ex vivo ERGs into matlab
% having trouble getting matlab to set those ERG files as a working directory
% so i've just been doing that manually
filmappe = uigetdir;
navne = dir(filmappe);

% Sort by date and time
[~,index] = sortrows({navne.date}.');
navne = navne(index);
clear index;

%% Save trace properties to structure S
t = 0;
for a = 3:length(navne)
    if ~isempty(strfind(navne(a).name,'.csv')) % only csv files
    % don't include the empty/random files
%        if navne(a).bytes > 10000
		navn = navne(a).name;
		[num, txt, raw] = xlsread(navn);
		% num starts at the first row with number. add rows to keep row#s equal
		A = length(raw)-length(num); A = A+1;
		B = zeros(size(raw));
		B(A:end,1:3) = num; num = B;
		t = t + 1;

		% wasn't sure the best thing to call each trace so feel free to change
		r = sprintf('trace%u',t);

		S.(r).fname = navn;
		S.(r).fpath = filmappe;
		S.(r).day = navne(a).date;
		S.(r).addInfo = char(txt(8,2));

		S.(r).amplifier.gain = num(11,2);
		S.(r).amplifier.LPF = num(12,2);
		S.(r).amplifier.HPF = num(13,2);

		S.(r).frequency = num(19,2);
		S.(r).LPF = num(20,2);
		S.(r).blindCycles = num(21,2);
		S.(r).cycles = num(22,2);
		S.(r).offset = num(23,2);

		%% SPECTRA ONE
		S.(r).spectra1.phase = num(15,2);
		S.(r).spectra1.duty = num(17,2);
		S.(r).spectra1.type = char(txt(25,2)); 
		S.(r).spectra1.npeaks = num(26,2);
		if S.(r).spectra1.npeaks == 1
			S.(r).spectra1.wl = num(28,1);
			S.(r).spectra1.bw = num(28,2);
			S.(r).spectra1.int = num(28,3);
			S.(r).spectra1.spectra = [S.(r).spectra1.wl S.(r).spectra1.bw S.(r).spectra1.int];
		else % I haven't tested this out yet but it's the same as the old program
			S.(r).spectra1.spectra = zeros(n,3);	
			for ii = 1:S.(r).spectra1.npeaks
				S.(r).spectra1.wl(ii,1) = num(27+ii,1);
				S.(r).spectra1.bw(ii,1)= num(27+ii,2);
				S.(r).spectra1.int(ii,1) = num(27+ii,3);
				% wasn't sure which way to save all this so tried out 2 options
				S.(r).spectra1.spectra(ii,1) = num(27+ii,1);
				S.(r).spectra1.spectra(ii,2) = num(27+ii,2);
				S.(r).spectra1.spectra(ii,3) = num(27+ii,3);
			end
		end

		%% SPECTRA TWO
		S.(r).spectra2.phase = raw(16,2);
		S.(r).spectra2.duty = raw(18,2);
		% account for row offset of multiple spectra1 peaks
		if S.(r).spectra1.npeaks > 2
			n = S.(r).spectra1.npeaks - 1;
		else
			n = 0;
		end
		S.(r).spectra2.type = char(txt(29+n,2));
		S.(r).spectra2.npeaks = num(30+n,2);
		if S.(r).spectra2.npeaks == 1
			S.(r).spectra2.wl = num(32+n,1);
			S.(r).spectra2.bw = num(32+n,2);
			S.(r).spectra2.int = num(32+n,3);
			S.(r).spectra2.spectra = [S.(r).spectra2.wl S.(r).spectra2.bw S.(r).spectra2.int];
		else 
			S.(r).spectra2.spectra = zeros(S.(r).spectra2.npeaks,3);
			for ii = 1:S.(r).spectra2.npeaks
				S.(r).spectra2.wl(ii) = num(31+n+ii,1);
				S.(r).spectra2.bw(ii) = num(31+n+ii,2);
				S.(r).spectra2.int(ii) = num(31+n+ii,3);
				S.(r).spectra2.spectra(ii,:) = [num(31+n+ii,1) num(31+n+ii,2) num(31+n+ii,3)];
			end 
		end
		%% Data
		S.(r).data = num(301:end,3);
		S.(r).time = num(301:end,2);

		%% get info from file name
		navn = lower(navn);
		S.(r).drug = []; % get drug information
		if ~isempty(strfind(navn,'gaba'))
			S.(r).drug = 'GABAzine+TPMPA';
		end
		if ~isempty(strfind(navn,'ap4')) || ~isempty(strfind(navn,'apb'))
			if isempty(strfind(navn,'gaba'))
				S.(r).drug = 'LAP4';
			else
				S.(r).drug = 'LAP4+GABAzine+TPMPA';
			end
		end
		if ~isempty(strfind(navn,'wash'))
			% maybe name these by the previous drug in the future?
			% or save time into the .csv files?
			% or hopefully i'll figure out the googledrive timestamp issues soon..
			if isempty(S.(r).drug)
				S.(r).drug = 'Ames Wash';
			else
				S.(r).drug = sprintf('%s Wash',S.(r).drug);
			end
		end
		if isempty(S.(r).drug)
			S.(r).drug = 'Ames';
		end

		% Neutral density filter
		if ~isempty(strfind(navn,'10^0')) || ~isempty(strfind(navn,'no NDF'))
			S.(r).NDF = 'none';
		elseif ~isempty(strfind(navn,'10^3')) || ~isempty(strfind(navn,'10e3'))
			S.(r).NDF = '10e3';
		elseif ~isempty(strfind(navn,'10^6')) || ~isempty(strfind(navn,'10e6'))
			S.(r).NDF = '10e6';
		else
			S.(r).NDF = [];
		end
		
		% not sure how to pull this yet
		S.(r).temp = 35.7;

		% get ERG type information
		S.(r).ERGtype = [];
		if ~isempty(strfind(navn,'onoff'))
			S.(r).ERGtype = 'OnOff';
		end
		if ~isempty(strfind(navn,'iso'))
			S.(r).ERGtype = 'S-iso';
	    end
	    if strcmpi(S.(r).spectra1.type,'Light Spec') && strcmpi(S.(r).spectra2.type,'Light Spec')
	    	S.(r).ERGtype = 'S-iso';
	    end
    end
end
