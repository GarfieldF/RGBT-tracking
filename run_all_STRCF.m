
% This demo script runs the STRCF tracker with all file in the sequences
% file

% Add paths
clear all
setup_paths();

%  Load video information
base_path  =  './RGB-T234/';
%video  = choose_video(base_path);
dirs = dir(base_path);
videos = {dirs.name};
videos(strcmp('.', videos) | strcmp('..', videos) | ...
strcmp('anno', videos) | ~[dirs.isdir]) = [];

all_precisions = zeros(numel(videos),1);
all_AUC = zeros(numel(videos),1);    %to compute averages
all_fps = zeros(numel(videos),1);

if ~exist('matlabpool', 'file'),
	%no parallel toolbox, use a simple 'for' to iterate
	for k = 1:numel(videos),
			
		video_path = [base_path  videos{k}];
		[seq, gt_boxes] = load_video_info(video_path);

		% Run STRCF
		results = run_STRCF(seq);
		
		%%%%%%%%%%%%%%%CALC OUTPUT%%%%%%%%	
		pd_boxes = results.res;
		%precision plot
		show_plots=0;
		precisions = precision_plot(pd_boxes, gt_boxes, videos{k}, show_plots);

		all_precisions(k)=precisions(20);

		%success plot  can be moved to another new file
		thresholdSetOverlap = 0: 0.05 : 1;
		success_num_overlap = zeros(1, numel(thresholdSetOverlap));
		res = calcRectInt(gt_boxes, pd_boxes);
		for t = 1: length(thresholdSetOverlap)
			success_num_overlap(1, t) = sum(res > thresholdSetOverlap(t))/ size(gt_boxes, 1);
		end

		all_AUC(k) = mean(success_num_overlap) ;
		all_fps(k) = results.fps;

		display([videos{k}  '---->' '   FPS:   ' num2str(all_fps(k))   '    AUC:   '   num2str(all_AUC(k)) '   Precision (20px): ' num2str(all_precisions(k))]);
        %%%%%SAVE THE RESULT%%%%%
        save(['./results/' lower(videos{k}) '__RGBT'  '.mat'], 'results');
					
				
				
				
						
	end
else
	%evaluate trackers for all videos in parallel
	if parpool('size') == 0,
		parpool open;
	end
	parfor k = 1:numel(videos),
		video_path = [base_path  videos{k}];
		[seq, gt_boxes] = load_video_info(video_path);

		% Run STRCF
		results = run_STRCF(seq);
		
		pd_boxes = results.res;
		%precision plot
		show_plots=0;
		precisions = precision_plot(pd_boxes, gt_boxes, videos{k}, show_plots);

		all_precisions(k)=precisions(20);

		%success plot  can be moved to another new file
		thresholdSetOverlap = 0: 0.05 : 1;
		success_num_overlap = zeros(1, numel(thresholdSetOverlap));
		res = calcRectInt(gt_boxes, pd_boxes);
		for t = 1: length(thresholdSetOverlap)
			success_num_overlap(1, t) = sum(res > thresholdSetOverlap(t))/ size(gt_boxes, 1);
		end

		all_AUC(k) = mean(success_num_overlap) ;
		all_fps(k) = results.fps;

		display([videos{k}  '---->' '   FPS:   ' num2str(all_fps(k))   '    AUC:   '   num2str(all_AUC(k)) ' Precision (20px):% 1.3f, \n' precisions(20)]);
			
		
	end
end



