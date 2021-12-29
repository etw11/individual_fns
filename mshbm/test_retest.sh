#!/bin/bash

# EVALUATING TEST RE-TEST RELIABILITY OF MS-HBM IN THE DBIS SUBSAMPLE
# Ethan Whitman
# 9/17/21

###########################################################################
######## step 1 - generating profiles and initialization parameters #######
###########################################################################

cd $CBIG_CODE_DIR/stable_projects/brain_parcellation/Kong2019_MSHBM/step1_generate_profiles_and_ini_params

open /Applications/MATLAB_R2021a.app/

# make profiles for DBIS test re-test
project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/generate_profiles_and_ini_params';
for sub = 1:19
 for sess = 1:2
	CBIG_MSHBM_generate_profiles('fs_LR_900','fs_LR_32k',project_dir,num2str(sub),num2str(sess),'0');
 end
end


# generate averaged profiles across all DBIS test re-test
num_sub = '765';
num_sess = '2';
CBIG_MSHBM_avg_profiles('fs_LR_900','fs_LR_32k',project_dir,num_sub,num_sess);


# apply yeo2011 clustering algorithm
num_clusters = '17';
num_initialization = '1000';
CBIG_MSHBM_generate_ini_params('fs_LR_900','fs_LR_32k',num_clusters,num_initialization, project_dir)


# # while I'm waiting to get the HCP data to train spatial and smoothness priors, im gonna
# # give it a try with split half-ing the DBIS test retest data.
# 
# ### LOW_HIGH
# # generate averaged profiles across DBIS test retest 1-10
# project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/low_high/generate_profiles_and_ini_params';
# num_sub = '10';
# num_sess = '2';
# CBIG_MSHBM_avg_profiles('fs_LR_900','fs_LR_32k',project_dir,num_sub,num_sess);
# 
# # apply yeo2011 clustering algorithm
# num_clusters = '17';
# num_initialization = '1000';
# CBIG_MSHBM_generate_ini_params('fs_LR_900','fs_LR_32k',num_clusters,num_initialization, project_dir)
# 
# 
# ### HIGH_LOW
# # generate averaged profiles across DBIS test retest 1-10
# project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/high_low/generate_profiles_and_ini_params';
# num_sub = '10';
# num_sess = '2';
# CBIG_MSHBM_avg_profiles('fs_LR_900','fs_LR_32k',project_dir,num_sub,num_sess);
# 
# # apply yeo2011 clustering algorithm
# num_clusters = '17';
# num_initialization = '1000';
# CBIG_MSHBM_generate_ini_params('fs_LR_900','fs_LR_32k',num_clusters,num_initialization, project_dir)

# # trying train = 6, validate = 6, test = 8
# 
# ### 668
# # generate averaged profiles across DBIS test retest 1-6
# project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/668/generate_profiles_and_ini_params';
# num_sub = '6';
# num_sess = '2';
# CBIG_MSHBM_avg_profiles('fs_LR_900','fs_LR_32k',project_dir,num_sub,num_sess);
# 
# # apply yeo2011 clustering algorithm
# num_clusters = '17';
# num_initialization = '1000';
# CBIG_MSHBM_generate_ini_params('fs_LR_900','fs_LR_32k',num_clusters,num_initialization, project_dir)


# generating profiles for 32 HCP test retest
# addpath(genpath('/cifs/hariri-long/Projects/ethan/CBIG-master'));
# project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/hcp_trained/generate_profiles_and_ini_params';
# for sub = 1:32
#  for sess = 1:2
# 	CBIG_MSHBM_generate_profiles('fs_LR_900','fs_LR_32k',project_dir,num2str(sub),num2str(sess),'0');
#  end
# end


# # generate averaged profiles across all HCP test re-test
# num_sub = '32';
# num_sess = '2';
# CBIG_MSHBM_avg_profiles('fs_LR_900','fs_LR_32k',project_dir,num_sub,num_sess);
# 
# 
# # apply yeo2011 clustering algorithm
# # figure out if i actually need to do this lol
# num_clusters = '17';
# num_initialization = '1000';
# CBIG_MSHBM_generate_ini_params('fs_LR_900','fs_LR_32k',num_clusters,num_initialization, project_dir);


# TIME POINT 1
# make profiles for DBIS test re-test

### use just one scan session for profiles - pass flag to split into fake runs ###

project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/hcp_trained/generate_profiles_and_ini_params';
for sub = 1:19
	CBIG_MSHBM_generate_profiles('fs_LR_900','fs_LR_32k',project_dir,num2str(sub),'1','1');
