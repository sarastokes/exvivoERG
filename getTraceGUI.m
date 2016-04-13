function [] = getTraceGUI(S)
%% Setup
set(0,'DefaultTextFontSize',10);
set(0,'DefaultTextFontName','Roboto');
fnt = 'roboto'; fsz = 9;
x1 = 10; x2 = 90;
xs = 70; ys = 20;
xo = 250; yo = 600;
%S.guiList = fieldnames(S);

f1.fh = figure('units','pixels',...
              'position',[300 300 600 600],...
              'menubar','none',...
              'numbertitle','off',...
              'name','ExVivoERG',...
              'color',[0 0.8 0.6],...
              'resize','off');
setappdata(f1.fh,'GUIdata',S);
f1.fh.UserData = S;

%% Spectra
y = yo - (ys+50);
y = y - (ys+20);
f1.spectraType.tx = uicontrol('style','text',...
					 		  'unit','pixels',...
                              'string','Type',...
					 		  'position',[x1 y xs ys],...
					 		  'fontname',fnt,'fontsize',fsz);
y = y - (ys+15);
f1.wl.tx = uicontrol('style','text',...
					 'unit','pixels',...
					 'string','Wavelength',...
					 'position',[x1 y xs ys],...
					 'fontname',fnt,'fontsize',fsz);
y = y - (ys+15);
f1.bw.tx = uicontrol('style','text',...
					 'unit','pixels',...
					 'string','Bandwidth',...
					 'position',[x1 y xs ys],...
					 'fontname',fnt,'fontsize',fsz);
y = y - (ys+15);
f1.in.tx = uicontrol('style','text',...
					  'unit','pixels',...
					  'string','Intensity',...
					  'position', [x1 y xs ys],...
					  'fontname',fnt,'fontsize',fsz);

for ii = 1:2
	x = x2*ii;
%	y = get(f1.ERGtype.ls,'position');
%	y = y(2);
	y = yo - (ys+50+15);
	f1.spectra.pb(ii) = uicontrol('style','push',...
						   	      'unit','pixels',...
							        'position', [x y xs ys],...
							        'string',sprintf('Spectra%u',ii),...
							        'fontname',fnt,'fontsize',fsz);
	y = y - (ys+25);
	f1.spectraType.ls(ii) = uicontrol('style','list',...
						              'unit','pixels',...
                          'position', [x y xs (ys*1.75)],...
                          'tag',sprintf('SpectraType%u',ii),...
                          'string',{'Light','Dark'},...
                          'fontname',fnt,'fontsize',fsz);
	y = y - (ys+15);
	f1.wl.ed(ii) = uicontrol('style','edit',...
						 'unit','pixels',...
						 'string','nm',...
						 'tag',sprintf('wl%u',ii),...
						 'position',[x y xs ys],...
						 'fontname',fnt,'fontsize',fsz);
	y = y - (ys+15);
	f1.bw.ed(ii) = uicontrol('style','edit',...
							'unit','pixels',...
							'position',[x y xs ys],...
							'tag', sprintf('bw%u',ii),...
							'string','nm',...
							'fontname',fnt,'fontsize',fsz);
	y = y - (ys+15);
	f1.in.ed(ii) = uicontrol('style','edit',...
							 'unit','pixels',...
							 'position',[x y xs ys],...
							 'tag', sprintf('in%u',ii),...
							 'string','%',...
							 'fontname',fnt,'fontsize',fsz);
end

y = get(f1.in.ed(2),'position'); y = y(2);
y = y - (ys+45);
f1.drug.pb = uicontrol('style','push',...
				  	   'unit','pixels',...
					   'position', [x1 y xs ys],...
             'tag','drugPB',...
					   'string','Drugs',...
					   'fontname',fnt,'fontsize',fsz);
y = y - (ys+15);
f1.drug.ls = uicontrol('style','list',...
					   'unit','pixels',...
					   'position', [x2 y (xs*2.3) (ys*4)],...
             'tag','drug',...
					   'string',{'none','Ames','L-AP4','GABAzine+TPMPA','GABAzine+TPMPA+LAP4'},...
					   'fontname',fnt,'fontsize',fsz);
