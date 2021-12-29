#!/bin/bash
# test retest reliability using non-negative matrix factorization (NMF) in the 19 DBIS test retest
# 12/02/21

#initializing
addpath(genpath('/cifs/hariri-long/Projects/ethan/nmf/Collaborative_Brain_Decomposition-master'));

# step 0 - set up prep data file

clc;
clear;

addpath(genpath('/cifs/hariri-long/Projects/ethan/nmf/Collaborative_Brain_Decomposition-master'));

% % for volumetric data
% maskFile = 'path-to-mask-file/mask.nii.gz';
% maskNii = load_untouch_nii(maskFile);
% 
% gNb = createPrepData('volumetric', maskNii.img, 1);

surfNameL = '/cifs/hariri-long/Projects/ethan/CBIG-master/data/templates/surface/fs_LR_32k/fsaverage.L.inflated.32k_fs_LR.surf.gii';
surfNameR = '/cifs/hariri-long/Projects/ethan/CBIG-master/data/templates/surface/fs_LR_32k/fsaverage.R.inflated.32k_fs_LR.surf.gii';
surfMaskNameL = '/cifs/hariri-long/Projects/ethan/CBIG-master/data/templates/surface/fs_LR_32k/label/lh.medialwall.gii';
surfMaskNameR = '/cifs/hariri-long/Projects/ethan/CBIG-master/data/templates/surface/fs_LR_32k/label/rh.medialwall.gii';

% [surfStru, surfMask] = getFsSurf(surfL, surfR, surfML, surfMR);

[surfStru, surfMask] = getHcpSurf(surfNameL, surfNameR, surfMaskNameL, surfMaskNameR)

gNb = createPrepData('surface', surfStru, 1, surfMask);

% save gNb into file for later use
prepDataName = '/cifs/hariri-long/Projects/ethan/nmf/CreatePrepData.mat';
save(prepDataName, 'gNb');


# step 0.1 - make 50 random initialization datasets

cd /cifs/hariri-long/Projects/ethan/nmf

# generate a set of 50 random subsets of all DBIS participants

for s in {1..50} ; do
    entries=($(shuf -i 0-765 -n 100 | sort -n))
    echo "${entries[@]}" > index
    tr -s ' '  '\n' < index > index_col
    while read -a field; do
        j=${field[0]}
        cat gid_dbis_thresholded | sed -n "${j}p" >> gids_scaled_thresholded/gid_dbis_${s}
    done < index_col
    rm index_col
    rm index

    while read -a field; do
        sid=${field[0]}
        echo  "/cifs/hariri-long/Studies/DBIS/Imaging/derivatives/HCP_MPP/${sid}/MNINonLinear/Results/GFC_GSR35/GFC_GSR35_FIR_Atlas_LONG_SCALED.dtseries.nii" >> ./sbjListFile_long_thresholded_scaled_${s}.txt
    done < gids_scaled_thresholded/gid_dbis_${s}
done

# for s in {1..50} ; do
#     while read -a field; do
#         sid=${field[0]}
#         echo  "/cifs/hariri-long/Studies/DBIS/Imaging/derivatives/HCP_MPP/${sid}/MNINonLinear/Results/GFC_GSR35/GFC_GSR35_FIR_Atlas_SHORT_SCALED.dtseries.nii" >> ./sbjListFile_short_scaled_${s}.txt
#     done < gids_scaled/gid_dbis_${s}
# done

### current GFC files are different lengths, going to reduce them all to be the length of the shortest one - just to see

while read -a field; do
sid=${field[0]}

wb_command -file-information -only-number-of-maps /cifs/hariri-long/Studies/DBIS/Imaging/derivatives/HCP_MPP/${sid}/MNINonLinear/Results/GFC_GSR35/GFC_GSR35_FIR_Atlas_SHORT.dtseries.nii >> map_num_short.txt

done < gid_dbis

# min ncol = 701

# full sample
while read -a field; do
sid=${field[0]}

wb_command -cifti-merge /cifs/hariri-long/Studies/DBIS/Imaging/derivatives/HCP_MPP/${sid}/MNINonLinear/Results/GFC_GSR35/GFC_GSR35_FIR_Atlas_SHORT.dtseries.nii -cifti /cifs/hariri-long/Studies/DBIS/Imaging/derivatives/HCP_MPP/${sid}/MNINonLinear/Results/GFC_GSR35/GFC_GSR35_FIR_Atlas.dtseries.nii -column 1 -up-to 701

