function [spiketimes,spiketraces,spikeidx]=MySpikeFinder(data,samplerate,reftime,spikewidth,...
                minpoint,thfactor,direction,plotting);
%   Function for thresholding spikes
%   by Avne Wallach
%   
%   data           = data vector with neural data including spikes
%   samplerate  = the sampling rate at which the data was acuired (Hz)
%   reftime     = refractory period in detection (1e-3 sec)
%   spikewidth  = width of spike trace. (2e-3 sec)
%   minpoint    = point of minimum in trace (0.5e-3)
%   thfactor    = threshold multiplication factor of base noise level
%   direction   =falling, rising
%   plotting    = 1 if you want plots, 0 if not

spiketimes=[];
spiketraces=[];
spikeidx=[];

%assign default variables
if nargin < 3
    samplerate=50;%in KHertz
    reftime=1.5;%time in mseconds to # pts
    spikewidth=1.5;%time in mseconds to # pts
    minpoint=0.5;
    thfactor=2;
    direction='falling';
    plotting = 0;
end
    
time=[1:length(data)]/samplerate;
reftime=round(reftime*samplerate);%time in seconds to # pts
spikewidth=round(spikewidth*samplerate);%time in seconds to # pts
minpoint=round(minpoint*samplerate);

%thresholds
% try
%     noisethresh=median(abs(data));
% catch
%     noisethresh=median(abs(data(1:end/2)));
% end
% spikethresh=thfactor*noisethresh;
spikethresh=thfactor;

% %find downward threshold crossings
% falling=find(diff(data((minpoint+1):(end-spikewidth))<-spikethresh)==1)+minpoint;
% %find upward threshold crossings
% rising=find(diff(data((minpoint+1):(end-spikewidth))>spikethresh)==1)+minpoint;
% switch direction
%     case 'rising' 
%         possiblespikes=rising;
%     case 'falling'
%         possiblespikes=falling;
%     case 'both'
%         possiblespikes=union(rising,falling);        
% end
% 
% if(numel(possiblespikes))
%     %clean possible spikes to get rid of duplicates
%     chkspikes=possiblespikes(find(diff(possiblespikes)<reftime)+1); %index of possible problems
%     gdspikes=setdiff(possiblespikes,chkspikes); %index of good spikes
%     for i=2:numel(chkspikes)
%         m=chkspikes(i)-gdspikes;
%         if(min(m(m>0))>reftime) %last good spike is beyond ref time
%             gdspikes=union(gdspikes,chkspikes(i)); %add spike to good spikes
%         end
%     end
%     possiblespikes=gdspikes(:)';
    if(strcmp(direction,'falling'))
        data=-data;
    end
    
    overth=(data<=spikethresh); %over spike threshold
    underth=(abs(data)<(spikethresh/2)); %within reset threshold
    underth=movprod(underth,[9 0]); %5 consecutive samples in reset
    %run over vector
    x=zeros(1,numel(data));
    for i=2:numel(data)
        x(i)=(x(i-1) | underth(i-1)) & overth(i-1);
    end
    possiblespikes=find(diff(x)==-1);
    possiblespikes=possiblespikes(possiblespikes<=(numel(data)-reftime)); %remove spikes too close to end
    %find extrema
    idx=((0:reftime-1)'*ones(1,length(possiblespikes)))+(ones(reftime,1)*possiblespikes);

%     [minima,min_idx]=min(data(idx));
    [maxima,max_idx]=max(data(idx));   
%     min_idx=min_idx+possiblespikes;
    max_idx=max_idx+possiblespikes-1;
    idx=max_idx;
    idx=idx((idx-minpoint)>0 & (idx-minpoint)<(numel(data)-spikewidth));
    
    spiketimes=time(idx);
    %extract traces
    spikeidx=(((1:spikewidth)-minpoint)'*ones(1,length(idx)))+(ones(spikewidth,1)*idx);
%     if(min(spikeidx(:))<=0)
%         diaplay('problem');
%     end

%     if(strcmp(direction,'rising'))
%         data=-data; %invert data back
%     end

    spiketraces=reshape(data(spikeidx),size(spikeidx));
    % spiketraces=spiketraces-ones(size(spiketraces,1),1)*mean(spiketraces,1);

    %plot the spike times on the neural trace.
    if plotting    
        figure;
        set(gcf,'Position',[ 4,481,1019,217]);
        H=plot(time,data);hold on;
        set(H,'Color',0.5*[1 1 1]);
        plot([time(1) time(end)],-spikethresh*[1 1],':k');
        Vline(spiketimes,'g');
        plot(time(spikeidx),spiketraces);
    end
end    