y = y - (ys+20);
f1.ndf.pb = uicontrol('style','push',...
					  'unit','pixels',...
					  'position', [x1 y xs ys],...
					  'string','NDF',...
					  'fontname',fnt,'fontsize',fsz);
y = y - (ys+5);
f1.ndf.ls = uicontrol('style','list',...
					  'unit','pixels',...
					  'string',{'none','10e0','10e3'},...
            'tag','ndf',...
					  'position',[x2 y xs (ys*2.5)],...
					  'fontname',fnt,'fontsize',fsz);
y = y - (ys+15);
f1.ERGtype.pb = uicontrol('style','push',...
					 	  'units','pixels',...
					 	  'position', [x1 y xs ys],...
					 	  'string','ERGtype',...
              'fontsize',fsz,'fontname',fnt);
y = y - (ys+20);
f1.ERGtype.ls = uicontrol('style','list',...
              'unit','pixels',...
              'position',[x2 y 60 65],...
              'tag','ERGtype',...
              'string',{'none','S-Iso','OnOff','FPhot'},...
              'fontname',fnt,'fontsize',fsz);
y = y - (ys + 60);
f1.listpb = uicontrol('style','push',...
					  'unit','pixels',...
					  'position',[(x1+30) y 75 40],...
					  'string','update list',...
					  'fontname',fnt,'fontsize',11);
navne = fieldnames(S);
f1.resetpb = uicontrol('style','push',...
                       'unit','pixels',...
                       'position',[(x2+30) y 70 40],...
                       'tag','resetList',...
                       'string','reset list',...
                       'fontname',fnt,'fontsize',11);
f1.graphpb = uicontrol('style','push',...
                       'unit','pixels',...
                       'position', [(x2+30+70) y 50 40],...
                       'tag','graphpb',...
                       'string','graph',...
                       'fontname',fnt,'fontsize',11);
f1.fname.ls = uicontrol('style','list',...
						'unit','pixels',...
						'string',navne,...
            'tag','traceList',...
						'position', [300 325 250 250],...
						'fontname',fnt,'fontsize',fsz);
f1.ax = axes('units','pixels',...
             'position',[300 50 250 250],...
             'fontsize',9,...
             'tag','mainPlot',...
             'buttondownfcn',{@ax_bdfcn,f1},...
             'nextplot','replacechildren');
set(f1.listpb,'callback',{@listpb_call,f1});
%set(f1.ERGtype.ls,'selectionchangefcn',{@ERGtype_scfcn,f1});
set(f1.spectra.pb(1),'callback',{@spectra1_call,f1});
set(f1.spectra.pb(2),'callback',{@spectra2_call,f1});
set(f1.drug.pb,'callback',{@drugpb_call,f1});
set(f1.ERGtype.pb,'callback',{@ERGtype_call,f1});
set(f1.ndf.pb,'callback',{@ndf_call,f1});
set(f1.resetpb,'callback',{@resetList_call,f1});
set(f1.graphpb,'callback',{@graph_call,f1});

function [] = graph_call(varargin)
  [h,f1] = varargin{[1,3]};  % Extract the calling handle and structure.
  S = getappdata(f1.fh,'GUIdata');
  traceList = get(findobj(gcbf,'tag','traceList'),'string');
  num = get(findobj(gcbf,'tag','traceList'),'value');
  n = traceList(num); display(n);
%  traceList = get(findobj(gcbf,'tag','traceList'),'String');
  set(gca,'tag','mainPlot');
    r = char(n); display(r);
%    t = 0:0.0002:length(S.(r).data);
    plot(S.(r).time, S.(r).data);
    title(sprintf('%s',char(r)));


function [] = resetList_call(varargin)
  f1 = varargin{3};
  S = getappdata(f1.fh,'GUIdata');
  S = rmfield(S,'guiList');
  n = fieldnames(S);
  S.guiList = n;
  set(f1.fname.ls,'string',S.guiList);
  setappdata(f1.fh,'GUIdata',S);
  assignin('base','guiList',S.guiList);
  foo = length(n);
  fprintf('Reset trace list - %u traces\n',foo);


