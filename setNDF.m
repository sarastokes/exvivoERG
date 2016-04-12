
n = fieldnames(S);
for ii = 1:length(n)
  r = sprintf('trace%u',ii);
  navn = S.(r).fname;
  if ~isempty(strfind(navn,'10^0')) || ~isempty(strfind(navn,'no NDF'))
    S.(r).NDF = '10e0';
  elseif ~isempty(strfind(navn,'10^3')) || ~isempty(strfind(navn,'10e3'))
    S.(r).NDF = '10e3';
  elseif ~isempty(strfind(navn,'10^6')) || ~isempty(strfind(navn,'10e6'))
    S.(r).NDF = '10e6';
  else
    S.(r).NDF = [];
  end
  if ~isempty(S.(r).NDF)
    fprintf('Trace%u has a %s NDF\n',ii,S.(r).NDF)
  end
end
