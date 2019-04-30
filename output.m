% This demo script runs the STRCF tracker with all file in the sequences
% file

% Add paths
clear all
setup_paths();

%  Load video information
base_path  =  './data/';
%video  = choose_video(base_path);
dirs = dir(base_path);
videos = {dirs.name};
videos(strcmp('.', videos) | strcmp('..', videos) | ...
strcmp('anno', videos) | ~[dirs.isdir]) = [];



if ~exist('matlabpool', 'file'),
	%no parallel toolbox, use a simple 'for' to iterate
	for k = 1:numel(videos),
			
		video_path = [base_path  videos{k}];
		[seq, gt_boxes] = load_video_info(video_path);

		% Run STRCF
		results = run_STRCF(seq);
		
		%%%%%%%%%%%%%%%CALC OUTPUT%%%%%%%%	
		pd_boxes = results.res;
        
        our_proposedCenterAll  = cell(1,size(pd_boxes,1));      
        our_proposedCornersAll = cell(1,size(pd_boxes,1));
        
        center=[pd_boxes(:,1:2)+pd_boxes(:,3:4)/2]';
     
        
        for num=1:size(pd_boxes,1)
            corners=[pd_boxes(num,1:2);pd_boxes(num,1:2)+[pd_boxes(num,3),0];
           pd_boxes(num,1:2)+[pd_boxes(num,3),pd_boxes(num,4)];
           pd_boxes(num,1:2)+[0,pd_boxes(num,4)];pd_boxes(num,1:2)]';
            
        our_proposedCenterAll{num}=center(:,num);
        our_proposedCornersAll{num} = corners;
        end
		%%%%%SAVE THE RESULT%%%%%
        save(['./results/v/' videos{k} '_v_our_proposed_rs.mat'], 'our_proposedCenterAll','our_proposedCornersAll');
		save(['./results/i/' videos{k} '_i_our_proposed_rs.mat'], 'our_proposedCenterAll','our_proposedCornersAll');
		
				
				
				
						
    end
end
