#!/bin/bash
# generate test retest data from random samplings of 200 DBIS participants to derive priors
# method adapted from 2020 Cui Neuron paper

# group-level profile

addpath(genpath('/cifs/hariri-long/Projects/ethan/CBIG-master'));
project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/generate_profiles_and_ini_params_762';
num_sub = '762';
num_sess = '2';
CBIG_MSHBM_avg_profiles('fs_LR_900','fs_LR_32k',project_dir,num_sub,num_sess);

sbatch -p scavenger /cifs/hariri-long/Projects/ethan/mshbm/scripts/run_avg_profile.sh


# group-level ini params

# apply yeo2011 clustering algorithm
num_clusters = '17';
# num_clusters = '7';
num_initialization = '1000';
CBIG_MSHBM_generate_ini_params('fs_LR_900','fs_LR_32k',num_clusters,num_initialization, project_dir)

sbatch -p scavenger /cifs/hariri-long/Projects/ethan/mshbm/scripts/run_ini_params.sh


# apply yeo2011 clustering algorithm
addpath(genpath('/cifs/hariri-long/Projects/ethan/CBIG-master'));
project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/generate_profiles_and_ini_params_7n_762';
num_clusters = '7';
num_initialization = '1000';
CBIG_MSHBM_generate_ini_params('fs_LR_900','fs_LR_32k',num_clusters,num_initialization, project_dir)

sbatch -p scavenger /cifs/hariri-long/Projects/ethan/mshbm/scripts/run_ini_params_7.sh


# ESTIMATING GROUP PRIORS

# batch priors

## make random sets of 200 DBIS participants
for s in {1..50} ; do
    entries=($(shuf -i 0-762 -n 200 | sort -n))
    echo "${entries[@]}" > index
    tr -s ' '  '\n' < index > index_col
    while read -a field; do
        j=${field[0]}
        cat gid_dbis_762 | sed -n "${j}p" >> gids/gid_dbis_${s}
    done < index_col
    rm index_col
    rm index
done

for i in {1..50} ; do
    mkdir /cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/generate_profiles_and_ini_params_${i}/
    mkdir /cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/generate_profiles_and_ini_params_${i}/profiles/
    mkdir /cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/estimate_group_priors_${i}
    mkdir /cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/estimate_group_priors_${i}/priors/
    mkdir /cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/estimate_group_priors_${i}/group/
    mkdir /cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/estimate_group_priors_${i}/profile_list
    x=1
    while read -a field; do
    sid=${field[0]}
        temp_ind=$(awk "/${sid}/{print NR}" /cifs/hariri-long/Projects/ethan/mshbm/gid_dbis_762)
        cp -r /cifs/hariri-long/Projects/ethan/mshbm/generate_profiles_and_ini_params_762/profiles/sub${temp_ind} /cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/generate_profiles_and_ini_params_${i}/profiles/
        mv /cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/generate_profiles_and_ini_params_${i}/profiles/sub${temp_ind} /cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/generate_profiles_and_ini_params_${i}/profiles/sub${x}
        mv /cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/generate_profiles_and_ini_params_${i}/profiles/sub${x}/sess1/sub${temp_ind}_sess1_fs_LR_32k_roifs_LR_900.surf2surf_profile.mat /cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/generate_profiles_and_ini_params_${i}/profiles/sub${x}/sess1/sub${x}_sess1_fs_LR_32k_roifs_LR_900.surf2surf_profile.mat
        mv /cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/generate_profiles_and_ini_params_${i}/profiles/sub${x}/sess2/sub${temp_ind}_sess2_fs_LR_32k_roifs_LR_900.surf2surf_profile.mat /cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/generate_profiles_and_ini_params_${i}/profiles/sub${x}/sess2/sub${x}_sess2_fs_LR_32k_roifs_LR_900.surf2surf_profile.mat
        x=$((x+1))
    done < /cifs/hariri-long/Projects/ethan/mshbm/gids/gid_dbis_${i}
    cp /cifs/hariri-long/Projects/ethan/mshbm/generate_profiles_and_ini_params_762/group/group.mat /cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/estimate_group_priors_${i}/group/