end


CBIG_MSHBM_generate_profiles('fs_LR_900','fs_LR_32k',project_dir,'19','1','1');

# generate averaged profiles across all DBIS test re-test
num_sub = '19';
num_sess = '2';
CBIG_MSHBM_avg_profiles('fs_LR_900','fs_LR_32k',project_dir,num_sub,num_sess);


# apply yeo2011 clustering algorithm
num_clusters = '17';
num_initialization = '1000';
CBIG_MSHBM_generate_ini_params('fs_LR_900','fs_LR_32k',num_clusters,num_initialization, project_dir)



# TIME POINT 2
project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/hcp_trained/generate_profiles_and_ini_params_sess2';
for sub = 1:19
	CBIG_MSHBM_generate_profiles('fs_LR_900','fs_LR_32k',project_dir,num2str(sub),'1','1');
end

# generate averaged profiles across all DBIS test re-test
num_sub = '19';
num_sess = '2';
CBIG_MSHBM_avg_profiles('fs_LR_900','fs_LR_32k',project_dir,num_sub,num_sess);


# apply yeo2011 clustering algorithm
num_clusters = '17';
num_initialization = '1000';
CBIG_MSHBM_generate_ini_params('fs_LR_900','fs_LR_32k',num_clusters,num_initialization, project_dir)



### group averaging using both profiles from both sessions

project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/hcp_trained/generate_profiles_and_ini_params';
for sub = 1:19
	CBIG_MSHBM_generate_profiles('fs_LR_900','fs_LR_32k',project_dir,num2str(sub),'2');
end

# generate averaged profiles across all DBIS test re-test
num_sub = '19';
num_sess = '2';
CBIG_MSHBM_avg_profiles('fs_LR_900','fs_LR_32k',project_dir,num_sub,num_sess);


# apply yeo2011 clustering algorithm
num_clusters = '17';
num_initialization = '1000';
CBIG_MSHBM_generate_ini_params('fs_LR_900','fs_LR_32k',num_clusters,num_initialization, project_dir)


### average profiles with half the training set

project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/generate_profiles_and_ini_params_half';

# generate averaged profiles across all DBIS test re-test
num_sub = '10';
num_sess = '2';
CBIG_MSHBM_avg_profiles('fs_LR_900','fs_LR_32k',project_dir,num_sub,num_sess);


# apply yeo2011 clustering algorithm
num_clusters = '17';
num_initialization = '1000';
CBIG_MSHBM_generate_ini_params('fs_LR_900','fs_LR_32k',num_clusters,num_initialization, project_dir)



##################################################
######## step 2 - group priors estimation ########
##################################################

project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/estimate_group_priors';
Params = CBIG_MSHBM_estimate_group_priors(project_dir,'fs_LR_32k','20','2','17','max_iter','');

# # while I'm waiting to get the HCP data to train spatial and smoothness priors, im gonna
# # give it a try with split half-ing the DBIS test retest data.
# 
# # low_high = participants 1-10 predicting 11-20, high_low is the reverse
# 
# project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/low_high/estimate_group_priors';
# addpath(genpath('/cifs/hariri-long/Projects/ethan/CBIG-master'));
# Params = CBIG_MSHBM_estimate_group_priors(project_dir,'fs_LR_32k','10','2','17','max_iter','10');
# 
# # high_low
# 
# project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/high_low/estimate_group_priors';
# addpath(genpath('/cifs/hariri-long/Projects/ethan/CBIG-master'));
# Params = CBIG_MSHBM_estimate_group_priors(project_dir,'fs_LR_32k','10','2','17','max_iter','10');

# # 668
# 
# project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/668/estimate_group_priors';
# addpath(genpath('/cifs/hariri-long/Projects/ethan/CBIG-master'));
# Params = CBIG_MSHBM_estimate_group_priors(project_dir,'fs_LR_32k','6','2','17','max_iter','6');

# generating group priorts from DBIS

# TIME 1
project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/hcp_trained/estimate_group_priors';
addpath(genpath('/cifs/hariri-long/Projects/ethan/CBIG-master'));
Params = CBIG_MSHBM_estimate_group_priors(project_dir,'fs_LR_32k','18','2','17');

# TIME 2
project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/hcp_trained/estimate_group_priors_sess2';
addpath(genpath('/cifs/hariri-long/Projects/ethan/CBIG-master'));
Params = CBIG_MSHBM_estimate_group_priors(project_dir,'fs_LR_32k','18','2','17');

### using both DBIS session to generate priors

