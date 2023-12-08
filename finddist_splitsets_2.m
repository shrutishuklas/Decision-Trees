function [train_result_matrix, DistSample_frst_norm_b]=finddist_splitsets_2(train_result_matrix,Train_Set,QQ_trans_opt_b,min_val_b_opt,max_val_b_opt,threshold_dist_b,b_col)

DistSample_firstsplit_b=[];
DistSample_frst_norm_b=[];


%%%%%%%%%%
% There are 2 splitting points available
% 1.  b l1 subspace koptimal distance threshold
% 2.  m's l1 subspace kth rank optimal outlier distance threshold
%
% 1. splitting on b, Q subspace of optrank
%    Finding distance of all records and normalizing it as per training records
DistSample_firstsplit_b=sum(abs(Train_Set - QQ_trans_opt_b* Train_Set),1);
DistSample_frst_norm_b=(DistSample_firstsplit_b-min_val_b_opt)/(max_val_b_opt-min_val_b_opt);

for count = 1: size(Train_Set,2)
     
    if DistSample_frst_norm_b(count) <= threshold_dist_b
        
        train_result_matrix(count,b_col)=1;
    end
  
  end
% train_result_matrix;
%DistSample_frst_norm_b
% DistSample_frst_norm_m;
end