done

# write out each profile list

for i in {1..50} ; do
    mkdir /cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/estimate_group_priors_${i}/profile_list/training_set/
    for s in {1..200} ; do
    echo "/cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/generate_profiles_and_ini_params_${i}/profiles/sub${s}/sess1/sub${s}_sess1_fs_LR_32k_roifs_LR_900.surf2surf_profile.mat" >> /cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/estimate_group_priors_${i}/profile_list/training_set/sess1.txt
    echo "/cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/generate_profiles_and_ini_params_${i}/profiles/sub${s}/sess2/sub${s}_sess2_fs_LR_32k_roifs_LR_900.surf2surf_profile.mat" >> /cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/estimate_group_priors_${i}/profile_list/training_set/sess2.txt
    done
done

# write 50 .m functions for each bootstrap iteration

for i in {1..50} ; do
    echo "addpath(genpath('/cifs/hariri-long/Projects/ethan/CBIG-master'));" > /cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/deploy_group_priors_${i}.m
    echo "project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/estimate_group_priors_${i}';" >> /cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/deploy_group_priors_${i}.m
    echo "Params = CBIG_MSHBM_estimate_group_priors(project_dir,'fs_LR_32k','200','2','17');" >> /cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/deploy_group_priors_${i}.m
done

# for s in {1..50} ; do sbatch -p scavenger /cifs/hariri-long/Projects/ethan/mshbm/scripts/run_group_bootstrap_762.sh $s; done

# initialization
All_Params.all_epsil = zeros(50, 17);
All_Params.all_mu = zeros(1483, 17, 50);
All_Params.all_sigma = zeros(50, 17);
All_Params.all_theta = zeros(64984, 17, 50);

for iter = 1:50
    load(sprintf('/cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/estimate_group_priors_%d/priors/Params_Final.mat', iter));

    All_Params.all_epsil(iter,:) = Params.epsil;
    All_Params.all_mu(:,:,iter) = Params.mu;
    All_Params.all_sigma(iter,:) = Params.sigma;
    All_Params.all_theta(:,:,iter) = Params.theta;
end

% average across dimensions

Mean_Params.epsil=mean(All_Params.all_epsil, 1);
Mean_Params.mu=mean(All_Params.all_mu, 3);
Mean_Params.sigma=mean(All_Params.all_sigma, 1);
Mean_Params.theta=mean(All_Params.all_theta, 3);

Params=Mean_Params;
cd /cifs/hariri-long/Projects/ethan/mshbm/bootstrap_group/mean_priors
save('Params_Final.mat', 'Params')

# bootstrap priors
# TEST RETEST
# GENERATING INDIVIDUALIZED PROFILES - TIME 1

## writing profile lists for time 1

for s in {1..19} ; do
    echo "/cifs/hariri-long/Projects/ethan/mshbm/generate_profiles_and_ini_params_time1/profiles/sub${s}/sess1/sub${s}_sess1_fs_LR_32k_roifs_LR_900.surf2surf_profile.mat" >> /cifs/hariri-long/Projects/ethan/mshbm/generate_individual_parcellations_time1_bsp/profile_list/validation_set/sess1.txt
    echo "/cifs/hariri-long/Projects/ethan/mshbm/generate_profiles_and_ini_params_time1/profiles/sub${s}/sess2/sub${s}_sess2_fs_LR_32k_roifs_LR_900.surf2surf_profile.mat" >> /cifs/hariri-long/Projects/ethan/mshbm/generate_individual_parcellations_time1_bsp/profile_list/validation_set/sess2.txt
done

project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/generate_individual_parcellations_time1_bsp';
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

## writing profile lists for time 2

