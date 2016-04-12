list = fieldnames(S);
fprintf('Scone iso traces\n');
sisoList = zeros(1,1);
sisoData = 1;
for ii = 1:length(list)
    t = sprintf('trace%u',ii);
    if strcmpi(S.(t).spectra1.type,'Light Spec') == 1 && strcmpi(S.(t).spectra2.type,'Light Spec')
        % fprintf('%s at %s and %s - %s\n',t,mat2str(S.(t).spectra1.spectra),...
    	% mat2str(S.(t).spectra2.spectra),S.(t).drug);
        sisoList(end+1,1) = ii;
        % create a matrix with all the s-iso traces
        % could move this to a seperate for loop operating off sisoList and
        % assigning to a preallocated matrix (for speed apparently)
        if strcmpi(S.(t).drug,'Ames')
            if sisoData == 1 % if this is the first s-iso trace
                sisoData = S.(t).data;
            else
                sisoData(1:(length(S.(t).data)),end+1) = S.(t).data;
            end
            if S.(t).spectra2.int == 10
                plot(S.(t).time,S.(t).data,'linewidth',1.5);hold on;
                fprintf('Trace%u plotted\n',ii);
            end
            fprintf('Trace%u - %s with %s\n',ii,mat2str(S.(t).spectra1.spectra),S.(t).drug)
        end
    end
end

%% plot them
%figure('windowstyle','docked');
%for ii = 1:length(sisoList)
%    plot(ERGtime(1:length(sisoData(ii))),sisoData(:,ii),'linewidth',1.5);hold on;
%end
        
        