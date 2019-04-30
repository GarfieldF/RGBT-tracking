function [newpool,avgfilter,sumfilter] = filterpoolupdate(oldpool, newfilter, framenum, filtersize ,  sumfilter)
     newpool = oldpool;
  if framenum <= filtersize

      newpool{framenum} = newfilter;
      
  else 
      
      newpool = [oldpool(2:end),newfilter];
      tmpfilter = oldpool{1};
      
  end 
  

  
   if framenum <= filtersize
      
      sumfilter = sumfilter+newfilter;
      avgfilter = (sumfilter)/framenum;
      
   else 
       
      sumfilter = sumfilter-tmpfilter+newfilter;
      avgfilter = (sumfilter)/filtersize;
      
   end 
  

end 