done < gid_dbis

# re-test subjects
while read -a field; do
sid=${field[0]}

wb_command -cifti-merge /cifs/hariri-long/Studies/DBIS/Imaging/derivatives/HCP_MPP/${sid}/MNINonLinear/Results/GFC_GSR35/GFC_GSR35_FIR_Atlas_SHORT.dtseries.nii -cifti /cifs/hariri-long/Studies/DBIS/Imaging/derivatives/HCP_MPP/${sid}/MNINonLinear/Results/GFC_GSR35/GFC_GSR35_FIR_Atlas.dtseries.nii -column 1 -up-to 701

done < gid_19_t2

## sorting to find the 591st longest timeseries which should hypothetically be the threshold that Max and Annchen used in the GFC paper

sort -nr map_num.txt > timeseries_sorted.txt
sed '591q;d' timeseries_sorted.txt

# 951 should be the motion threshold

# create gid with timeseries length

paste map_num.txt gid_dbis | column -s $'\t' -t > gid_dbis_timeseries

sort -nr gid_dbis_timeseries > gid_dbis_timeseries_sorted
sed -n -e '1,591p' gid_dbis_timeseries_sorted > gid_dbis_timeseries_thresholded
cat gid_dbis_timeseries_thresholded | awk '{ print $2 }' > gid_dbis_thresholded_sorted
sort gid_dbis_thresholded_sorted > gid_dbis_thresholded


while read -a field; do
sid=${field[0]}

echo "*** shortening ${sid} ***"
wb_command -cifti-merge /cifs/hariri-long/Studies/DBIS/Imaging/derivatives/HCP_MPP/${sid}/MNINonLinear/Results/GFC_GSR35/GFC_GSR35_FIR_Atlas_LONG.dtseries.nii -cifti /cifs/hariri-long/Studies/DBIS/Imaging/derivatives/HCP_MPP/${sid}/MNINonLinear/Results/GFC_GSR35/GFC_GSR35_FIR_Atlas.dtseries.nii -column 1 -up-to 951

done < gid_dbis_thresholded

while read -a field; do
sid=${field[0]}

echo "*** shortening ${sid} ***"
wb_command -cifti-merge /cifs/hariri-long/Studies/DBIS/Imaging/derivatives/HCP_MPP/${sid}/MNINonLinear/Results/GFC_GSR35/GFC_GSR35_FIR_Atlas_LONG.dtseries.nii -cifti /cifs/hariri-long/Studies/DBIS/Imaging/derivatives/HCP_MPP/${sid}/MNINonLinear/Results/GFC_GSR35/GFC_GSR35_FIR_Atlas.dtseries.nii -column 1 -up-to 951

done < gid_19_t2

### reshift and rescale

cat gid_dbis_thresholded > gid_dbis_thresholded_with_19
cat gid_19_t2 >> gid_dbis_thresholded_with_19

while read -a field; do
sid=${field[0]}
echo "/cifs/hariri-long/Studies/DBIS/Imaging/derivatives/HCP_MPP/${sid}/" >> directory_thresholded_list_plus19.txt
done < gid_dbis_thresholded_with_19


# wrote this in an R script called shift_rescale.R. pretty sure I put it on the cluster.

srun -p scavenger --mem=128G --cpus-per-task=32 --pty bash -i 
cd /cifs/hariri-long/Projects/ethan/nmf
module unload R
module load R/3.6.0
# R CMD BATCH /cifs/hariri-long/Projects/ethan/nmf/shift_rescale.R
R CMD BATCH /cifs/hariri-long/Projects/ethan/nmf/shift_rescale_thresholded_19.R


# step 1 - initialization (group decomposition)

