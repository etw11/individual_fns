#!/bin/bash

# GENERATING INDIVIDUAL PROFILES FOR ALL PARTICIPANTS IN DBIS
addpath(genpath('/cifs/hariri-long/Projects/ethan/CBIG-master'));

# make profiles for DBIS test re-test
project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/generate_profiles_and_ini_params';
for sub = 1:765
	CBIG_MSHBM_generate_profiles('fs_LR_900','fs_LR_32k',project_dir,num2str(sub),'1','1');
end

sub=525;
CBIG_MSHBM_generate_profiles('fs_LR_900','fs_LR_32k',project_dir,num2str(sub),'1','1');


# test retest

# time1
for i in {1..19} ; do
	mv sub${i}.txt sub${i}_sess1.txt 
done

project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/generate_profiles_and_ini_params_time1';
for sub = 1:19
	CBIG_MSHBM_generate_profiles('fs_LR_900','fs_LR_32k',project_dir,num2str(sub),'1','1');
end

# rename profiles

for i in {1..19} ; do
	mkdir /cifs/hariri-long/Projects/ethan/mshbm/generate_profiles_and_ini_params_time1/profiles/sub${i}/sess2
	mv /cifs/hariri-long/Projects/ethan/mshbm/generate_profiles_and_ini_params_time1/profiles/sub${i}/sess1/sub${i}_sess1_fs_LR_32k_roifs_LR_900.surf2surf_profile_1.mat /cifs/hariri-long/Projects/ethan/mshbm/generate_profiles_and_ini_params_time1/profiles/sub${i}/sess1/sub${i}_sess1_fs_LR_32k_roifs_LR_900.surf2surf_profile.mat
	mv /cifs/hariri-long/Projects/ethan/mshbm/generate_profiles_and_ini_params_time1/profiles/sub${i}/sess1/sub${i}_sess1_fs_LR_32k_roifs_LR_900.surf2surf_profile_2.mat /cifs/hariri-long/Projects/ethan/mshbm/generate_profiles_and_ini_params_time1/profiles/sub${i}/sess2/sub${i}_sess2_fs_LR_32k_roifs_LR_900.surf2surf_profile.mat
done

# time 2
for i in {1..19} ; do
	mv sub${i}.txt sub${i}_sess1.txt 
done

project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/generate_profiles_and_ini_params_time2';
for sub = 1:19
	CBIG_MSHBM_generate_profiles('fs_LR_900','fs_LR_32k',project_dir,num2str(sub),'1','1');
end

# rename profiles

for i in {1..19} ; do
	mkdir /cifs/hariri-long/Projects/ethan/mshbm/generate_profiles_and_ini_params_time2/profiles/sub${i}/sess2
	mv /cifs/hariri-long/Projects/ethan/mshbm/generate_profiles_and_ini_params_time2/profiles/sub${i}/sess1/sub${i}_sess1_fs_LR_32k_roifs_LR_900.surf2surf_profile_1.mat /cifs/hariri-long/Projects/ethan/mshbm/generate_profiles_and_ini_params_time2/profiles/sub${i}/sess1/sub${i}_sess1_fs_LR_32k_roifs_LR_900.surf2surf_profile.mat
	mv /cifs/hariri-long/Projects/ethan/mshbm/generate_profiles_and_ini_params_time2/profiles/sub${i}/sess1/sub${i}_sess1_fs_LR_32k_roifs_LR_900.surf2surf_profile_2.mat /cifs/hariri-long/Projects/ethan/mshbm/generate_profiles_and_ini_params_time2/profiles/sub${i}/sess2/sub${i}_sess2_fs_LR_32k_roifs_LR_900.surf2surf_profile.mat
done

# generate averaged profiles across all DBIS test re-test
num_sub = '765';
num_sess = '2';
CBIG_MSHBM_avg_profiles('fs_LR_900','fs_LR_32k',project_dir,num_sub,num_sess);


# apply yeo2011 clustering algorithm
num_clusters = '17';
# num_clusters = '7';
num_initialization = '1000';
CBIG_MSHBM_generate_ini_params('fs_LR_900','fs_LR_32k',num_clusters,num_initialization, project_dir)

# sbatch -p scavenger /cifs/hariri-long/Projects/ethan/mshbm/run_seven_network.sh


# ESTIMATING GROUP PRIORS

diary on
project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/estimate_group_priors';
Params = CBIG_MSHBM_estimate_group_priors(project_dir,'fs_LR_32k','1','2','17');
diary off

#### test retest ####

# 200 PRIORS  
# GENERATING INDIVIDUALIZED PROFILES - TIME 1

project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/generate_individual_parcellations_time1_200';
w_set = [200];
c_set = [40];
for i = 1:length(w_set)
    for j = 1:length(c_set)
        for sub = 1:19
		    homo_with_weight(sub,:) = CBIG_MSHBM_parameters_validation(project_dir,'fs_LR_32k','2','17', num2str(sub), num2str(w_set(i)),num2str(c_set(j)));
        end
        homo(i,j) = mean(mean(homo_with_weight));
    end
end


# SESSION 2

project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/generate_individual_parcellations_time2_200';

#modify according to previous step

w_set = [200];
c_set = [40];
for i = 1:length(w_set)
    for j = 1:length(c_set)
        for sub = 1:19
		    homo_with_weight(sub,:) = CBIG_MSHBM_parameters_validation(project_dir,'fs_LR_32k','2','17', num2str(sub), num2str(w_set(i)),num2str(c_set(j)));
        end
        homo(i,j) = mean(mean(homo_with_weight));
    end
end



