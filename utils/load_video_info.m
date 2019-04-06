function [seq, ground_truth] = load_video_info(video_path)

ground_truth = dlmread([video_path '/visible.txt']);

seq.format = 'otb';
seq.len = size(ground_truth, 1);
seq.init_rect = ground_truth(1,:);

img_path = [video_path '/visible/'];

img_files = dir([img_path '*.jpg']);
assert(~isempty(img_files), 'No image files to load.')
img_files = sort({img_files.name});
for i= 1:numel(img_files)
    img_files{i}=[img_path img_files{i}];
end
seq.s_frames = img_files';	



infra_path = [video_path '/infrared/'];

infra_files = dir([infra_path '*.jpg']);
assert(~isempty(infra_files), 'No image files to load.')
infra_files = sort({infra_files.name});
for i= 1:numel(infra_files)
    infra_files{i}=[infra_path infra_files{i}];
end
seq.s_frames2 = infra_files';	