# write separate .m files for each iteration
for s in {1..50} ; do
    echo "addpath(genpath('/cifs/hariri-long/Projects/ethan/nmf/Collaborative_Brain_Decomposition-master'));" >> deploy_func_init_scaled_thresholded_${s}.m

    echo "sbjListFile = '/cifs/hariri-long/Projects/ethan/nmf/sbjListFile_long_thresholded_scaled_${s}.txt';" >> deploy_func_init_scaled_thresholded_${s}.m
    echo "wbPath = '/cifs/hariri-long/Scripts/Tools/workbench/v1.4.2/bin_rh_linux64/wb_command';" >> deploy_func_init_scaled_thresholded_${s}.m
    echo "surfL = '/cifs/hariri-long/Projects/ethan/CBIG-master/data/templates/surface/fs_LR_32k/fsaverage.L.inflated.32k_fs_LR.surf.gii';" >> deploy_func_init_scaled_thresholded_${s}.m
    echo "surfR = '/cifs/hariri-long/Projects/ethan/CBIG-master/data/templates/surface/fs_LR_32k/fsaverage.R.inflated.32k_fs_LR.surf.gii';" >> deploy_func_init_scaled_thresholded_${s}.m
    echo "surfML = '/cifs/hariri-long/Projects/ethan/CBIG-master/data/templates/surface/fs_LR_32k/label/lh.medialwall.gii';" >> deploy_func_init_scaled_thresholded_${s}.m
    echo "surfMR = '/cifs/hariri-long/Projects/ethan/CBIG-master/data/templates/surface/fs_LR_32k/label/rh.medialwall.gii';" >> deploy_func_init_scaled_thresholded_${s}.m
    echo "prepDataFile = '/cifs/hariri-long/Projects/ethan/nmf/CreatePrepData.mat';" >> deploy_func_init_scaled_thresholded_${s}.m
    echo "outDir = '/cifs/hariri-long/Projects/ethan/nmf/out_100_scaled_thresholded';" >> deploy_func_init_scaled_thresholded_${s}.m
    echo "spaR = '1';" >> deploy_func_init_scaled_thresholded_${s}.m
    echo "vxI = '0';" >> deploy_func_init_scaled_thresholded_${s}.m
    echo "ard = '0';" >> deploy_func_init_scaled_thresholded_${s}.m
    echo "iterNum = '1000';" >> deploy_func_init_scaled_thresholded_${s}.m
    echo "K = '17';" >> deploy_func_init_scaled_thresholded_${s}.m
    echo "tNum = '951';" >> deploy_func_init_scaled_thresholded_${s}.m
    echo "alpha = '1';" >> deploy_func_init_scaled_thresholded_${s}.m
    echo "beta = '10';" >> deploy_func_init_scaled_thresholded_${s}.m
    echo "resId = 'out100_scaled_thresholded_${s}';" >> deploy_func_init_scaled_thresholded_${s}.m

    echo "deployFuncInit_surf_hcp(sbjListFile,wbPath,surfL,surfR,surfML,surfMR,prepDataFile,outDir,spaR,vxI,ard,iterNum,K,tNum,alpha,beta,resId)" >> deploy_func_init_scaled_thresholded_${s}.m
done

### SET UP BATCH JOB AND RAN THE FOLLOWING COMMAND
# for s in {1..50} ; do sbatch -p scavenger $H/Projects/ethan/nmf/run_nmf_init.sh $s; done
# for s in {1..50} ; do sbatch -p scavenger $H/Projects/ethan/nmf/run_nmf_init_scaled.sh $s; done
# for s in {1..50} ; do sbatch -p scavenger $H/Projects/ethan/nmf/run_nmf_init_scaled_thresholded.sh $s; done

# Multiple runs of initialization are recommended, using different subsets of subjects, 
# to generate one robust initialization by step 2. (A script will be needed to get a robust
# initialization by running this step several times)

# in the Neuron paper, they repeated initializations 50 times on a random subsample of 100 
# participants each time





# step 2 - robust initialization selection 

## make fileList of all out_100 init.mat files

# cd /cifs/hariri-long/Projects/ethan/nmf/out_100
# for d in */ ; do
#     echo "/cifs/hariri-long/Projects/ethan/nmf/out_100/${d}init.mat" >> ../init_out_list.txt
# done

cd /cifs/hariri-long/Projects/ethan/nmf/out_100_scaled_thresholded
for d in */ ; do
    echo "/cifs/hariri-long/Projects/ethan/nmf/out_100_scaled_thresholded/${d}init.mat" >> ../init_out_scaled_thresholded_list.txt
done

addpath(genpath('/cifs/hariri-long/Projects/ethan/nmf/Collaborative_Brain_Decomposition-master'));