function [] = ax_bdfcn(varargin)
% buttondownfcn for axes.
	[h,f1] = varargin{[1,3]};  % Extract the calling handle and structure.

function [] = listpb_call(varargin)
% callback for update pushbutton
	f1 = varargin{3};
  display(f1.fh.UserData);
  traceList = get(findobj(gcbf,'tag','traceList'),'String');
  display(traceList); assignin('base','traceList',traceList);
	%B = getappdata(f1.fh,'GUIdata');

function [] = ndf_call(varargin)
  f1 = varargin{3};
  S = getappdata(f1.fh,'GUIdata');
  % n = S.guiList; display(guiList,'NDF calls guiList');
  traceList = get(findobj(gcbf,'tag','traceList'),'String');
%  n = traceList; display(traceList,'NDF calls traceList');
  list = get(findobj(gcbf,'tag','ndf'),'string');
  num = get(findobj(gcbf,'tag','ndf'),'value');
  matchNDF = list(num); display(matchNDF);
  ct = 0;
  %tempList{1} = 'holding';

  if strcmpi(matchNDF,'none') == 0
    for ii = 1:length(traceList)
      % r = sprintf('trace%u',ii);
      r = traceList(ii); r = char(r);
      traceNDF = S.(r).NDF;
      if strcmpi(traceNDF,matchNDF) == 1
        if ct == 0
          tempList{1} = r; ct = ct + 1;
        else
          tempList{end+1} = r; ct = ct +1;
        end
        fprintf('Trace%u\n',ii);
      end
    end
    S.guiList = tempList; clear tempList; display(S.guiList,'NDF matches:');
    % set(f1.fname.ls,'string',S.guiList);
    set(f1.fname.ls,'string',tempList);
    setappdata(f1.fh,'GUIdata',S);
    assignin('base','guiList',S.guiList);
  end



function [] = ERGtype_call(varargin)
  f1 = varargin{3};
  S = getappdata(f1.fh,'GUIdata');
  traceList = get(findobj(gcbf,'tag','traceList'),'String');
  list = get(findobj(gcbf,'tag','ERGtype'),'string');
  num = get(findobj(gcbf,'tag','ERGtype'),'value');
  matchERG = list(num);  display(matchERG);
  ct = 0;
  %tempList{1} = 'holding';

  if strcmpi(matchERG,'none') == 0
    for ii = 1:length(traceList)
      r = traceList(ii); r = char(r);
      traceERG = S.(r).ERGtype;
      if strcmpi(traceERG,matchERG) == 1
        if ct == 0
          tempList{1} = r; ct = ct + 1;
        else
          tempList{end+1} = r; ct = ct + 1;
        end
        fprintf('Trace%u\n',ii);
      end
    end
    S.guiList = tempList; clear tempList; display(S.guiList,'ERGtype matches:');
    set(f1.fname.ls,'string',S.guiList);
    setappdata(f1.fh,'GUIdata',S);
    assignin('base','guiList',S.guiList);
  end

function [] = drugpb_call(varargin)
  % drug selection - n/a,ames, gaba+tpmpa, lap4,all 3
  f1 = varargin{3};
  S = getappdata(f1.fh,'GUIdata');
  traceList = get(findobj(gcbf,'tag','traceList'),'String');
  drugList = get(findobj(gcbf,'tag','drug'),'string');
  numDrug = get(findobj(gcbf,'tag','drug'),'value');
  matchDrug = drugList(numDrug); display(matchDrug);
  ct = 0;
  %tempList{1} = 'holding';

  if strcmpi(matchDrug,'none') == 0 % if a treatment was actually selected
    for ii = 1:length(traceList)
      r = traceList(ii); r = char(r);
      traceDrug = S.(r).drug;
      if strcmpi(traceDrug,matchDrug) == 1
        if ct == 0
          tempList{1} = r; ct = ct + 1;
        else
          tempList{end+1} = r; ct = ct + 1;
        end
        fprintf('Trace%u\n',ii);
      end
    end
    S.guiList = tempList; clear tempList; display(S.guiList,'Drug matches:')
    set(f1.fname.ls,'string',S.guiList);
    setappdata(f1.fh,'GUIdata',S);
    display(S.guiList);
    assignin('base','guiList',S.guiList);
  end



