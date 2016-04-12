
	t = sprintf('trace%u',n);
    x = S.(t).time; y = S.(t).data;
    display(S.(t).spectra1.bw);
%	plot(S.(t).time, S.(t).data); hold on;
    plot(x,y,'linewidth',1.5); hold on;
if strcmpi(S.(t).spectra1.type,'Dark Spec') == 1
    fprintf('%s with %s\n',mat2str(S.(t).spectra1.spectra),S.(t).drug);
elseif strcmpi(S.(t).spectra2.type,'Dark Spec') == 1
    fprintf('%s with %s\n',mat2str(S.(t).spectra1.spectra),S.(t).drug);
elseif S.(t).spectra1.npeaks > 1 || S.(t).spectra2.npeaks > 1
    error('figure out what to do with multiple peaks');
else
    fprintf('%s and %s with %s\n', mat2str(S.(t).spectra1.spectra),...
    	mat2str(S.(t).spectra2.spectra),S.(t).drug);
end