fileList = '/cifs/hariri-long/Projects/ethan/nmf/init_out_scaled_thresholded_list.txt';
K = 17;
outDir = '/cifs/hariri-long/Projects/ethan/nmf/step2_init_selection_scaled_thresholded';

selRobustInit(fileList,K,outDir)





# step 3.1 - decomposition - TIME 1

# make sbjListFile for 19 test re-test at time 1

# while read -a field; do
#         sid=${field[0]}
#         echo  "/cifs/hariri-long/Studies/DBIS/Imaging/derivatives/HCP_MPP/${sid}/MNINonLinear/Results/GFC_GSR35/GFC_GSR35_FIR_Atlas_SHORT.dtseries.nii" >> ./sbjListFile_short_19_t1.txt
# done < gid_19_t1

# while read -a field; do
#         sid=${field[0]}
#         echo  "/cifs/hariri-long/Studies/DBIS/Imaging/derivatives/HCP_MPP/${sid}/MNINonLinear/Results/GFC_GSR35/GFC_GSR35_FIR_Atlas_SHORT_SCALED.dtseries.nii" >> ./sbjListFile_short_scaled_19_t1.txt
# done < gid_19_t1

while read -a field; do
        sid=${field[0]}
        echo  "/cifs/hariri-long/Studies/DBIS/Imaging/derivatives/HCP_MPP/${sid}/MNINonLinear/Results/GFC_GSR35/GFC_GSR35_FIR_Atlas_LONG_SCALED.dtseries.nii" >> ./sbjListFile_short_scaled_thresholded_19_t1.txt
done < gid_19_t1

addpath(genpath('/cifs/hariri-long/Projects/ethan/nmf/Collaborative_Brain_Decomposition-master'));

sbjListFile = '/cifs/hariri-long/Projects/ethan/nmf/sbjListFile_short_scaled_thresholded_19_t1.txt';
wbPath = '/cifs/hariri-long/Scripts/Tools/workbench/v1.4.2/bin_rh_linux64/wb_command';
prepDataFile = '/cifs/hariri-long/Projects/ethan/nmf/CreatePrepData.mat';
outDir = '/cifs/hariri-long/Projects/ethan/nmf/out_100_decomp_scaled_thresholded_t1';
resId = 'time1';
initName = '/cifs/hariri-long/Projects/ethan/nmf/step2_init_selection_scaled_thresholded/init.mat';
K = 17;
alphaS21 = 2;
alphaL = 10;
vxI = 0;
spaR = 1;
ard = 1;
eta = 1;
iterNum = 30;
calcGrp = 1;
parforOn = 0;


deployFuncMvnmfL21p1_func_surf_hcp(sbjListFile,wbPath,prepDataFile,outDir,resId,initName,K,alphaS21,alphaL,vxI,spaR,ard,eta,iterNum,calcGrp,parforOn)


# step 3.2 - decomposition - TIME 2

# while read -a field; do
#         sid=${field[0]}
#         echo  "/cifs/hariri-long/Studies/DBIS/Imaging/derivatives/HCP_MPP/${sid}/MNINonLinear/Results/GFC_GSR35/GFC_GSR35_FIR_Atlas_SHORT.dtseries.nii" >> ./sbjListFile_short_19_t2.txt
# done < gid_19_t2

# while read -a field; do
#         sid=${field[0]}
#         echo  "/cifs/hariri-long/Studies/DBIS/Imaging/derivatives/HCP_MPP/${sid}/MNINonLinear/Results/GFC_GSR35/GFC_GSR35_FIR_Atlas_SHORT_SCALED.dtseries.nii" >> ./sbjListFile_short_scaled_19_t2.txt
# done < gid_19_t2

while read -a field; do
        sid=${field[0]}
        echo  "/cifs/hariri-long/Studies/DBIS/Imaging/derivatives/HCP_MPP/${sid}/MNINonLinear/Results/GFC_GSR35/GFC_GSR35_FIR_Atlas_LONG_SCALED.dtseries.nii" >> ./sbjListFile_short_scaled_thresholded_19_t2.txt
done < gid_19_t2

addpath(genpath('/cifs/hariri-long/Projects/ethan/nmf/Collaborative_Brain_Decomposition-master'));