project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/estimate_group_priors';
addpath(genpath('/cifs/hariri-long/Projects/ethan/CBIG-master'));
Params = CBIG_MSHBM_estimate_group_priors(project_dir,'fs_LR_32k','19','2','17');

## using half the training set

project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/estimate_group_priors_half';
addpath(genpath('/cifs/hariri-long/Projects/ethan/CBIG-master'));
Params = CBIG_MSHBM_estimate_group_priors(project_dir,'fs_LR_32k','10','2','17');


### using all DBIS participants



###################################################
###### step 3 individual-level parcellation #######
###################################################

# STEP 3.1 - GENERATE INDIVIDUAL PARCELLATIONS USING HCP PRIORS

project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/generate_individual_parcellations_hcp';

# do a grid search for w (weight of group spatial prior) and c (weight of MRF smoothness prior)
w_set = [60 80 100 120];
c_set = [30 40 50 60];
for i = 1:length(w_set)
    for j = 1:length(c_set)
        for sub = 1:20
		    homo_with_weight(sub,:) = CBIG_MSHBM_parameters_validation(project_dir,'fs_LR_32k','2','17',num2str(sub), num2str(w_set(i)),num2str(c_set(j)));
        end
        homo(i,j) = mean(mean(homo_with_weight));
    end
end

# for the HCP data, c = 40 and w = 200 according to the kong 2019 supplement

# generate individual parcellation for all subjects
# (find a way to loop through this):

[lh_labels1, rh_labels1] = CBIG_MSHBM_generate_individual_parcellation(project_dir,'fs_LR_32k','2','17','1','100','50');

[lh_labels2, rh_labels2] = CBIG_MSHBM_generate_individual_parcellation(project_dir,'fs_LR_32k','2','17','2','100','50');



## TRAINING MSHBM ON JUST DBIS 5V5

# # low_high
# project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/low_high/generate_individual_parcellations';
# 
# # do a grid search for w (weight of group spatial prior) and c (weight of MRF smoothness prior)
# w_set = [60 80 100 120];
# c_set = [30 40 50 60];
# for i = 1:length(w_set)
#     for j = 1:length(c_set)
#         for sub = 1:10
# 		    homo_with_weight(sub,:) = CBIG_MSHBM_parameters_validation(project_dir,'fs_LR_32k','2','17',num2str(sub), num2str(w_set(i)),num2str(c_set(j)));
#         end
#         homo(i,j) = mean(mean(homo_with_weight));
#     end
# end
# 
# # high_low
# 
# project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/high_low/generate_individual_parcellations';
# 
# # do a grid search for w (weight of group spatial prior) and c (weight of MRF smoothness prior)
# w_set = [60 80 100 120];
# c_set = [30 40 50 60];
# for i = 1:length(w_set)
#     for j = 1:length(c_set)
#         for sub = 1:10
# 		    homo_with_weight(sub,:) = CBIG_MSHBM_parameters_validation(project_dir,'fs_LR_32k','2','17',num2str(sub), num2str(w_set(i)),num2str(c_set(j)));
#         end
#         homo(i,j) = mean(mean(homo_with_weight));
#     end
# end

# # 668
# 
# project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/668/generate_individual_parcellations';
# 
# # VALIDATION SET
# # do a grid search for w (weight of group spatial prior) and c (weight of MRF smoothness prior)
# w_set = [60 80 100 120];
# c_set = [30 40 50 60];
# for i = 1:length(w_set)
#     for j = 1:length(c_set)
#         for sub = 1:6
# 		    homo_with_weight(sub,:) = CBIG_MSHBM_parameters_validation(project_dir,'fs_LR_32k','2','17',num2str(sub), num2str(w_set(i)),num2str(c_set(j)));
#         end
#         homo(i,j) = mean(mean(homo_with_weight));
#     end
# end
# 
# # average homo_with_weights across people because matlab session expires
# cd /cifs/hariri-long/Projects/ethan/mshbm/test_retest/668/generate_individual_parcellations/homogeneity/validation_set
# homo_array=zeros(4, 4, 6);
# homo_matrix=zeros(4,4);
# w_set = [60 80 100 120];
# c_set = [30 40 50 60];
# for i = 1:length(w_set)
#     for j = 1:length(c_set)
#         for sub = 1:6
#             temp = load(['Ind_homogeneity_MSHBM_sub' num2str(sub) '_w' num2str(w_set(i)) '_MRF' num2str(c_set(j)) '.mat']);
# 		    homo_array(i,j,sub) = temp.homo_with_weight;
#         end
#     end
# end