function [] = spectra1_call(varargin)
  % spectra1 - wl,bw,int
  f1 = varargin{3};
  S = getappdata(f1.fh,'GUIdata');
  traceList = get(findobj(gcbf,'tag','traceList'),'String');
  matchWL = get(findobj(gcbf,'tag','wl1'),'string');
  matchBW = get(findobj(gcbf,'tag','bw1'),'string');
  matchIN = get(findobj(gcbf,'tag','in1'),'string');
  matchSpectra = [matchWL matchBW matchIN];
  ct = 0; % count
  %tempList{1} = 'holding';

  for ii = 1:length(traceList)
    r = traceList(ii); r = char(r);
    traceSpectra = [S.(r).spectra1.wl S.(r).spectra1.bw S.(r).spectra1.int];
    traceWL = traceSpectra(1); traceBW = traceSpectra(2); traceIN = traceSpectra(3);
    % if wavelength is specified and doesn't equal trace(r), exit the for loop
    if strcmpi(matchWL,'nm') == 0 && str2num(matchWL) ~= traceWL
      continue;
    end
    if strcmpi(matchBW,'nm') == 0 && str2num(matchBW) ~= traceBW
      continue;
    end
    if strcmpi(matchIN,'%') == 0 && str2num(matchIN) ~= traceIN
      continue;
    end
    % if trace gets to this point it matches wl,bw and int (if specified)
    if ct == 0
      tempList{1} = r;
      ct = ct + 1;
    else
      tempList{end+1} = r;
      ct = ct + 1;
    end
    fprintf('Trace%u\n',ii);
  end
%  fprintf('   >>trace list update complete\n')

  S.guiList = tempList; clear tempList;display(S.guiList,'Spectra 1 matches:');
  set(f1.fname.ls,'string',S.guiList);
  setappdata(f1.fh,'GUIdata',S);
  assignin('base','guiList',S.guiList);


function [] = spectra2_call(varargin)
  % spectra1 - wl,bw,int
  f1 = varargin{3};
  S = getappdata(f1.fh,'GUIdata');
  traceList = get(findobj(gcbf,'tag','traceList'),'String');
  matchWL = get(findobj(gcbf,'tag','wl2'),'string');
  matchBW = get(findobj(gcbf,'tag','bw2'),'string');
  matchIN = get(findobj(gcbf,'tag','in2'),'string');
  matchSpectra = [matchWL matchBW matchIN];
  ct = 0; % count
%  tempList{1} = 'holding';

  for ii = 1:length(traceList)
    r = traceList(ii); r = char(r);
    traceSpectra = [S.(r).spectra2.wl S.(r).spectra2.bw S.(r).spectra2.int];
    traceWL = traceSpectra(1); traceBW = traceSpectra(2); traceIN = traceSpectra(3);
    % if wavelength is specified and doesn't equal trace(r), exit the for loop
    if strcmpi(matchWL,'nm') == 0 && str2num(matchWL) ~= traceWL
      continue;
    end
    if strcmpi(matchBW,'nm') == 0 && str2num(matchBW) ~= traceBW
      continue;
    end
    if strcmpi(matchIN,'%') == 0 && str2num(matchIN) ~= traceIN
      continue;
    end
    % if trace gets to this point it matches wl,bw and int (if specified)
    if ct == 0
      tempList{1} = r;
      ct = ct + 1;
    else
      tempList{end+1} = r;
      ct = ct + 1;
    end
    fprintf('Trace%u\n',ii);
  end
  S.guiList = tempList; clear tempList; display(S.guiList,'Spectra2 matches:');
  set(f1.fname.ls,'string',S.guiList);
  setappdata(f1.fh,'GUIdata',S);
  assignin('base','guiList',S.guiList);