sbjListFile = '/cifs/hariri-long/Projects/ethan/nmf/sbjListFile_short_scaled_thresholded_19_t2.txt';
wbPath = '/cifs/hariri-long/Scripts/Tools/workbench/v1.4.2/bin_rh_linux64/wb_command';
prepDataFile = '/cifs/hariri-long/Projects/ethan/nmf/CreatePrepData.mat';
outDir = '/cifs/hariri-long/Projects/ethan/nmf/out_100_decomp_scaled_thresholded_t2';
resId = 'time2';
initName = '/cifs/hariri-long/Projects/ethan/nmf/step2_init_selection_scaled_thresholded/init.mat';
K = 17;
alphaS21 = 2;
alphaL = 10;
vxI = 0;
spaR = 1;
ard = 1;
eta = 1;
iterNum = 30;
calcGrp = 1;
parforOn = 0;

deployFuncMvnmfL21p1_func_surf_hcp(sbjListFile,wbPath,prepDataFile,outDir,resId,initName,K,alphaS21,alphaL,vxI,spaR,ard,eta,iterNum,calcGrp,parforOn)


# step 4 convert results to .nii files




# resFileName = '/cifs/hariri-long/Projects/ethan/nmf/out_100_decomp_t2//cifs/hariri-long/Projects/ethan/nmf/out_100_decomp_t1/time1_sbj19_comp17_alphaS21_38_alphaL10_vxInfo0_ard1_eta1/final_UV.mat';
# maskName = '/cifs/hariri-long/Projects/ethan/CBIG-master/data/templates/surface/fs_LR_32k/label/lh.medialwall.gii';
# outDir = '/cifs/hariri-long/Projects/ethan/nmf/out_100_decomp_t1';
# 
# resFileName		-- path to the decomposition results .mat file
# maskName		-- brain mask
# outDir			-- where the .nii or .tif files will be saved
# (optional)
# saveFig			-- save .tif files if set to 1
# refNiiName		-- reference image onto which the icn would be overlaid
# 
# func_saveVolRes2Nii(resFileName,maskName,outDir)



# after running nmf_testretest.R and writeout_nmf.R, use this script to write out each participant 
# to have their own cifti file with their probabilistic networks

cd /Users/ew198/Documents/individual_fns/nmf/out_100_scaled_thresholded/cifti_out

for s in {1..19} ; do
    mkdir ${s}/
    for n in {1..17} ; do
        mkdir ${s}/${n}
    done
done

cd /Users/ew198/Documents/individual_fns/nmf/out_100_scaled_thresholded/cifti_out
for s in {1..19} ; do
    for t in 1 2 ; do
        wb_command -cifti-merge s${s}_t${t}_softlabels_scaled_thresholded.dscalar.nii \
        -cifti ${s}/1/t${t}_scaled_thresholded.dscalar.nii \
        -cifti ${s}/2/t${t}_scaled_thresholded.dscalar.nii \
        -cifti ${s}/3/t${t}_scaled_thresholded.dscalar.nii \
        -cifti ${s}/4/t${t}_scaled_thresholded.dscalar.nii \
        -cifti ${s}/5/t${t}_scaled_thresholded.dscalar.nii \
        -cifti ${s}/6/t${t}_scaled_thresholded.dscalar.nii \
        -cifti ${s}/7/t${t}_scaled_thresholded.dscalar.nii \
        -cifti ${s}/8/t${t}_scaled_thresholded.dscalar.nii \
        -cifti ${s}/9/t${t}_scaled_thresholded.dscalar.nii \
        -cifti ${s}/10/t${t}_scaled_thresholded.dscalar.nii \
        -cifti ${s}/11/t${t}_scaled_thresholded.dscalar.nii \
        -cifti ${s}/12/t${t}_scaled_thresholded.dscalar.nii \
        -cifti ${s}/13/t${t}_scaled_thresholded.dscalar.nii \
        -cifti ${s}/14/t${t}_scaled_thresholded.dscalar.nii \
        -cifti ${s}/15/t${t}_scaled_thresholded.dscalar.nii \
        -cifti ${s}/16/t${t}_scaled_thresholded.dscalar.nii \
        -cifti ${s}/17/t${t}_scaled_thresholded.dscalar.nii 

        wb_command -set-map-names s${s}_t${t}_softlabels_scaled_thresholded.dscalar.nii -name-file networknames.txt
    done
done