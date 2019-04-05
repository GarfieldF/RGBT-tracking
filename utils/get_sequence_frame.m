function [seq, im,im2] = get_sequence_frame(seq)

seq.frame = seq.frame + 1;

if strcmpi(seq.format, 'otb')
    if seq.frame > seq.num_frames
        im = [];
        im2 = [];
    else
        im = imread(seq.image_files{seq.frame});
        im2 = imread(seq.image_files2{seq.frame});
    end
elseif strcmpi(seq.format, 'vot')
    [seq.handle, image_file] = seq.handle.frame(seq.handle);
    if isempty(image_file)
        im = [];
    else
        im = imread(image_file);
    end
else
    error('Uknown sequence format');
end