for s in {1..19} ; do
    echo "/cifs/hariri-long/Projects/ethan/mshbm/generate_profiles_and_ini_params_time2/profiles/sub${s}/sess1/sub${s}_sess1_fs_LR_32k_roifs_LR_900.surf2surf_profile.mat" >> /cifs/hariri-long/Projects/ethan/mshbm/generate_individual_parcellations_time2_bsp/profile_list/validation_set/sess1.txt
    echo "/cifs/hariri-long/Projects/ethan/mshbm/generate_profiles_and_ini_params_time2/profiles/sub${s}/sess2/sub${s}_sess2_fs_LR_32k_roifs_LR_900.surf2surf_profile.mat" >> /cifs/hariri-long/Projects/ethan/mshbm/generate_individual_parcellations_time2_bsp/profile_list/validation_set/sess2.txt
done

project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/generate_individual_parcellations_time2_bsp';
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


# individual parcellations - FULL SAMPLE

# write out profile list based on 762

for i in {1..762} ; do
    echo "/cifs/hariri-long/Projects/ethan/mshbm/generate_profiles_and_ini_params_762/profiles/sub${i}/sess1/sub${i}_sess1_fs_LR_32k_roifs_LR_900.surf2surf_profile.mat" >> /cifs/hariri-long/Projects/ethan/mshbm/generate_individual_parcellations_762/profile_list/validation_set/sess1.txt
    echo "/cifs/hariri-long/Projects/ethan/mshbm/generate_profiles_and_ini_params_762/profiles/sub${i}/sess2/sub${i}_sess2_fs_LR_32k_roifs_LR_900.surf2surf_profile.mat" >> /cifs/hariri-long/Projects/ethan/mshbm/generate_individual_parcellations_762/profile_list/validation_set/sess2.txt
done


for s in {1..762} ; do
    echo "addpath(genpath('/cifs/hariri-long/Projects/ethan/CBIG-master'));" > /cifs/hariri-long/Projects/ethan/mshbm/batch_deploy/deploy_ind_parc_${s}.m
    echo "project_dir = '/cifs/hariri-long/Projects/ethan/mshbm/generate_individual_parcellations_762';" >> /cifs/hariri-long/Projects/ethan/mshbm/batch_deploy/deploy_ind_parc_${s}.m
    echo "        for sub = 1;" >> /cifs/hariri-long/Projects/ethan/mshbm/batch_deploy/deploy_ind_parc_${s}.m
    echo "		    homo_with_weight(sub,:) = CBIG_MSHBM_parameters_validation(project_dir,'fs_LR_32k','2','17', '${s}', '200','40');" >> /cifs/hariri-long/Projects/ethan/mshbm/batch_deploy/deploy_ind_parc_${s}.m
    echo "        end" >> /cifs/hariri-long/Projects/ethan/mshbm/batch_deploy/deploy_ind_parc_${s}.m
done

# for s in {1..762} ; do sbatch -p scavenger /cifs/hariri-long/Projects/ethan/mshbm/scripts/run_batch_deploy.sh $s; done


# figuring out which participants didnt run

rm *.txt
ls > list.txt
sed -i -e 's/Ind_prop_parcellation_MSHBM_sub//' list.txt 
sed -i -e 's/_w200_MRF40.mat//' list.txt 
sort -n list.txt > sorted_list.txt

for i in {1..762} ; do
    temp=$(grep -w $i sorted_list.txt)
    if [ -z $temp ]
    then
    echo $i >> missing.txt
    else
    echo $i >> not_missing.txt
    fi
done

# run additional round

while read -a field; do 
s=${field[0]} 
sbatch -p scavenger /cifs/hariri-long/Projects/ethan/mshbm/scripts/run_batch_deploy.sh ${s} 
done < /cifs/hariri-long/Projects/ethan/mshbm/generate_individual_parcellations_762/homogeneity/validation_set/missing.txt



