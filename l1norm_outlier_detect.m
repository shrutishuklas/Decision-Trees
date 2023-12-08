
function [kopt, lambda_norm, QQ_trans_opt, min_val_opt, max_val_opt] =l1norm_outlier_detect(T_data, ranks)
numdata = size(T_data, 2);

error_data = nan(size(ranks));
QQ_trans_data = cell(1, ranks);
Dist_mat_data_array = nan(ranks, numdata);
threshold_rank_data = nan(size(ranks));
lambda_data = nan(size(ranks));
elbow_indx_rank_data = nan(size(ranks));
min_val_data = nan(size(ranks));
max_val_data = nan(size(ranks));

for i = 1:ranks
cd C:\Users\shukl\Documents\GitHub\Decision-Trees\

%T_data_temp=T_data;
Dist_mat_data=[];


BF_data=l1pca_BF(T_data,i,1,50,50,'');
QQ_trans_data{i}= BF_data * BF_data.';

for k = 1 : numdata
    A=T_data(:,k);
    
    Dist_mat_data(k)=norm((A-(BF_data*BF_data.'*A)),1);
    k;
    
end
Dist_mat_data=Dist_mat_data;


min_val=min(Dist_mat_data,[],"all");
max_val=max(Dist_mat_data,[],"all");
Dist_mat_data= Dist_mat_data-min_val;%]/[max_val-min_val]
if max_val>=10^-9
Dist_mat_data=Dist_mat_data /(max_val-min_val);
end

%Dist_mat_data

Dist_mat_data_array(i,:)=Dist_mat_data;
%[Dist_mat_data_asc,Indx_data]=sort(Dist_mat_data,"ascend");

[Dist_mat_data_asc,~]=sort(Dist_mat_data,"ascend");

%dist=Dist_mat_data_asc;
min(Dist_mat_data_asc,[],"all");
max(Dist_mat_data_asc,[],"all");
[elbow_data_err_angle,elbow_indx_data]=knee_pt_angle((Dist_mat_data_asc));

error_data(i)=elbow_data_err_angle;
%Dist_mat_data_asc(elbow_indx_data);
%Dist_mat_data_asc(elbow_indx_data);
threshold_rank_data(i)=Dist_mat_data_asc(elbow_indx_data);
lambda_data(i)=Dist_mat_data_asc(elbow_indx_data);
elbow_indx_rank_data(i)=elbow_indx_data;
min_val_data(i)=min_val;
max_val_data(i)=max_val;


end

% Rest of your calculations after the loop...

% Assign outputs
%err=error_data
%mx=max_val_data;
%mn=min_val_data;
[~, optrank] = max(error_data);
kopt=optrank;
lambda_norm= threshold_rank_data(kopt);
lambda = lambda_data(kopt);
QQ_trans_opt = QQ_trans_data{kopt};

min_val_opt = min_val_data(kopt);
max_val_opt = max_val_data(kopt);
end