# homo_matrix=mean(homo_array,3);
# maximum = max(max(homo_matrix));
# [row,column]=find(homo_matrix==maximum);

# TEST SET

# SESSION 1

# generate individual parcellation for test subjects

project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/668/generate_individual_parcellations';
#modify according to previous step
w=60;
c=30;
for subid = 1:8
	CBIG_MSHBM_generate_individual_parcellation(project_dir, 'fs_LR_32k','1','17', num2str(subid), w, c);
end

CBIG_MSHBM_generate_individual_parcellation(project_dir, 'fs_LR_32k','1','17', '1', w, c);

# SESSION 2

# generate individual parcellation for test subjects

project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/668/generate_individual_parcellations_sess2';
#modify according to previous step
w=60;
c=30;
for subid = 1:8
	CBIG_MSHBM_generate_individual_parcellation(project_dir, 'fs_LR_32k','1','17', num2str(subid), w, c);
end

CBIG_MSHBM_generate_individual_parcellation(project_dir, 'fs_LR_32k','1','17', '1', w, c);


# generate individualized profiles for 19 DBIS test retest participants using HCP prior statistics pulled straight from 
# kong 2019 paper

addpath(genpath('/cifs/hariri-long/Projects/ethan/CBIG-master'));
project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/hcp_trained/generate_individual_parcellations';
#modify according to previous step
w=200;
c=40;
for subid = 1:19
	CBIG_MSHBM_generate_individual_parcellation(project_dir, 'fs_LR_32k','2','17', num2str(subid), '200', '40');
end

CBIG_MSHBM_generate_individual_parcellation(project_dir, 'fs_LR_32k','2','17', '1', '200', '40', 'test_set');

# SESSION 2

project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/hcp_trained/generate_individual_parcellations_sess2';
#modify according to previous step
w=200;
c=40;
for subid = 1:19
	CBIG_MSHBM_generate_individual_parcellation(project_dir, 'fs_LR_32k','2','17', num2str(subid), '200', '40');
end


# using the 19 DBIS as test set gets stalled before lambda cannot converge (10/21) so i am going to treat them as
# validation to see if that runs


# TIME POINT 1
project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/hcp_trained/generate_individual_parcellations';

# do a grid search for w (weight of group spatial prior) and c (weight of MRF smoothness prior)
w_set = [140 160 180 200];
c_set = [20 30 40 50];
for i = 1:length(w_set)
    for j = 1:length(c_set)
        for sub = 8:19
		    homo_with_weight(sub,:) = CBIG_MSHBM_parameters_validation(project_dir,'fs_LR_32k','2','17', num2str(sub), num2str(w_set(i)),num2str(c_set(j)));
        end
        homo(i,j) = mean(mean(homo_with_weight));
    end
end

homo_matrix=mean(homo_array,3);
maximum = max(max(homo_matrix));
[row,column]=find(homo_matrix==maximum);

# testing modified script
homo_with_weight(sub,:) = CBIG_MSHBM_parameters_validation(project_dir,'fs_LR_32k','2','17', '1', '200', '40');

# TIME POINT 2

project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/hcp_trained/generate_individual_parcellations_sess2';

# do a grid search for w (weight of group spatial prior) and c (weight of MRF smoothness prior)
w_set = [140 160 180 200];
c_set = [20 30 40 50];
for i = 1:length(w_set)
    for j = 1:length(c_set)
        for sub = 1:18
		    homo_with_weight(sub,:) = CBIG_MSHBM_parameters_validation(project_dir,'fs_LR_32k','2','17', num2str(sub), num2str(w_set(i)),num2str(c_set(j)));
        end
        homo(i,j) = mean(mean(homo_with_weight));
    end
end



## doing a much wider grid search to optimize homogeneity

# TIME POINT 1
addpath(genpath('/cifs/hariri-long/Projects/ethan/CBIG-master'));
project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/hcp_trained/generate_individual_parcellations';

# do a grid search for w (weight of group spatial prior) and c (weight of MRF smoothness prior)
w_set = [80 90 100 110 120 130 140 160 180 200 210 220 230];
c_set = [10 20 30 40 50 60 70 80 90 100];
for i = 1:length(w_set)
    for j = 1:length(c_set)
        for sub = 1:18
		    homo_with_weight(sub,:) = CBIG_MSHBM_parameters_validation(project_dir,'fs_LR_32k','2','17', num2str(sub), num2str(w_set(i)),num2str(c_set(j)));
        end
        homo(i,j) = mean(mean(homo_with_weight));
    end
end


