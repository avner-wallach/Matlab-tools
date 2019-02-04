fpath='Z:\mormyrid_data\20181026\';
for i=0:58
    infile=[fpath,'video_',num2str(i),'_scaled_tracking.csv'];
    outfile=[fpath,'video_',num2str(i),'_tracking.csv'];
    movefile(infile,outfile);
end