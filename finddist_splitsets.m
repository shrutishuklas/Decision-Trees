function [train_result_matrix, DistSample_frst_norm_b,DistSample_frst_norm_m,DistSample_frst_norm_n]=finddist_splitsets(train_result_matrix,Train_Set,QQ_trans_opt_b,QQ_trans_opt_m,QQ_trans_opt_n,min_val_b_opt,max_val_b_opt,min_val_m_opt,max_val_m_opt,min_val_n_opt,max_val_n_opt,threshold_dist_b,threshold_dist_m,threshold_dist_n)

numRows_tr = size(Train_Set, 2)
resCol_tr_splitb = zeros(numRows_tr, 1);
resCol_tr_splitm = zeros(numRows_tr, 1);
resCol_tr_splitn = zeros(numRows_tr, 1);
%res_split= zeros(numRows_tr, 1);
train_result_matrix = [train_result_matrix, resCol_tr_splitb, resCol_tr_splitm,resCol_tr_splitn];%,res_split];
b_col=size((train_result_matrix),2)-2;
m_col=size(train_result_matrix,2)-1;
n_col=size(train_result_matrix,2);

DistSample_firstsplit_b=[];
DistSample_frst_norm_b=[];
DistSample_firstsplit_m=[];
DistSample_frst_norm_m=[];
DistSample_firstsplit_n=[];
DistSample_frst_norm_n=[];


%%%%%%%%%%
% There are 2 splitting points available
% 1.  b l1 subspace koptimal distance threshold
% 2.  m's l1 subspace kth rank optimal outlier distance threshold
%
% 1. splitting on b, Q subspace of optrank
%    Finding distance of all records and normalizing it as per training records
DistSample_firstsplit_b=sum(abs(Train_Set - QQ_trans_opt_b* Train_Set),1);
DistSample_frst_norm_b=(DistSample_firstsplit_b-min_val_b_opt)/(max_val_b_opt-min_val_b_opt);

% 2. splitting on m, Q subspace of optrank
%    Finding distance of all records and normalizing it as per training records
DistSample_firstsplit_m=sum(abs(Train_Set - QQ_trans_opt_m* Train_Set),1);
DistSample_frst_norm_m=(DistSample_firstsplit_m-min_val_m_opt)/(max_val_m_opt-min_val_m_opt);

% 3. splitting on m, Q subspace of optrank
%    Finding distance of all records and normalizing it as per training records
DistSample_firstsplit_n=sum(abs(Train_Set - QQ_trans_opt_n* Train_Set),1);
DistSample_frst_norm_n=(DistSample_firstsplit_n-min_val_n_opt)/(max_val_n_opt-min_val_n_opt);


%%%%%Classifying the records as b or n by comparing  their distance with
%%%%%threshold obtained from the algo
for count = 1: size(Train_Set,2)
     
    if DistSample_frst_norm_b(count) <= threshold_dist_b
        
        train_result_matrix(count,b_col)=1;
    end
  
    if DistSample_frst_norm_m(count) <= threshold_dist_m
        train_result_matrix(count,m_col)=1;
    end

        if DistSample_frst_norm_n(count) <= threshold_dist_n
        train_result_matrix(count,n_col)=1;
    end
end
% train_result_matrix;
%DistSample_frst_norm_b
% DistSample_frst_norm_m;
end