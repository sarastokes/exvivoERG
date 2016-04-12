
  % to use with findSIso.. shouldn't be needed with new debugging of importERG
  % but just in case.. this can be used to assign s-iso to trace structure S
  if ~exist('sisoList')
    run findSIso.m;
  end
  for ii = 2:length(sisoList)
    a = sisoList(ii);
    r = sprintf('trace%u',a);
    S.(r).ERGtype = 'S-Iso';
  end
  fprintf('%u S-Iso traces found :)\n',n-1);
