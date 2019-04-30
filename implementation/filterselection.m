function [ selectfilter ] = filterselection(targetfilter, filterpool, filternum)
%FILTERSELECTION Summary of this function goes here
%   Detailed explanation goes here

  dis = zeros(filternum,1);
  for i = 1:filternum
      
      dis(i) =  norm(targetfilter(:)-filterpool{i}(:),2);
      
  end 
  [~,ind] = sort(dis,'ascend');
  selectfilter = filterpool(ind(1));
end