# calculate homogeneity using yeo template
s=1
while read -a field; do 
sid=${field[0]} 
    echo "/cifs/hariri-long/Studies/DBIS/Imaging/derivatives/HCP_MPP/${sid}/MNINonLinear/Results/GFC_GSR35/GFC_GSR35_FIR_Atlas.dtseries.nii" > /cifs/hariri-long/Projects/ethan/mshbm/generate_individual_parcellations_762/homogeneity/yeo/input_files/input_filename_${s}.txt
    s=$((s+1))
done < /cifs/hariri-long/Projects/ethan/mshbm/gid_dbis_762

for s in {1..762} ; do
    echo "cd /cifs/hariri-long/Projects/ethan/mshbm/generate_individual_parcellations_762/homogeneity/yeo/" > /cifs/hariri-long/Projects/ethan/mshbm/scripts/deploy_yeo_homo/deploy_yeo_homo_${s}.m
    echo "addpath(genpath('/cifs/hariri-long/Projects/ethan/CBIG-master'));" >> /cifs/hariri-long/Projects/ethan/mshbm/scripts/deploy_yeo_homo/deploy_yeo_homo_${s}.m
    echo "yeo17=cifti_read('/cifs/hariri-long/Projects/ethan/CBIG-master/stable_projects/brain_parcellation/Yeo2011_fcMRI_clustering/1000subjects_reference/Yeo_JNeurophysiol11_SplitLabels/fs_LR32k/Yeo2011_17Networks_N1000.dlabel.nii');" >> /cifs/hariri-long/Projects/ethan/mshbm/scripts/deploy_yeo_homo/deploy_yeo_homo_${s}.m
    echo "lh_labels_yeo17=yeo17.cdata(1:32492);" >> /cifs/hariri-long/Projects/ethan/mshbm/scripts/deploy_yeo_homo/deploy_yeo_homo_${s}.m
    echo "rh_labels_yeo17=yeo17.cdata(32493:64984);" >> /cifs/hariri-long/Projects/ethan/mshbm/scripts/deploy_yeo_homo/deploy_yeo_homo_${s}.m
    echo "input_filename='/cifs/hariri-long/Projects/ethan/mshbm/generate_individual_parcellations_762/homogeneity/yeo/input_files/input_filename_${s}.txt';" >> /cifs/hariri-long/Projects/ethan/mshbm/scripts/deploy_yeo_homo/deploy_yeo_homo_${s}.m
    echo "homo_with_weight_yeo17 = CBIG_ComputeParcellationHomogeneity_fslr(lh_labels_yeo17,rh_labels_yeo17,input_filename);" >> /cifs/hariri-long/Projects/ethan/mshbm/scripts/deploy_yeo_homo/deploy_yeo_homo_${s}.m
    echo "save('yeo_homo_${s}.mat', 'homo_with_weight_yeo17');" >> /cifs/hariri-long/Projects/ethan/mshbm/scripts/deploy_yeo_homo/deploy_yeo_homo_${s}.m
done

# for s in {1..762} ; do sbatch -p scavenger /cifs/hariri-long/Projects/ethan/mshbm/scripts/run_batch_yeo.sh $s; done


# figuring out which participants didnt run

rm *.txt
ls yeo* > list.txt
sed -i -e 's/yeo_homo_//' list.txt 
sed -i -e 's/.mat//' list.txt 
sort -n list.txt > sorted_list.txt

for i in {1..762} ; do
    temp=$(grep -w $i sorted_list.txt)
    if [ -z $temp ]
    then
    echo $i >> missing.txt
    else
    echo $i >> not_missing.txt
    fi
done

# rerun
while read -a field; do 
s=${field[0]} 
sbatch -p scavenger /cifs/hariri-long/Projects/ethan/mshbm/scripts/run_batch_yeo.sh ${s} 
done < /cifs/hariri-long/Projects/ethan/mshbm/generate_individual_parcellations_762/homogeneity/yeo/missing.txt



