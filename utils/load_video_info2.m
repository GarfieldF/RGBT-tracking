function [seq, ground_truth] = load_video_info2(video_path)

tmp_ground_truth_i = dlmread([video_path '/groundTruth_i.txt']);
ground_truth = [tmp_ground_truth_i(:,1),tmp_ground_truth_i(:,2),tmp_ground_truth_i(:,3)-tmp_ground_truth_i(:,1),tmp_ground_truth_i(:,4)-tmp_ground_truth_i(:,2)];
seq.format = 'otb';
seq.len = size(ground_truth, 1);
seq.init_rect = ground_truth(1,:);

img_path = [video_path '/v/'];

img_files = dir([img_path '*.png']);
assert(~isempty(img_files), 'No image files to load.')
img_files = sort({img_files.name});
for i= 1:numel(img_files)
    img_files{i}=[img_path img_files{i}];
end
seq.s_frames = img_files';	



infra_path = [video_path '/i/'];

infra_files = dir([infra_path '*.png']);
assert(~isempty(infra_files), 'No image files to load.')
infra_files = sort({infra_files.name});
for i= 1:numel(infra_files)
    infra_files{i}=[infra_path infra_files{i}];
end
seq.s_frames2 = infra_files';	
end