### grid search using DBIS priors on DBIS scans

# TIME POINT 1
project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/hcp_trained/generate_individual_parcellations_dbis1';

# do a grid search for w (weight of group spatial prior) and c (weight of MRF smoothness prior)
w_set = [140 160 180 200];
c_set = [20 30 40 50];
for i = 1:length(w_set)
    for j = 1:length(c_set)
        for sub = 1:18
		    homo_with_weight(sub,:) = CBIG_MSHBM_parameters_validation(project_dir,'fs_LR_32k','2','17', num2str(sub), num2str(w_set(i)),num2str(c_set(j)));
        end
        homo(i,j) = mean(mean(homo_with_weight));
    end
end

# TIME POINT 2
project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/hcp_trained/generate_individual_parcellations_dbis2';

# do a grid search for w (weight of group spatial prior) and c (weight of MRF smoothness prior)
w_set = [140 160 180 200];
c_set = [20 30 40 50];
for i = 1:length(w_set)
    for j = 1:length(c_set)
        for sub = 1:18
		    homo_with_weight(sub,:) = CBIG_MSHBM_parameters_validation(project_dir,'fs_LR_32k','2','17', num2str(sub), num2str(w_set(i)),num2str(c_set(j)));
        end
        homo(i,j) = mean(mean(homo_with_weight));
    end
end



#### using both DBIS sessions to generate priors

# BOTH TIME POINTS
project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/generate_individual_parcellations';

# do a grid search for w (weight of group spatial prior) and c (weight of MRF smoothness prior)
w_set = [140 160 180 200];
c_set = [20 30 40 50];
for i = 1:length(w_set)
    for j = 1:length(c_set)
        for sub = 1:19
		    homo_with_weight(sub,:) = CBIG_MSHBM_parameters_validation(project_dir,'fs_LR_32k','2','17', num2str(sub), num2str(w_set(i)),num2str(c_set(j)));
        end
        homo(i,j) = mean(mean(homo_with_weight));
    end
end



# TIME POINT 1
project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/generate_individual_parcellations_time1';

# do a grid search for w (weight of group spatial prior) and c (weight of MRF smoothness prior)
w_set = [140];
c_set = [30];
for i = 1:length(w_set)
    for j = 1:length(c_set)
        for sub = 16:19
		    homo_with_weight(sub,:) = CBIG_MSHBM_parameters_validation(project_dir,'fs_LR_32k','1','17', num2str(sub), num2str(w_set(i)),num2str(c_set(j)));
        end
        homo(i,j) = mean(mean(homo_with_weight));
    end
end

# TIME POINT 2
project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/generate_individual_parcellations_time2';

# do a grid search for w (weight of group spatial prior) and c (weight of MRF smoothness prior)
w_set = [140 160 180 200];
c_set = [20 30 40 50];
for i = 1:length(w_set)
    for j = 1:length(c_set)
        for sub = 1:19
		    homo_with_weight(sub,:) = CBIG_MSHBM_parameters_validation(project_dir,'fs_LR_32k','1','17', num2str(sub), num2str(w_set(i)),num2str(c_set(j)));
        end
        homo(i,j) = mean(mean(homo_with_weight));
    end
end



### using half the DBIS scans for priors


# TIME POINT 1
project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/generate_individual_parcellations_half';

# do a grid search for w (weight of group spatial prior) and c (weight of MRF smoothness prior)
w_set = [200];
c_set = [50];
for i = 1:length(w_set)
    for j = 1:length(c_set)
        for sub = 9
		    homo_with_weight(sub,:) = CBIG_MSHBM_parameters_validation(project_dir,'fs_LR_32k','1','17', num2str(sub), num2str(w_set(i)),num2str(c_set(j)));
        end
        homo(i,j) = mean(mean(homo_with_weight));
    end
end

### time 1 missing 2

# TIME POINT 2
project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/test_retest/generate_individual_parcellations_half2';

# do a grid search for w (weight of group spatial prior) and c (weight of MRF smoothness prior)
w_set = [140 160 180 200];
c_set = [20 30 40 50];
for i = 1:length(w_set)
    for j = 1:length(c_set)
        for sub = 5
		    homo_with_weight(sub,:) = CBIG_MSHBM_parameters_validation(project_dir,'fs_LR_32k','1','17', num2str(sub), num2str(w_set(i)),num2str(c_set(j)));
        end
        homo(i,j) = mean(mean(homo_with_weight));
    end
end

# time 2 missing 5

###################################################
###### step 4 - calculate ICCs for eight ppl ######
###################################################



