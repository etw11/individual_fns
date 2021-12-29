# test re-test of DBIS MS-HBM parcellations
# 11/2021


###### initialization ######
library(rmatio)
library(raveio)
library(ggseg)
library(ggsegExtra)
library(superheat)
library(mclustcomp)
library(ciftiTools)
ciftiTools.setOption("wb_path", "/Applications/workbench/bin_macosx64/wb_command")

# load surfaces
lh_pial <- read_surf('/Users/ew198/Documents/CBIG-master/data/templates/surface/fs_LR_32k/surf/lh.pial_orig.gii')
rh_pial <- read_surf('/Users/ew198/Documents/CBIG-master/data/templates/surface/fs_LR_32k/surf/rh.pial_orig.gii')

lh_inflated <- read_surf('/Users/ew198/Documents/CBIG-master/data/templates/surface/fs_LR_32k/surf/lh.inflated.gii')
rh_inflated <- read_surf('/Users/ew198/Documents/CBIG-master/data/templates/surface/fs_LR_32k/surf/rh.inflated.gii')

lh_very_inflated <- read_surf('/Users/ew198/Documents/CBIG-master/data/templates/surface/fs_LR_32k/surf/lh.very_inflated.gii')
rh_very_inflated <- read_surf('/Users/ew198/Documents/CBIG-master/data/templates/surface/fs_LR_32k/surf/rh.very_inflated.gii')




setwd('/Users/ew198/Documents/individual_fns')

sub_1 <- read.mat('/Users/ew198/Documents/individual_fns/test_retest/Ind_parcellation_MSHBM_sub1_w60_MRF30.mat')


sub1_x <- as.xifti(cortexL = sub_1$lh_labels,
                       cortexR = sub_1$rh_labels,
                       surfL = lh_very_inflated,
                       surfR = rh_very_inflated)

view_xifti_surface(sub1_x)



#### visualizing profiles

sub_1 <- read_mat('/Users/ew198/Documents/individual_fns/sub1_sess1_fs_LR_32k_roifs_LR_900.surf2surf_profile.mat')

mean_sub_1 <- rowMeans(sub_1$profile_mat)

sub1_x <- as.xifti(cortexL = sub_1$profile_mat[1:32492, 3],
                   cortexR = sub_1$profile_mat[32493:64984, 3],
                   surfL = lh_very_inflated,
                   surfR = rh_very_inflated)

sub1_x_mean <- as.xifti(cortexL = mean_sub_1[1:32492],
                       cortexR = mean_sub_1[32493:64984],
                       surfL = lh_inflated,
                       surfR = rh_inflated)

view_xifti_surface(sub1_x)
view_xifti_surface(sub1_x_mean)


### visualizing results from test_as_val

sub_1_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub1_w200_MRF20.mat')
sub_1_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint2/Ind_parcellation_MSHBM_sub1_w200_MRF20.mat')


sub1_x_t1 <- as.xifti(cortexL = sub_1_t1$lh.labels,
                   cortexR = sub_1_t1$rh.labels,
                   surfL = lh_very_inflated,
                   surfR = rh_very_inflated,
                   HCP_32k_auto_mwall = TRUE)

sub1_x_t2 <- as.xifti(cortexL = sub_1_t2$lh.labels,
                   cortexR = sub_1_t2$rh.labels,
                   surfL = lh_very_inflated,
                   surfR = rh_very_inflated,
                   HCP_32k_auto_mwall = TRUE)

# yeo17_colors <- data.frame(
#     color=c("781286","FF0101","4682B4", "2ACCA4", "4A9B3C", "01760E", "C43AFA", "FF98D5", "C8F8A4", "7A8732", "778CB0", "E69422", "87324A", "0C30FF", "010182", "FFFF01", "CD3E4E"),
#     value=c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17)
# )
# 
# yeo17_pal <- make_color_pal(colors = c("#000000","781286","FF0101","4682B4", "2ACCA4", "4A9B3C", "01760E", "C43AFA", "FF98D5", "C8F8A4", "7A8732", "778CB0", "E69422", "87324A", "0C30FF", "010182", "FFFF01", "CD3E4E"),
#             color_mode = "qualitative",
#             zlim = 17)

colors <- c("#000000", "#781286","#FF0101","#4682B4", "#2ACCA4", "#4A9B3C", "#01760E", "#C43AFA", "#FF98D5", "#C8F8A4", "#7A8732", "#778CB0", "#E69422", "#87324A", "#0C30FF", "#010182", "#FFFF01", "#CD3E4E")

view_xifti_surface(sub1_x_t1,
                   color_mode = 'qualitative',
                   colors=colors,
                   zlim = c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16))

view_xifti_surface(sub1_x_t2,
                   color_mode = 'qualitative',
                   colors=colors,
                   zlim = c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16))

# correlation
cor(sub_1_t1$rh.labels, sub_1_t2$rh.labels)

# % overlap 
perc_overlap_rh <- length(sub_1_t1$rh.labels[which(sub_1_t1$rh.labels == sub_1_t2$rh.labels)]) / length(sub_1_t1$rh.labels)
perc_overlap_lh <- length(sub_1_t1$lh.labels[which(sub_1_t1$lh.labels == sub_1_t2$lh.labels)]) / length(sub_1_t1$lh.labels)
perc_overlap <- (perc_overlap_rh + perc_overlap_lh) / 2




#############################
######## HCP PRIORS #########
#############################


### test 19 DBIS with HCP priors


sub_1_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub1_w80_MRF10.mat')
sub_1_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint2/Ind_parcellation_MSHBM_sub1_w80_MRF10.mat')
sub_2_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub2_w80_MRF10.mat')
sub_2_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint2/Ind_parcellation_MSHBM_sub2_w80_MRF10.mat')
sub_3_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub3_w80_MRF10.mat')
sub_3_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint2/Ind_parcellation_MSHBM_sub3_w80_MRF10.mat')
sub_4_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub4_w80_MRF10.mat')
sub_4_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint2/Ind_parcellation_MSHBM_sub4_w80_MRF10.mat')
sub_5_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub5_w80_MRF10.mat')
sub_5_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint2/Ind_parcellation_MSHBM_sub5_w80_MRF10.mat')
sub_6_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub6_w80_MRF10.mat')
sub_6_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint2/Ind_parcellation_MSHBM_sub6_w80_MRF10.mat')
sub_7_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub7_w80_MRF10.mat')
sub_7_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint2/Ind_parcellation_MSHBM_sub7_w80_MRF10.mat')
sub_8_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub8_w80_MRF10.mat')
sub_8_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint2/Ind_parcellation_MSHBM_sub8_w80_MRF10.mat')
sub_9_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub9_w80_MRF10.mat')
sub_9_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint2/Ind_parcellation_MSHBM_sub9_w80_MRF10.mat')
sub_10_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub10_w80_MRF10.mat')
sub_10_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint2/Ind_parcellation_MSHBM_sub10_w80_MRF10.mat')
sub_11_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub11_w80_MRF10.mat')
sub_11_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint2/Ind_parcellation_MSHBM_sub11_w80_MRF10.mat')
sub_12_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub12_w80_MRF10.mat')
sub_12_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint2/Ind_parcellation_MSHBM_sub12_w80_MRF10.mat')
sub_13_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub13_w80_MRF10.mat')
sub_13_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint2/Ind_parcellation_MSHBM_sub13_w80_MRF10.mat')
sub_14_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub14_w80_MRF10.mat')
sub_14_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint2/Ind_parcellation_MSHBM_sub14_w80_MRF10.mat')
sub_15_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub15_w80_MRF10.mat')
sub_15_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint2/Ind_parcellation_MSHBM_sub15_w80_MRF10.mat')
sub_16_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub16_w80_MRF10.mat')
sub_16_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint2/Ind_parcellation_MSHBM_sub16_w80_MRF10.mat')
sub_17_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub17_w80_MRF10.mat')
sub_17_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint2/Ind_parcellation_MSHBM_sub17_w80_MRF10.mat')
sub_18_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub18_w80_MRF10.mat')
sub_18_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint2/Ind_parcellation_MSHBM_sub18_w80_MRF10.mat')
# sub_19_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub19_w200_MRF20.mat')
# sub_19_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint2/Ind_parcellation_MSHBM_sub19_w200_MRF20.mat')

subs <- list(
  sub1=list(sub_1_t1,sub_1_t2),
  sub2=list(sub_2_t1,sub_2_t2),
  sub3=list(sub_3_t1,sub_3_t2),
  sub4=list(sub_4_t1,sub_4_t2),
  sub5=list(sub_5_t1,sub_5_t2),
  sub6=list(sub_6_t1,sub_6_t2),
  sub7=list(sub_7_t1,sub_7_t2),
  sub8=list(sub_8_t1,sub_8_t2),
  sub9=list(sub_9_t1,sub_9_t2),
  sub10=list(sub_10_t1,sub_10_t2),
  sub11=list(sub_11_t1,sub_11_t2),
  sub12=list(sub_12_t1,sub_12_t2),
  sub13=list(sub_13_t1,sub_13_t2),
  sub14=list(sub_14_t1,sub_14_t2),
  sub15=list(sub_15_t1,sub_15_t2),
  sub16=list(sub_16_t1,sub_16_t2),
  sub17=list(sub_17_t1,sub_17_t2),
  sub18=list(sub_18_t1,sub_18_t2)
)

# % overlap within participants
perc_overlap_within<-c(rep(0, 18))
sdc_rh_within<-c(rep(0, 18))
sdc_lh_within<-c(rep(0, 18))
for (i in 1:18){
  perc_overlap_rh <- length(subs[i][1][[1]][[1]]$rh.labels[which(subs[i][1][[1]][[1]]$rh.labels == subs[i][1][[1]][[2]]$rh.labels)]) / length(subs[i][1][[1]][[1]]$rh.labels)
  perc_overlap_lh <- length(subs[i][1][[1]][[1]]$lh.labels[which(subs[i][1][[1]][[1]]$lh.labels == subs[i][1][[1]][[2]]$lh.labels)]) / length(subs[i][1][[1]][[1]]$lh.labels)
  perc_overlap_within[i] <- (perc_overlap_rh + perc_overlap_lh) / 2
  
  sdc_rh_within[i] <- mclustcomp(as.integer(subs[i][1][[1]][[1]]$rh.labels), as.integer(subs[i][1][[1]][[2]]$rh.labels), types = "sdc")$scores
  sdc_lh_within[i] <- mclustcomp(as.integer(subs[i][1][[1]][[1]]$lh.labels), as.integer(subs[i][1][[1]][[2]]$lh.labels), types = "sdc")$scores
}

# save(perc_overlap_within, file = "perc_overlap_within.R")
# save(sdc_rh_within, file = "sdc_rh_within.R")
# save(sdc_lh_within, file = "sdc_lh_within.R")

load("perc_overlap_within.R")
load("sdc_rh_within.R")
load("sdc_lh_within.R")

# save(perc_overlap_within, file = "perc_overlap_within_140.R")
# save(sdc_rh_within, file = "sdc_rh_within_140.R")
# save(sdc_lh_within, file = "sdc_lh_within_140.R")

load("perc_overlap_within_140.R")
load("sdc_rh_within_140.R")
load("sdc_lh_within_140.R")

save(perc_overlap_within, file = "perc_overlap_within_140_20.R")
save(sdc_rh_within, file = "sdc_rh_within_140_20.R")
save(sdc_lh_within, file = "sdc_lh_within_140_20.R")

load("perc_overlap_within_140_20.R")
load("sdc_rh_within_140_20.R")
load("sdc_lh_within_140_20.R")

# % overlap between participants

overlap_mat_between_t1 <- matrix(0, 18, 18)
sdc_rh_between_t1 <- matrix(0, 18, 18)
sdc_lh_between_t1 <- matrix(0, 18, 18)
overlap_mat_between_t2 <- matrix(0, 18, 18)
sdc_rh_between_t2 <- matrix(0, 18, 18)
sdc_lh_between_t2 <- matrix(0, 18, 18)
for (i in 1:18){
  for (j in 1:18){
    temp_overlap_rh <- length(subs[i][1][[1]][[1]]$rh.labels[which(subs[i][1][[1]][[1]]$rh.labels == subs[j][1][[1]][[1]]$rh.labels)]) / length(subs[i][1][[1]][[1]]$rh.labels)
    temp_overlap_lh <- length(subs[i][1][[1]][[1]]$lh.labels[which(subs[i][1][[1]][[1]]$lh.labels == subs[j][1][[1]][[1]]$lh.labels)]) / length(subs[i][1][[1]][[1]]$lh.labels)
    overlap_mat_between_t1[i,j] <- (temp_overlap_rh + temp_overlap_lh) / 2
    
    temp_overlap_rh <- length(subs[i][1][[1]][[2]]$rh.labels[which(subs[i][1][[1]][[2]]$rh.labels == subs[j][1][[1]][[2]]$rh.labels)]) / length(subs[i][1][[1]][[2]]$rh.labels)
    temp_overlap_lh <- length(subs[i][1][[1]][[2]]$lh.labels[which(subs[i][1][[1]][[2]]$lh.labels == subs[j][1][[1]][[2]]$lh.labels)]) / length(subs[i][1][[1]][[2]]$lh.labels)
    overlap_mat_between_t2[i,j] <- (temp_overlap_rh + temp_overlap_lh) / 2
    
    sdc_rh_between_t1[i,j] <- mclustcomp(as.integer(subs[i][1][[1]][[1]]$rh.labels), as.integer(subs[j][1][[1]][[1]]$rh.labels), types = "sdc")$scores
    sdc_lh_between_t1[i,j] <- mclustcomp(as.integer(subs[i][1][[1]][[1]]$lh.labels), as.integer(subs[j][1][[1]][[1]]$lh.labels), types = "sdc")$scores
    
    sdc_rh_between_t2[i,j] <- mclustcomp(as.integer(subs[i][1][[1]][[2]]$rh.labels), as.integer(subs[j][1][[1]][[2]]$rh.labels), types = "sdc")$scores
    sdc_lh_between_t2[i,j] <- mclustcomp(as.integer(subs[i][1][[1]][[2]]$lh.labels), as.integer(subs[j][1][[1]][[2]]$lh.labels), types = "sdc")$scores
  }
}

save(overlap_mat_between_t1, file = "overlap_mat_between_t1.R")
save(sdc_rh_between_t1, file = "sdc_rh_between_t1.R")
save(sdc_lh_between_t1, file = "sdc_lh_between_t1.R")

save(overlap_mat_between_t2, file = "overlap_mat_between_t2.R")
save(sdc_rh_between_t2, file = "sdc_rh_between_t2.R")
save(sdc_lh_between_t2, file = "sdc_lh_between_t2.R")

save(overlap_mat_between_t1, file = "overlap_mat_between_t1_140.R")
save(sdc_rh_between_t1, file = "sdc_rh_between_t1_140.R")
save(sdc_lh_between_t1, file = "sdc_lh_between_t1_140.R")

save(overlap_mat_between_t2, file = "overlap_mat_between_t2_140.R")
save(sdc_rh_between_t2, file = "sdc_rh_between_t2_140.R")
save(sdc_lh_between_t2, file = "sdc_lh_between_t2_140.R")

save(overlap_mat_between_t1, file = "overlap_mat_between_t1_140_20.R")
save(sdc_rh_between_t1, file = "sdc_rh_between_t1_140_20.R")
save(sdc_lh_between_t1, file = "sdc_lh_between_t1_140_20.R")

save(overlap_mat_between_t2, file = "overlap_mat_between_t2_140_20.R")
save(sdc_rh_between_t2, file = "sdc_rh_between_t2_140_20.R")
save(sdc_lh_between_t2, file = "sdc_lh_between_t2_140_20.R")

load("overlap_mat_between_t1.R")
load("sdc_rh_between_t1.R")
load("sdc_lh_between_t1.R")
load("overlap_mat_between_t2.R")
load("sdc_rh_between_t2.R")
load("sdc_lh_between_t2.R")

load("overlap_mat_between_t1_140.R")
load("sdc_rh_between_t1_140.R")
load("sdc_lh_between_t1_140.R")
load("overlap_mat_between_t2_140.R")
load("sdc_rh_between_t2_140.R")
load("sdc_lh_between_t2_140.R")

load("overlap_mat_between_t1_140_20.R")
load("sdc_rh_between_t1_140_20.R")
load("sdc_lh_between_t1_140_20.R")
load("overlap_mat_between_t2_140_20.R")
load("sdc_rh_between_t2_140_20.R")
load("sdc_lh_between_t2_140_20.R")


# BETWEEN SUBJECTS
superheat(overlap_mat_between_t1, 
          membership.rows = c(1:18), membership.cols = c(1:18),
          left.label.size = .2, bottom.label.size = .25,
          left.label.col = "white", bottom.label.col = "white",
          title = "% overlap between 18 DBIS")

superheat(overlap_mat_between_t2, 
          membership.rows = c(1:18), membership.cols = c(1:18),
          left.label.size = .2, bottom.label.size = .25,
          left.label.col = "white", bottom.label.col = "white",
          title = "% overlap between 18 DBIS")

#dice coefficient right hemisphere
superheat(sdc_rh_between_t1, 
          membership.rows = c(1:18), membership.cols = c(1:18),
          left.label.size = .2, bottom.label.size = .25,
          left.label.col = "white", bottom.label.col = "white",
          title = "dice coefficient right hemisphere")

superheat(sdc_rh_between_t2, 
          membership.rows = c(1:18), membership.cols = c(1:18),
          left.label.size = .2, bottom.label.size = .25,
          left.label.col = "white", bottom.label.col = "white",
          title = "dice coefficient right hemisphere")

#dice coefficient left hemisphere
superheat(sdc_lh_between_t1, 
          membership.rows = c(1:18), membership.cols = c(1:18),
          left.label.size = .2, bottom.label.size = .25,
          left.label.col = "white", bottom.label.col = "white",
          title = "dice coefficient left hemisphere")

superheat(sdc_lh_between_t2, 
          membership.rows = c(1:18), membership.cols = c(1:18),
          left.label.size = .2, bottom.label.size = .25,
          left.label.col = "white", bottom.label.col = "white",
          title = "dice coefficient left hemisphere")

# average overlap within  (t1 and t2)
within_overlap <- mean(perc_overlap_within)
within_sdc <- mean(mean(sdc_rh_within), mean(sdc_lh_within))

#average overlap between

between_overlap <- mean(c(mean(overlap_mat_between_t1[upper.tri(overlap_mat_between_t1, diag = FALSE)]), mean(overlap_mat_between_t2[upper.tri(overlap_mat_between_t2, diag = FALSE)])))
between_sdc_t1 <- mean(c(mean(sdc_rh_between_t1[upper.tri(sdc_rh_between_t1, diag = FALSE)]), mean(sdc_lh_between_t1[upper.tri(sdc_lh_between_t1, diag = FALSE)])))
between_sdc_t2 <- mean(c(mean(sdc_rh_between_t2[upper.tri(sdc_rh_between_t2, diag = FALSE)]), mean(sdc_lh_between_t2[upper.tri(sdc_lh_between_t2, diag = FALSE)])))
between_sdc <- mean(c(between_sdc_t1, between_sdc_t2))


# projecting agreement back onto cortex

everyone_t1 <- data.frame(sub_1_t1  = c(sub_1_t1$rh.labels, sub_1_t1$lh.labels),
                          sub_2_t1  = c(sub_2_t1$rh.labels, sub_2_t1$lh.labels),
                          sub_3_t1  = c(sub_3_t1$rh.labels, sub_3_t1$lh.labels),
                          sub_4_t1  = c(sub_4_t1$rh.labels, sub_4_t1$lh.labels),
                          sub_5_t1  = c(sub_5_t1$rh.labels, sub_5_t1$lh.labels),
                          sub_6_t1  = c(sub_6_t1$rh.labels, sub_6_t1$lh.labels),
                          sub_7_t1  = c(sub_7_t1$rh.labels, sub_7_t1$lh.labels),
                          sub_8_t1  = c(sub_8_t1$rh.labels, sub_8_t1$lh.labels),
                          sub_9_t1  = c(sub_9_t1$rh.labels, sub_9_t1$lh.labels),
                          sub_10_t1 = c(sub_10_t1$rh.labels, sub_10_t1$lh.labels),
                          sub_11_t1 = c(sub_11_t1$rh.labels, sub_11_t1$lh.labels),
                          sub_12_t1 = c(sub_12_t1$rh.labels, sub_12_t1$lh.labels),
                          sub_13_t1 = c(sub_13_t1$rh.labels, sub_13_t1$lh.labels),
                          sub_14_t1 = c(sub_14_t1$rh.labels, sub_14_t1$lh.labels),
                          sub_15_t1 = c(sub_15_t1$rh.labels, sub_15_t1$lh.labels),
                          sub_16_t1 = c(sub_16_t1$rh.labels, sub_16_t1$lh.labels),
                          sub_17_t1 = c(sub_17_t1$rh.labels, sub_17_t1$lh.labels),
                          sub_18_t1 = c(sub_18_t1$rh.labels, sub_18_t1$lh.labels))

everyone_t2 <- data.frame(sub_1_t2  = c(sub_1_t2$rh.labels, sub_1_t2$lh.labels),
                          sub_2_t2  = c(sub_2_t2$rh.labels, sub_2_t2$lh.labels),
                          sub_3_t2  = c(sub_3_t2$rh.labels, sub_3_t2$lh.labels),
                          sub_4_t2  = c(sub_4_t2$rh.labels, sub_4_t2$lh.labels),
                          sub_5_t2  = c(sub_5_t2$rh.labels, sub_5_t2$lh.labels),
                          sub_6_t2  = c(sub_6_t2$rh.labels, sub_6_t2$lh.labels),
                          sub_7_t2  = c(sub_7_t2$rh.labels, sub_7_t2$lh.labels),
                          sub_8_t2  = c(sub_8_t2$rh.labels, sub_8_t2$lh.labels),
                          sub_9_t2  = c(sub_9_t2$rh.labels, sub_9_t2$lh.labels),
                          sub_10_t2 = c(sub_10_t2$rh.labels, sub_10_t2$lh.labels),
                          sub_11_t2 = c(sub_11_t2$rh.labels, sub_11_t2$lh.labels),
                          sub_12_t2 = c(sub_12_t2$rh.labels, sub_12_t2$lh.labels),
                          sub_13_t2 = c(sub_13_t2$rh.labels, sub_13_t2$lh.labels),
                          sub_14_t2 = c(sub_14_t2$rh.labels, sub_14_t2$lh.labels),
                          sub_15_t2 = c(sub_15_t2$rh.labels, sub_15_t2$lh.labels),
                          sub_16_t2 = c(sub_16_t2$rh.labels, sub_16_t2$lh.labels),
                          sub_17_t2 = c(sub_17_t2$rh.labels, sub_17_t2$lh.labels),
                          sub_18_t2 = c(sub_18_t2$rh.labels, sub_18_t2$lh.labels))

# calculate frequency of overlapping network assignments across cortex
agreement_mat_t1 <- rep(0, 64984)
agreement_mat_t2 <- rep(0, 64984)
for (i in 1:64984){
  agreement_mat_t1[i] <- max(as.data.frame(table(as.integer(everyone_t1[i,])))$Freq)
  agreement_mat_t2[i] <- max(as.data.frame(table(as.integer(everyone_t2[i,])))$Freq)
}

# projecting them into a surface

overlap_x_t1 <- as.xifti(cortexR = agreement_mat_t1[1:32492],
                         cortexL = agreement_mat_t1[32493:64984],
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

overlap_x_t2 <- as.xifti(cortexR = agreement_mat_t2[1:32492],
                         cortexL = agreement_mat_t2[32493:64984],
                         surfL = lh_very_inflated,
                         surfR = rh_very_inflated,
                         HCP_32k_auto_mwall = TRUE)

view_xifti_surface(overlap_x_t1)
view_xifti_surface(overlap_x_t2)


### concordance between test as val and test as test

sub_1_t1_tav <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub1_w200_MRF40.mat')
sub_1_t1_tat <- read_mat('/Users/ew198/Documents/individual_fns/test_as_test/time1/Ind_parcellation_MSHBM_sub1_w200_MRF40.mat')

length(sub_1_t1_tav$rh.labels[which(sub_1_t1_tav$rh.labels == sub_1_t1_tat$rh.labels)]) / length(sub_1_t1_tav$rh.labels)

identical(sub_1_t1_tav$rh.labels, sub_1_t1_tat$rh.labels)
identical(sub_1_t1_tav$lh.labels, sub_1_t1_tat$lh.labels)


### projecting parcellations onto surface 

#sub1
sub1_x_t1 <- as.xifti(cortexL = sub_1_t1$lh.labels,
                      cortexR = sub_1_t1$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

sub1_x_t2 <- as.xifti(cortexL = sub_1_t2$lh.labels,
                      cortexR = sub_1_t2$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

colors <- c("#000000", "#781286","#FF0101","#4682B4", "#2ACCA4", "#4A9B3C", "#01760E", "#C43AFA", "#FF98D5", "#C8F8A4", "#7A8732", "#778CB0", "#E69422", "#87324A", "#0C30FF", "#010182", "#FFFF01", "#CD3E4E")

view_xifti_surface(sub1_x_t1, color_mode = 'qualitative', colors = colors)
view_xifti_surface(sub1_x_t2, color_mode = 'qualitative', colors = colors)

#sub2
sub2_x_t1 <- as.xifti(cortexL = sub_2_t1$lh.labels,
                      cortexR = sub_2_t1$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

sub2_x_t2 <- as.xifti(cortexL = sub_2_t2$lh.labels,
                      cortexR = sub_2_t2$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

view_xifti_surface(sub2_x_t1, color_mode = 'qualitative')
view_xifti_surface(sub2_x_t2, color_mode = 'qualitative', colors = colors)

#sub3
sub3_x_t1 <- as.xifti(cortexL = sub_3_t1$lh.labels,
                      cortexR = sub_3_t1$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

sub3_x_t2 <- as.xifti(cortexL = sub_3_t2$lh.labels,
                      cortexR = sub_3_t2$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

view_xifti_surface(sub3_x_t1, color_mode = 'qualitative', colors = colors)
view_xifti_surface(sub3_x_t2, color_mode = 'qualitative', colors = colors)


#### homogeneity 200/40

hom_1_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub1_w200_MRF40.mat')$homo.with.weight[1,1]
hom_1_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub1_w200_MRF40.mat')$homo.with.weight[1,1]
hom_2_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub2_w200_MRF40.mat')$homo.with.weight[1,1]
hom_2_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub2_w200_MRF40.mat')$homo.with.weight[1,1]
hom_3_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub3_w200_MRF40.mat')$homo.with.weight[1,1]
hom_3_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub3_w200_MRF40.mat')$homo.with.weight[1,1]
hom_4_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub4_w200_MRF40.mat')$homo.with.weight[1,1]
hom_4_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub4_w200_MRF40.mat')$homo.with.weight[1,1]
hom_5_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub5_w200_MRF40.mat')$homo.with.weight[1,1]
hom_5_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub5_w200_MRF40.mat')$homo.with.weight[1,1]
hom_6_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub6_w200_MRF40.mat')$homo.with.weight[1,1]
hom_6_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub6_w200_MRF40.mat')$homo.with.weight[1,1]
hom_7_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub7_w200_MRF40.mat')$homo.with.weight[1,1]
hom_7_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub7_w200_MRF40.mat')$homo.with.weight[1,1]
hom_8_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub8_w200_MRF40.mat')$homo.with.weight[1,1]
hom_8_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub8_w200_MRF40.mat')$homo.with.weight[1,1]
hom_9_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub9_w200_MRF40.mat')$homo.with.weight[1,1]
hom_9_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub9_w200_MRF40.mat')$homo.with.weight[1,1]
hom_10_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub10_w200_MRF40.mat')$homo.with.weight[1,1]
hom_10_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub10_w200_MRF40.mat')$homo.with.weight[1,1]
hom_11_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub11_w200_MRF40.mat')$homo.with.weight[1,1]
hom_11_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub11_w200_MRF40.mat')$homo.with.weight[1,1]
hom_12_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub12_w200_MRF40.mat')$homo.with.weight[1,1]
hom_12_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub12_w200_MRF40.mat')$homo.with.weight[1,1]
hom_13_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub13_w200_MRF40.mat')$homo.with.weight[1,1]
hom_13_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub13_w200_MRF40.mat')$homo.with.weight[1,1]
hom_14_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub14_w200_MRF40.mat')$homo.with.weight[1,1]
hom_14_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub14_w200_MRF40.mat')$homo.with.weight[1,1]
hom_15_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub15_w200_MRF40.mat')$homo.with.weight[1,1]
hom_15_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub15_w200_MRF40.mat')$homo.with.weight[1,1]
hom_16_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub16_w200_MRF40.mat')$homo.with.weight[1,1]
hom_16_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub16_w200_MRF40.mat')$homo.with.weight[1,1]
hom_17_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub17_w200_MRF40.mat')$homo.with.weight[1,1]
hom_17_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub17_w200_MRF40.mat')$homo.with.weight[1,1]
hom_18_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub18_w200_MRF40.mat')$homo.with.weight[1,1]
hom_18_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub18_w200_MRF40.mat')$homo.with.weight[1,1]
# hom_19_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub19_w200_MRF20.mat')
# hom_19_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint2/Ind_parcellation_MSHBM_sub19_w200_MRF20.mat')

homos_w_weight <- c(hom_1_t1,hom_1_t2,hom_2_t1,hom_2_t2,hom_3_t1,hom_3_t2,hom_4_t1,hom_4_t2,hom_5_t1,hom_5_t2,hom_6_t1,hom_6_t2,hom_7_t1,hom_7_t2,hom_8_t1,hom_8_t2,hom_9_t1,hom_9_t2,hom_10_t1,hom_10_t2,hom_11_t1,hom_11_t2,hom_12_t1,hom_12_t2,hom_13_t1,hom_13_t2,hom_14_t1,hom_14_t2,hom_15_t1,hom_15_t2,hom_16_t1,hom_16_t2,hom_17_t1,hom_17_t2,hom_18_t1,hom_18_t2)
homos_w_weight_t1 <- c(hom_1_t1,hom_2_t1,hom_3_t1,hom_4_t1,hom_5_t1,hom_6_t1,hom_7_t1,hom_8_t1,hom_9_t1,hom_10_t1,hom_11_t1,hom_12_t1,hom_13_t1,hom_14_t1,hom_15_t1,hom_16_t1,hom_17_t1,hom_18_t1)
homos_w_weight_t2 <- c(hom_1_t2,hom_2_t2,hom_3_t2,hom_4_t2,hom_5_t2,hom_6_t2,hom_7_t2,hom_8_t2,hom_9_t2,hom_10_t2,hom_11_t2,hom_12_t2,hom_13_t2,hom_14_t2,hom_15_t2,hom_16_t2,hom_17_t2,hom_18_t2)

mean(homos_w_weight)



#### homogeneity 140/20

hom_1_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub1_w140_MRF20.mat')$homo.with.weight[1,1]
hom_1_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub1_w140_MRF20.mat')$homo.with.weight[1,1]
hom_2_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub2_w140_MRF20.mat')$homo.with.weight[1,1]
hom_2_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub2_w140_MRF20.mat')$homo.with.weight[1,1]
hom_3_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub3_w140_MRF20.mat')$homo.with.weight[1,1]
hom_3_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub3_w140_MRF20.mat')$homo.with.weight[1,1]
hom_4_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub4_w140_MRF20.mat')$homo.with.weight[1,1]
hom_4_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub4_w140_MRF20.mat')$homo.with.weight[1,1]
hom_5_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub5_w140_MRF20.mat')$homo.with.weight[1,1]
hom_5_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub5_w140_MRF20.mat')$homo.with.weight[1,1]
hom_6_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub6_w140_MRF20.mat')$homo.with.weight[1,1]
hom_6_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub6_w140_MRF20.mat')$homo.with.weight[1,1]
hom_7_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub7_w140_MRF20.mat')$homo.with.weight[1,1]
hom_7_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub7_w140_MRF20.mat')$homo.with.weight[1,1]
hom_8_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub8_w140_MRF20.mat')$homo.with.weight[1,1]
hom_8_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub8_w140_MRF20.mat')$homo.with.weight[1,1]
hom_9_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub9_w140_MRF20.mat')$homo.with.weight[1,1]
hom_9_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub9_w140_MRF40.mat')$homo.with.weight[1,1]
hom_10_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub10_w140_MRF20.mat')$homo.with.weight[1,1]
hom_10_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub10_w140_MRF20.mat')$homo.with.weight[1,1]
hom_11_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub11_w140_MRF20.mat')$homo.with.weight[1,1]
hom_11_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub11_w140_MRF20.mat')$homo.with.weight[1,1]
hom_12_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub12_w140_MRF20.mat')$homo.with.weight[1,1]
hom_12_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub12_w140_MRF20.mat')$homo.with.weight[1,1]
hom_13_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub13_w140_MRF20.mat')$homo.with.weight[1,1]
hom_13_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub13_w140_MRF20.mat')$homo.with.weight[1,1]
hom_14_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub14_w140_MRF20.mat')$homo.with.weight[1,1]
hom_14_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub14_w140_MRF20.mat')$homo.with.weight[1,1]
hom_15_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub15_w140_MRF20.mat')$homo.with.weight[1,1]
hom_15_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub15_w140_MRF20.mat')$homo.with.weight[1,1]
hom_16_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub16_w140_MRF20.mat')$homo.with.weight[1,1]
hom_16_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub16_w140_MRF20.mat')$homo.with.weight[1,1]
hom_17_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub17_w140_MRF20.mat')$homo.with.weight[1,1]
hom_17_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub17_w140_MRF20.mat')$homo.with.weight[1,1]
hom_18_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1/Ind_homogeneity_MSHBM_sub18_w140_MRF20.mat')$homo.with.weight[1,1]
hom_18_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time2/Ind_homogeneity_MSHBM_sub18_w140_MRF20.mat')$homo.with.weight[1,1]
# hom_19_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub19_w200_MRF20.mat')
# hom_19_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint2/Ind_parcellation_MSHBM_sub19_w200_MRF20.mat')

homos_w_weight <- c(hom_1_t1,hom_1_t2,hom_2_t1,hom_2_t2,hom_3_t1,hom_3_t2,hom_4_t1,hom_4_t2,hom_5_t1,hom_5_t2,hom_6_t1,hom_6_t2,hom_7_t1,hom_7_t2,hom_8_t1,hom_8_t2,hom_9_t1,hom_9_t2,hom_10_t1,hom_10_t2,hom_11_t1,hom_11_t2,hom_12_t1,hom_12_t2,hom_13_t1,hom_13_t2,hom_14_t1,hom_14_t2,hom_15_t1,hom_15_t2,hom_16_t1,hom_16_t2,hom_17_t1,hom_17_t2,hom_18_t1,hom_18_t2)
homos_w_weight_t1 <- c(hom_1_t1,hom_2_t1,hom_3_t1,hom_4_t1,hom_5_t1,hom_6_t1,hom_7_t1,hom_8_t1,hom_9_t1,hom_10_t1,hom_11_t1,hom_12_t1,hom_13_t1,hom_14_t1,hom_15_t1,hom_16_t1,hom_17_t1,hom_18_t1)
homos_w_weight_t2 <- c(hom_1_t2,hom_2_t2,hom_3_t2,hom_4_t2,hom_5_t2,hom_6_t2,hom_7_t2,hom_8_t2,hom_9_t2,hom_10_t2,hom_11_t2,hom_12_t2,hom_13_t2,hom_14_t2,hom_15_t2,hom_16_t2,hom_17_t2,hom_18_t2)

mean(homos_w_weight)


#visualizing
sub18_x_t1 <- as.xifti(cortexL = sub_18_t1$lh.labels,
                      cortexR = sub_18_t1$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

sub18_x_t2 <- as.xifti(cortexL = sub_18_t2$lh.labels,
                      cortexR = sub_18_t2$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

view_xifti_surface(sub18_x_t1, color_mode = 'qualitative', colors = colors)
view_xifti_surface(sub18_x_t2, color_mode = 'qualitative', colors = colors)










#############################
######## DBIS PRIORS ######## 
#############################

#     TWOSESS

### test 19 DBIS with DBIS priors


sub_1_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint1/Ind_parcellation_MSHBM_sub1_w140_MRF20.mat')
sub_1_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint2/Ind_parcellation_MSHBM_sub1_w140_MRF20.mat')
sub_2_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint1/Ind_parcellation_MSHBM_sub2_w140_MRF20.mat')
sub_2_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint2/Ind_parcellation_MSHBM_sub2_w140_MRF20.mat')
sub_3_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint1/Ind_parcellation_MSHBM_sub3_w140_MRF20.mat')
sub_3_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint2/Ind_parcellation_MSHBM_sub3_w140_MRF20.mat')
sub_4_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint1/Ind_parcellation_MSHBM_sub4_w140_MRF20.mat')
sub_4_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint2/Ind_parcellation_MSHBM_sub4_w140_MRF20.mat')
sub_5_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint1/Ind_parcellation_MSHBM_sub5_w140_MRF20.mat')
sub_5_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint2/Ind_parcellation_MSHBM_sub5_w140_MRF20.mat')
sub_6_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint1/Ind_parcellation_MSHBM_sub6_w140_MRF20.mat')
sub_6_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint2/Ind_parcellation_MSHBM_sub6_w140_MRF20.mat')
sub_7_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint1/Ind_parcellation_MSHBM_sub7_w140_MRF20.mat')
sub_7_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint2/Ind_parcellation_MSHBM_sub7_w140_MRF20.mat')
sub_8_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint1/Ind_parcellation_MSHBM_sub8_w140_MRF20.mat')
sub_8_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint2/Ind_parcellation_MSHBM_sub8_w140_MRF20.mat')
sub_9_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint1/Ind_parcellation_MSHBM_sub9_w140_MRF20.mat')
sub_9_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint2/Ind_parcellation_MSHBM_sub9_w140_MRF20.mat')
sub_10_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint1/Ind_parcellation_MSHBM_sub10_w140_MRF20.mat')
sub_10_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint2/Ind_parcellation_MSHBM_sub10_w140_MRF20.mat')
sub_11_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint1/Ind_parcellation_MSHBM_sub11_w140_MRF20.mat')
sub_11_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint2/Ind_parcellation_MSHBM_sub11_w140_MRF20.mat')
sub_12_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint1/Ind_parcellation_MSHBM_sub12_w140_MRF20.mat')
sub_12_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint2/Ind_parcellation_MSHBM_sub12_w140_MRF20.mat')
sub_13_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint1/Ind_parcellation_MSHBM_sub13_w140_MRF20.mat')
sub_13_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint2/Ind_parcellation_MSHBM_sub13_w140_MRF20.mat')
sub_14_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint1/Ind_parcellation_MSHBM_sub14_w140_MRF20.mat')
sub_14_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint2/Ind_parcellation_MSHBM_sub14_w140_MRF20.mat')
sub_15_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint1/Ind_parcellation_MSHBM_sub15_w140_MRF20.mat')
sub_15_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint2/Ind_parcellation_MSHBM_sub15_w140_MRF20.mat')
sub_16_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint1/Ind_parcellation_MSHBM_sub16_w140_MRF20.mat')
sub_16_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint2/Ind_parcellation_MSHBM_sub16_w140_MRF20.mat')
sub_17_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint1/Ind_parcellation_MSHBM_sub17_w140_MRF20.mat')
sub_17_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint2/Ind_parcellation_MSHBM_sub17_w140_MRF20.mat')
sub_18_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint1/Ind_parcellation_MSHBM_sub18_w140_MRF20.mat')
sub_18_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint2/Ind_parcellation_MSHBM_sub18_w140_MRF20.mat')
sub_19_t1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint1/Ind_parcellation_MSHBM_sub19_w140_MRF20.mat')
sub_19_t2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/timepoint2/Ind_parcellation_MSHBM_sub19_w140_MRF20.mat')

subs <- list(
  sub1=list(sub_1_t1,sub_1_t2),
  sub2=list(sub_2_t1,sub_2_t2),
  sub3=list(sub_3_t1,sub_3_t2),
  sub4=list(sub_4_t1,sub_4_t2),
  sub5=list(sub_5_t1,sub_5_t2),
  sub6=list(sub_6_t1,sub_6_t2),
  sub7=list(sub_7_t1,sub_7_t2),
  sub8=list(sub_8_t1,sub_8_t2),
  sub9=list(sub_9_t1,sub_9_t2),
  sub10=list(sub_10_t1,sub_10_t2),
  sub11=list(sub_11_t1,sub_11_t2),
  sub12=list(sub_12_t1,sub_12_t2),
  sub13=list(sub_13_t1,sub_13_t2),
  sub14=list(sub_14_t1,sub_14_t2),
  sub15=list(sub_15_t1,sub_15_t2),
  sub16=list(sub_16_t1,sub_16_t2),
  sub17=list(sub_17_t1,sub_17_t2),
  sub18=list(sub_18_t1,sub_18_t2),
  sub19=list(sub_19_t1,sub_19_t2)
)

# % overlap within participants
perc_overlap_within<-c(rep(0, 19))
sdc_rh_within<-c(rep(0, 19))
sdc_lh_within<-c(rep(0, 19))
for (i in 1:19){
  perc_overlap_rh <- length(subs[i][1][[1]][[1]]$rh.labels[which(subs[i][1][[1]][[1]]$rh.labels == subs[i][1][[1]][[2]]$rh.labels)]) / length(subs[i][1][[1]][[1]]$rh.labels)
  perc_overlap_lh <- length(subs[i][1][[1]][[1]]$lh.labels[which(subs[i][1][[1]][[1]]$lh.labels == subs[i][1][[1]][[2]]$lh.labels)]) / length(subs[i][1][[1]][[1]]$lh.labels)
  perc_overlap_within[i] <- (perc_overlap_rh + perc_overlap_lh) / 2
  
  sdc_rh_within[i] <- mclustcomp(as.integer(subs[i][1][[1]][[1]]$rh.labels), as.integer(subs[i][1][[1]][[2]]$rh.labels), types = "sdc")$scores
  sdc_lh_within[i] <- mclustcomp(as.integer(subs[i][1][[1]][[1]]$lh.labels), as.integer(subs[i][1][[1]][[2]]$lh.labels), types = "sdc")$scores
}

# save(perc_overlap_within, file = "perc_overlap_within.R")
# save(sdc_rh_within, file = "sdc_rh_within.R")
# save(sdc_lh_within, file = "sdc_lh_within.R")

load("perc_overlap_within.R")
load("sdc_rh_within.R")
load("sdc_lh_within.R")

# save(perc_overlap_within, file = "perc_overlap_within_140.R")
# save(sdc_rh_within, file = "sdc_rh_within_140.R")
# save(sdc_lh_within, file = "sdc_lh_within_140.R")

load("perc_overlap_within_140.R")
load("sdc_rh_within_140.R")
load("sdc_lh_within_140.R")

# save(perc_overlap_within, file = "perc_overlap_within_140_20.R")
# save(sdc_rh_within, file = "sdc_rh_within_140_20.R")
# save(sdc_lh_within, file = "sdc_lh_within_140_20.R")
# 
# load("perc_overlap_within_140_20.R")
# load("sdc_rh_within_140_20.R")
# load("sdc_lh_within_140_20.R")

save(perc_overlap_within, file = "perc_overlap_within_140_20_dibsp.R")
save(sdc_rh_within, file = "sdc_rh_within_140_20_dibsp.R")
save(sdc_lh_within, file = "sdc_lh_within_140_20_dibsp.R")

load("perc_overlap_within_140_20_dibsp.R")
load("sdc_rh_within_140_20_dibsp.R")
load("sdc_lh_within_140_20_dibsp.R")

# % overlap between participants

overlap_mat_between_t1 <- matrix(0, 19, 19)
sdc_rh_between_t1 <- matrix(0, 19, 19)
sdc_lh_between_t1 <- matrix(0, 19, 19)
overlap_mat_between_t2 <- matrix(0, 19, 19)
sdc_rh_between_t2 <- matrix(0, 19, 19)
sdc_lh_between_t2 <- matrix(0, 19, 19)
for (i in 1:19){
  for (j in 1:19){
    temp_overlap_rh <- length(subs[i][1][[1]][[1]]$rh.labels[which(subs[i][1][[1]][[1]]$rh.labels == subs[j][1][[1]][[1]]$rh.labels)]) / length(subs[i][1][[1]][[1]]$rh.labels)
    temp_overlap_lh <- length(subs[i][1][[1]][[1]]$lh.labels[which(subs[i][1][[1]][[1]]$lh.labels == subs[j][1][[1]][[1]]$lh.labels)]) / length(subs[i][1][[1]][[1]]$lh.labels)
    overlap_mat_between_t1[i,j] <- (temp_overlap_rh + temp_overlap_lh) / 2
    
    temp_overlap_rh <- length(subs[i][1][[1]][[2]]$rh.labels[which(subs[i][1][[1]][[2]]$rh.labels == subs[j][1][[1]][[2]]$rh.labels)]) / length(subs[i][1][[1]][[2]]$rh.labels)
    temp_overlap_lh <- length(subs[i][1][[1]][[2]]$lh.labels[which(subs[i][1][[1]][[2]]$lh.labels == subs[j][1][[1]][[2]]$lh.labels)]) / length(subs[i][1][[1]][[2]]$lh.labels)
    overlap_mat_between_t2[i,j] <- (temp_overlap_rh + temp_overlap_lh) / 2
    
    sdc_rh_between_t1[i,j] <- mclustcomp(as.integer(subs[i][1][[1]][[1]]$rh.labels), as.integer(subs[j][1][[1]][[1]]$rh.labels), types = "sdc")$scores
    sdc_lh_between_t1[i,j] <- mclustcomp(as.integer(subs[i][1][[1]][[1]]$lh.labels), as.integer(subs[j][1][[1]][[1]]$lh.labels), types = "sdc")$scores
    
    sdc_rh_between_t2[i,j] <- mclustcomp(as.integer(subs[i][1][[1]][[2]]$rh.labels), as.integer(subs[j][1][[1]][[2]]$rh.labels), types = "sdc")$scores
    sdc_lh_between_t2[i,j] <- mclustcomp(as.integer(subs[i][1][[1]][[2]]$lh.labels), as.integer(subs[j][1][[1]][[2]]$lh.labels), types = "sdc")$scores
  }
}

save(overlap_mat_between_t1, file = "overlap_mat_between_t1.R")
save(sdc_rh_between_t1, file = "sdc_rh_between_t1.R")
save(sdc_lh_between_t1, file = "sdc_lh_between_t1.R")

save(overlap_mat_between_t2, file = "overlap_mat_between_t2.R")
save(sdc_rh_between_t2, file = "sdc_rh_between_t2.R")
save(sdc_lh_between_t2, file = "sdc_lh_between_t2.R")

save(overlap_mat_between_t1, file = "overlap_mat_between_t1_140.R")
save(sdc_rh_between_t1, file = "sdc_rh_between_t1_140.R")
save(sdc_lh_between_t1, file = "sdc_lh_between_t1_140.R")

save(overlap_mat_between_t2, file = "overlap_mat_between_t2_140.R")
save(sdc_rh_between_t2, file = "sdc_rh_between_t2_140.R")
save(sdc_lh_between_t2, file = "sdc_lh_between_t2_140.R")

save(overlap_mat_between_t1, file = "overlap_mat_between_t1_140_20.R")
save(sdc_rh_between_t1, file = "sdc_rh_between_t1_140_20.R")
save(sdc_lh_between_t1, file = "sdc_lh_between_t1_140_20.R")

save(overlap_mat_between_t2, file = "overlap_mat_between_t2_140_20.R")
save(sdc_rh_between_t2, file = "sdc_rh_between_t2_140_20.R")
save(sdc_lh_between_t2, file = "sdc_lh_between_t2_140_20.R")

save(overlap_mat_between_t1, file = "overlap_mat_between_t1_140_20dibsp.R")
save(sdc_rh_between_t1, file = "sdc_rh_between_t1_140_20dibsp.R")
save(sdc_lh_between_t1, file = "sdc_lh_between_t1_140_20dibsp.R")

save(overlap_mat_between_t2, file = "overlap_mat_between_t2_140_20dibsp.R")
save(sdc_rh_between_t2, file = "sdc_rh_between_t2_140_20dibsp.R")
save(sdc_lh_between_t2, file = "sdc_lh_between_t2_140_20dibsp.R")

load("overlap_mat_between_t1.R")
load("sdc_rh_between_t1.R")
load("sdc_lh_between_t1.R")
load("overlap_mat_between_t2.R")
load("sdc_rh_between_t2.R")
load("sdc_lh_between_t2.R")

load("overlap_mat_between_t1_140.R")
load("sdc_rh_between_t1_140.R")
load("sdc_lh_between_t1_140.R")
load("overlap_mat_between_t2_140.R")
load("sdc_rh_between_t2_140.R")
load("sdc_lh_between_t2_140.R")

load("overlap_mat_between_t1_140_20.R")
load("sdc_rh_between_t1_140_20.R")
load("sdc_lh_between_t1_140_20.R")
load("overlap_mat_between_t2_140_20.R")
load("sdc_rh_between_t2_140_20.R")
load("sdc_lh_between_t2_140_20.R")


# BETWEEN SUBJECTS
superheat(overlap_mat_between_t1, 
          membership.rows = c(1:18), membership.cols = c(1:18),
          left.label.size = .2, bottom.label.size = .25,
          left.label.col = "white", bottom.label.col = "white",
          title = "% overlap between 18 DBIS")

superheat(overlap_mat_between_t2, 
          membership.rows = c(1:18), membership.cols = c(1:18),
          left.label.size = .2, bottom.label.size = .25,
          left.label.col = "white", bottom.label.col = "white",
          title = "% overlap between 18 DBIS")

#dice coefficient right hemisphere
superheat(sdc_rh_between_t1, 
          membership.rows = c(1:18), membership.cols = c(1:18),
          left.label.size = .2, bottom.label.size = .25,
          left.label.col = "white", bottom.label.col = "white",
          title = "dice coefficient right hemisphere")

superheat(sdc_rh_between_t2, 
          membership.rows = c(1:18), membership.cols = c(1:18),
          left.label.size = .2, bottom.label.size = .25,
          left.label.col = "white", bottom.label.col = "white",
          title = "dice coefficient right hemisphere")

#dice coefficient left hemisphere
superheat(sdc_lh_between_t1, 
          membership.rows = c(1:18), membership.cols = c(1:18),
          left.label.size = .2, bottom.label.size = .25,
          left.label.col = "white", bottom.label.col = "white",
          title = "dice coefficient left hemisphere")

superheat(sdc_lh_between_t2, 
          membership.rows = c(1:18), membership.cols = c(1:18),
          left.label.size = .2, bottom.label.size = .25,
          left.label.col = "white", bottom.label.col = "white",
          title = "dice coefficient left hemisphere")

# average overlap within  (t1 and t2)
within_overlap <- mean(perc_overlap_within)
within_sdc <- mean(mean(sdc_rh_within), mean(sdc_lh_within))

#average overlap between

between_overlap <- mean(c(mean(overlap_mat_between_t1[upper.tri(overlap_mat_between_t1, diag = FALSE)]), mean(overlap_mat_between_t2[upper.tri(overlap_mat_between_t2, diag = FALSE)])))
between_sdc_t1 <- mean(c(mean(sdc_rh_between_t1[upper.tri(sdc_rh_between_t1, diag = FALSE)]), mean(sdc_lh_between_t1[upper.tri(sdc_lh_between_t1, diag = FALSE)])))
between_sdc_t2 <- mean(c(mean(sdc_rh_between_t2[upper.tri(sdc_rh_between_t2, diag = FALSE)]), mean(sdc_lh_between_t2[upper.tri(sdc_lh_between_t2, diag = FALSE)])))
between_sdc <- mean(c(between_sdc_t1, between_sdc_t2))


# projecting agreement back onto cortex

everyone_t1 <- data.frame(sub_1_t1  = c(sub_1_t1$rh.labels, sub_1_t1$lh.labels),
                          sub_2_t1  = c(sub_2_t1$rh.labels, sub_2_t1$lh.labels),
                          sub_3_t1  = c(sub_3_t1$rh.labels, sub_3_t1$lh.labels),
                          sub_4_t1  = c(sub_4_t1$rh.labels, sub_4_t1$lh.labels),
                          sub_5_t1  = c(sub_5_t1$rh.labels, sub_5_t1$lh.labels),
                          sub_6_t1  = c(sub_6_t1$rh.labels, sub_6_t1$lh.labels),
                          sub_7_t1  = c(sub_7_t1$rh.labels, sub_7_t1$lh.labels),
                          sub_8_t1  = c(sub_8_t1$rh.labels, sub_8_t1$lh.labels),
                          sub_9_t1  = c(sub_9_t1$rh.labels, sub_9_t1$lh.labels),
                          sub_10_t1 = c(sub_10_t1$rh.labels, sub_10_t1$lh.labels),
                          sub_11_t1 = c(sub_11_t1$rh.labels, sub_11_t1$lh.labels),
                          sub_12_t1 = c(sub_12_t1$rh.labels, sub_12_t1$lh.labels),
                          sub_13_t1 = c(sub_13_t1$rh.labels, sub_13_t1$lh.labels),
                          sub_14_t1 = c(sub_14_t1$rh.labels, sub_14_t1$lh.labels),
                          sub_15_t1 = c(sub_15_t1$rh.labels, sub_15_t1$lh.labels),
                          sub_16_t1 = c(sub_16_t1$rh.labels, sub_16_t1$lh.labels),
                          sub_17_t1 = c(sub_17_t1$rh.labels, sub_17_t1$lh.labels),
                          sub_18_t1 = c(sub_18_t1$rh.labels, sub_18_t1$lh.labels),
                          sub_19_t1 = c(sub_19_t1$rh.labels, sub_19_t1$lh.labels))

everyone_t2 <- data.frame(sub_1_t2  = c(sub_1_t2$rh.labels, sub_1_t2$lh.labels),
                          sub_2_t2  = c(sub_2_t2$rh.labels, sub_2_t2$lh.labels),
                          sub_3_t2  = c(sub_3_t2$rh.labels, sub_3_t2$lh.labels),
                          sub_4_t2  = c(sub_4_t2$rh.labels, sub_4_t2$lh.labels),
                          sub_5_t2  = c(sub_5_t2$rh.labels, sub_5_t2$lh.labels),
                          sub_6_t2  = c(sub_6_t2$rh.labels, sub_6_t2$lh.labels),
                          sub_7_t2  = c(sub_7_t2$rh.labels, sub_7_t2$lh.labels),
                          sub_8_t2  = c(sub_8_t2$rh.labels, sub_8_t2$lh.labels),
                          sub_9_t2  = c(sub_9_t2$rh.labels, sub_9_t2$lh.labels),
                          sub_10_t2 = c(sub_10_t2$rh.labels, sub_10_t2$lh.labels),
                          sub_11_t2 = c(sub_11_t2$rh.labels, sub_11_t2$lh.labels),
                          sub_12_t2 = c(sub_12_t2$rh.labels, sub_12_t2$lh.labels),
                          sub_13_t2 = c(sub_13_t2$rh.labels, sub_13_t2$lh.labels),
                          sub_14_t2 = c(sub_14_t2$rh.labels, sub_14_t2$lh.labels),
                          sub_15_t2 = c(sub_15_t2$rh.labels, sub_15_t2$lh.labels),
                          sub_16_t2 = c(sub_16_t2$rh.labels, sub_16_t2$lh.labels),
                          sub_17_t2 = c(sub_17_t2$rh.labels, sub_17_t2$lh.labels),
                          sub_18_t2 = c(sub_18_t2$rh.labels, sub_18_t2$lh.labels),
                          sub_19_t2 = c(sub_19_t2$rh.labels, sub_19_t2$lh.labels))

# calculate frequency of overlapping network assignments across cortex
agreement_mat_t1 <- rep(0, 64984)
agreement_mat_t2 <- rep(0, 64984)
for (i in 1:64984){
  agreement_mat_t1[i] <- max(as.data.frame(table(as.integer(everyone_t1[i,])))$Freq)
  agreement_mat_t2[i] <- max(as.data.frame(table(as.integer(everyone_t2[i,])))$Freq)
}

# projecting them into a surface

overlap_x_t1 <- as.xifti(cortexR = agreement_mat_t1[1:32492],
                         cortexL = agreement_mat_t1[32493:64984],
                         surfL = lh_very_inflated,
                         surfR = rh_very_inflated,
                         HCP_32k_auto_mwall = TRUE)

overlap_x_t2 <- as.xifti(cortexR = agreement_mat_t2[1:32492],
                         cortexL = agreement_mat_t2[32493:64984],
                         surfL = lh_very_inflated,
                         surfR = rh_very_inflated,
                         HCP_32k_auto_mwall = TRUE)

view_xifti_surface(overlap_x_t1)
view_xifti_surface(overlap_x_t2)


### concordance between test as val and test as test

sub_1_t1_tav <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val/timepoint1/Ind_parcellation_MSHBM_sub1_w200_MRF40.mat')
sub_1_t1_tat <- read_mat('/Users/ew198/Documents/individual_fns/test_as_test/time1/Ind_parcellation_MSHBM_sub1_w200_MRF40.mat')

length(sub_1_t1_tav$rh.labels[which(sub_1_t1_tav$rh.labels == sub_1_t1_tat$rh.labels)]) / length(sub_1_t1_tav$rh.labels)

identical(sub_1_t1_tav$rh.labels, sub_1_t1_tat$rh.labels)
identical(sub_1_t1_tav$lh.labels, sub_1_t1_tat$lh.labels)


### projecting parcellations onto surface 

#sub1
sub1_x_t1 <- as.xifti(cortexL = sub_1_t1$lh.labels,
                      cortexR = sub_1_t1$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

sub1_x_t2 <- as.xifti(cortexL = sub_1_t2$lh.labels,
                      cortexR = sub_1_t2$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

colors <- c("#000000", "#781286","#FF0101","#4682B4", "#2ACCA4", "#4A9B3C", "#01760E", "#C43AFA", "#FF98D5", "#C8F8A4", "#7A8732", "#778CB0", "#E69422", "#87324A", "#0C30FF", "#010182", "#FFFF01", "#CD3E4E")

view_xifti_surface(sub1_x_t1, color_mode = 'qualitative', colors = colors)
view_xifti_surface(sub1_x_t2, color_mode = 'qualitative', colors = colors)

#sub2
sub2_x_t1 <- as.xifti(cortexL = sub_2_t1$lh.labels,
                      cortexR = sub_2_t1$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

sub2_x_t2 <- as.xifti(cortexL = sub_2_t2$lh.labels,
                      cortexR = sub_2_t2$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

view_xifti_surface(sub2_x_t1, color_mode = 'qualitative', colors = colors)
view_xifti_surface(sub2_x_t2, color_mode = 'qualitative', colors = colors)

#sub3
sub3_x_t1 <- as.xifti(cortexL = sub_3_t1$lh.labels,
                      cortexR = sub_3_t1$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

sub3_x_t2 <- as.xifti(cortexL = sub_3_t2$lh.labels,
                      cortexR = sub_3_t2$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

view_xifti_surface(sub3_x_t1, color_mode = 'qualitative', colors = colors)
view_xifti_surface(sub3_x_t2, color_mode = 'qualitative', colors = colors)






###### both sess for both sess

### test 19 DBIS with DBIS priors


sub_1 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/twosess/Ind_parcellation_MSHBM_sub1_w200_MRF40.mat')
sub_2 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/twosess/Ind_parcellation_MSHBM_sub2_w200_MRF40.mat')
sub_3 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/twosess/Ind_parcellation_MSHBM_sub3_w200_MRF40.mat')
sub_4 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/twosess/Ind_parcellation_MSHBM_sub4_w200_MRF40.mat')
sub_5 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/twosess/Ind_parcellation_MSHBM_sub5_w200_MRF40.mat')
sub_6 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/twosess/Ind_parcellation_MSHBM_sub6_w200_MRF40.mat')
sub_7 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/twosess/Ind_parcellation_MSHBM_sub7_w200_MRF40.mat')
sub_8 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/twosess/Ind_parcellation_MSHBM_sub8_w200_MRF40.mat')
sub_9 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/twosess/Ind_parcellation_MSHBM_sub9_w200_MRF40.mat')
sub_10 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/twosess/Ind_parcellation_MSHBM_sub10_w200_MRF40.mat')
sub_11 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/twosess/Ind_parcellation_MSHBM_sub11_w200_MRF40.mat')
sub_12 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/twosess/Ind_parcellation_MSHBM_sub12_w200_MRF40.mat')
sub_13 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/twosess/Ind_parcellation_MSHBM_sub13_w200_MRF40.mat')
sub_14 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/twosess/Ind_parcellation_MSHBM_sub14_w200_MRF40.mat')
sub_15 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/twosess/Ind_parcellation_MSHBM_sub15_w200_MRF40.mat')
sub_16 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/twosess/Ind_parcellation_MSHBM_sub16_w200_MRF40.mat')
sub_17 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/twosess/Ind_parcellation_MSHBM_sub17_w200_MRF40.mat')
sub_18 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/twosess/Ind_parcellation_MSHBM_sub18_w200_MRF40.mat')
sub_19 <- read_mat('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/twosess/Ind_parcellation_MSHBM_sub19_w140_MRF20.mat')

subs <- list(
  sub1=list(sub_1_t1,sub_1_t2),
  sub2=list(sub_2_t1,sub_2_t2),
  sub3=list(sub_3_t1,sub_3_t2),
  sub4=list(sub_4_t1,sub_4_t2),
  sub5=list(sub_5_t1,sub_5_t2),
  sub6=list(sub_6_t1,sub_6_t2),
  sub7=list(sub_7_t1,sub_7_t2),
  sub8=list(sub_8_t1,sub_8_t2),
  sub9=list(sub_9_t1,sub_9_t2),
  sub10=list(sub_10_t1,sub_10_t2),
  sub11=list(sub_11_t1,sub_11_t2),
  sub12=list(sub_12_t1,sub_12_t2),
  sub13=list(sub_13_t1,sub_13_t2),
  sub14=list(sub_14_t1,sub_14_t2),
  sub15=list(sub_15_t1,sub_15_t2),
  sub16=list(sub_16_t1,sub_16_t2),
  sub17=list(sub_17_t1,sub_17_t2),
  sub18=list(sub_18_t1,sub_18_t2)
)



### projecting parcellations onto surface 

#sub1
sub1_x_ts <- as.xifti(cortexL = sub_1$lh.labels,
                      cortexR = sub_1$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)


colors <- c("#000000", "#781286","#FF0101","#4682B4", "#2ACCA4", "#4A9B3C", "#01760E", "#C43AFA", "#FF98D5", "#C8F8A4", "#7A8732", "#778CB0", "#E69422", "#87324A", "#0C30FF", "#010182", "#FFFF01", "#CD3E4E")

view_xifti_surface(sub1_x_ts, color_mode = 'qualitative', colors = colors)

#sub2
sub2_x_ts <- as.xifti(cortexL = sub_2$lh.labels,
                      cortexR = sub_2$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)


view_xifti_surface(sub2_x_t1, color_mode = 'qualitative', colors = colors)

#sub3
sub3_x_ts <- as.xifti(cortexL = sub_3$lh.labels,
                      cortexR = sub_3$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)


view_xifti_surface(sub3_x_ts, color_mode = 'qualitative', colors = colors)





#### looking at DBIS group parcellation

group_avg <- read_mat('/Users/ew198/Documents/individual_fns/dbis_group.mat')

group_avg_x <- as.xifti(cortexL = group_avg$lh.labels,
                      cortexR = group_avg$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)


view_xifti_surface(group_avg_x, color_mode = 'qualitative', colors = colors)



allgroup_avg <- read_mat('/Users/ew198/Documents/individual_fns/allgroup.mat')

allgroup_avg_x <- as.xifti(cortexL = allgroup_avg$lh.labels,
                        cortexR = allgroup_avg$rh.labels,
                        surfL = lh_very_inflated,
                        surfR = rh_very_inflated,
                        HCP_32k_auto_mwall = TRUE)


view_xifti_surface(allgroup_avg_x, color_mode = 'qualitative', colors = colors)

### looking at HCP priors

params_hcp <- read_mat('/Users/ew198/Documents/individual_fns/Params_Final_HCP.mat')

params.parcellation <- params_hcp$Params[[8]]


### ALL PRIORS 100

sub_1_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time1/Ind_parcellation_MSHBM_sub1_w200_MRF40.mat')
sub_1_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time2/Ind_parcellation_MSHBM_sub1_w200_MRF40.mat')
sub_2_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time1/Ind_parcellation_MSHBM_sub2_w200_MRF40.mat')
sub_2_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time2/Ind_parcellation_MSHBM_sub2_w200_MRF40.mat')
sub_3_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time1/Ind_parcellation_MSHBM_sub3_w200_MRF40.mat')
sub_3_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time2/Ind_parcellation_MSHBM_sub3_w200_MRF40.mat')
sub_4_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time1/Ind_parcellation_MSHBM_sub4_w200_MRF40.mat')
sub_4_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time2/Ind_parcellation_MSHBM_sub4_w200_MRF40.mat')
sub_5_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time1/Ind_parcellation_MSHBM_sub5_w200_MRF40.mat')
sub_5_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time2/Ind_parcellation_MSHBM_sub5_w200_MRF40.mat')
sub_6_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time1/Ind_parcellation_MSHBM_sub6_w200_MRF40.mat')
sub_6_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time2/Ind_parcellation_MSHBM_sub6_w200_MRF40.mat')
sub_7_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time1/Ind_parcellation_MSHBM_sub7_w200_MRF40.mat')
sub_7_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time2/Ind_parcellation_MSHBM_sub7_w200_MRF40.mat')
sub_8_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time1/Ind_parcellation_MSHBM_sub8_w200_MRF40.mat')
sub_8_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time2/Ind_parcellation_MSHBM_sub8_w200_MRF40.mat')
sub_9_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time1/Ind_parcellation_MSHBM_sub9_w200_MRF40.mat')
sub_9_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time2/Ind_parcellation_MSHBM_sub9_w200_MRF40.mat')
sub_10_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time1/Ind_parcellation_MSHBM_sub10_w200_MRF40.mat')
sub_10_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time2/Ind_parcellation_MSHBM_sub10_w200_MRF40.mat')
sub_11_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time1/Ind_parcellation_MSHBM_sub11_w200_MRF40.mat')
sub_11_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time2/Ind_parcellation_MSHBM_sub11_w200_MRF40.mat')
sub_12_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time1/Ind_parcellation_MSHBM_sub12_w200_MRF40.mat')
sub_12_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time2/Ind_parcellation_MSHBM_sub12_w200_MRF40.mat')
sub_13_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time1/Ind_parcellation_MSHBM_sub13_w200_MRF40.mat')
sub_13_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time2/Ind_parcellation_MSHBM_sub13_w200_MRF40.mat')
sub_14_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time1/Ind_parcellation_MSHBM_sub14_w200_MRF40.mat')
sub_14_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time2/Ind_parcellation_MSHBM_sub14_w200_MRF40.mat')
sub_15_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time1/Ind_parcellation_MSHBM_sub15_w200_MRF40.mat')
sub_15_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time2/Ind_parcellation_MSHBM_sub15_w200_MRF40.mat')
sub_16_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time1/Ind_parcellation_MSHBM_sub16_w200_MRF40.mat')
sub_16_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time2/Ind_parcellation_MSHBM_sub16_w200_MRF40.mat')
sub_17_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time1/Ind_parcellation_MSHBM_sub17_w200_MRF40.mat')
sub_17_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time2/Ind_parcellation_MSHBM_sub17_w200_MRF40.mat')
sub_18_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time1/Ind_parcellation_MSHBM_sub18_w200_MRF40.mat')
sub_18_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time2/Ind_parcellation_MSHBM_sub18_w200_MRF40.mat')
sub_19_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time1/Ind_parcellation_MSHBM_sub19_w200_MRF40.mat')
sub_19_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/hundred/time2/Ind_parcellation_MSHBM_sub19_w200_MRF40.mat')

subs <- list(
  sub1=list(sub_1_t1,sub_1_t2),
  sub2=list(sub_2_t1,sub_2_t2),
  sub3=list(sub_3_t1,sub_3_t2),
  sub4=list(sub_4_t1,sub_4_t2),
  sub5=list(sub_5_t1,sub_5_t2),
  sub6=list(sub_6_t1,sub_6_t2),
  sub7=list(sub_7_t1,sub_7_t2),
  sub8=list(sub_8_t1,sub_8_t2),
  sub9=list(sub_9_t1,sub_9_t2),
  sub10=list(sub_10_t1,sub_10_t2),
  sub11=list(sub_11_t1,sub_11_t2),
  sub12=list(sub_12_t1,sub_12_t2),
  sub13=list(sub_13_t1,sub_13_t2),
  sub14=list(sub_14_t1,sub_14_t2),
  sub15=list(sub_15_t1,sub_15_t2),
  sub16=list(sub_16_t1,sub_16_t2),
  sub17=list(sub_17_t1,sub_17_t2),
  sub18=list(sub_18_t1,sub_18_t2),
  sub19=list(sub_19_t1,sub_19_t2)
)

### projecting parcellations onto surface 

#sub1
sub1_x_t1 <- as.xifti(cortexL = sub_1_t1$lh.labels,
                      cortexR = sub_1_t1$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

sub1_x_t2 <- as.xifti(cortexL = sub_1_t2$lh.labels,
                      cortexR = sub_1_t2$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

colors <- c("#000000", "#781286","#FF0101","#4682B4", "#2ACCA4", "#4A9B3C", "#01760E", "#C43AFA", "#FF98D5", "#C8F8A4", "#7A8732", "#778CB0", "#E69422", "#87324A", "#0C30FF", "#010182", "#FFFF01", "#CD3E4E")

view_xifti_surface(sub1_x_t1, color_mode = 'qualitative', colors = colors)
view_xifti_surface(sub1_x_t2, color_mode = 'qualitative', colors = colors)

#sub2
sub2_x_t1 <- as.xifti(cortexL = sub_2_t1$lh.labels,
                      cortexR = sub_2_t1$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

sub2_x_t2 <- as.xifti(cortexL = sub_2_t2$lh.labels,
                      cortexR = sub_2_t2$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

view_xifti_surface(sub2_x_t1, color_mode = 'qualitative', colors = colors)
view_xifti_surface(sub2_x_t2, color_mode = 'qualitative', colors = colors)

#sub3
sub3_x_t1 <- as.xifti(cortexL = sub_3_t1$lh.labels,
                      cortexR = sub_3_t1$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

sub3_x_t2 <- as.xifti(cortexL = sub_3_t2$lh.labels,
                      cortexR = sub_3_t2$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

view_xifti_surface(sub3_x_t1, color_mode = 'qualitative', colors = colors)
view_xifti_surface(sub3_x_t2, color_mode = 'qualitative', colors = colors)




### ALL PRIORS 200

sub_1_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time1/Ind_parcellation_MSHBM_sub1_w200_MRF40.mat')
sub_1_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time2/Ind_parcellation_MSHBM_sub1_w200_MRF40.mat')
sub_2_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time1/Ind_parcellation_MSHBM_sub2_w200_MRF40.mat')
sub_2_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time2/Ind_parcellation_MSHBM_sub2_w200_MRF40.mat')
sub_3_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time1/Ind_parcellation_MSHBM_sub3_w200_MRF40.mat')
sub_3_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time2/Ind_parcellation_MSHBM_sub3_w200_MRF40.mat')
sub_4_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time1/Ind_parcellation_MSHBM_sub4_w200_MRF40.mat')
sub_4_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time2/Ind_parcellation_MSHBM_sub4_w200_MRF40.mat')
sub_5_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time1/Ind_parcellation_MSHBM_sub5_w200_MRF40.mat')
sub_5_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time2/Ind_parcellation_MSHBM_sub5_w200_MRF40.mat')
sub_6_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time1/Ind_parcellation_MSHBM_sub6_w200_MRF40.mat')
sub_6_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time2/Ind_parcellation_MSHBM_sub6_w200_MRF40.mat')
sub_7_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time1/Ind_parcellation_MSHBM_sub7_w200_MRF40.mat')
sub_7_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time2/Ind_parcellation_MSHBM_sub7_w200_MRF40.mat')
sub_8_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time1/Ind_parcellation_MSHBM_sub8_w200_MRF40.mat')
sub_8_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time2/Ind_parcellation_MSHBM_sub8_w200_MRF40.mat')
sub_9_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time1/Ind_parcellation_MSHBM_sub9_w200_MRF40.mat')
sub_9_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time2/Ind_parcellation_MSHBM_sub9_w200_MRF40.mat')
sub_10_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time1/Ind_parcellation_MSHBM_sub10_w200_MRF40.mat')
sub_10_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time2/Ind_parcellation_MSHBM_sub10_w200_MRF40.mat')
sub_11_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time1/Ind_parcellation_MSHBM_sub11_w200_MRF40.mat')
sub_11_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time2/Ind_parcellation_MSHBM_sub11_w200_MRF40.mat')
sub_12_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time1/Ind_parcellation_MSHBM_sub12_w200_MRF40.mat')
sub_12_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time2/Ind_parcellation_MSHBM_sub12_w200_MRF40.mat')
sub_13_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time1/Ind_parcellation_MSHBM_sub13_w200_MRF40.mat')
sub_13_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time2/Ind_parcellation_MSHBM_sub13_w200_MRF40.mat')
sub_14_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time1/Ind_parcellation_MSHBM_sub14_w200_MRF40.mat')
sub_14_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time2/Ind_parcellation_MSHBM_sub14_w200_MRF40.mat')
sub_15_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time1/Ind_parcellation_MSHBM_sub15_w200_MRF40.mat')
sub_15_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time2/Ind_parcellation_MSHBM_sub15_w200_MRF40.mat')
sub_16_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time1/Ind_parcellation_MSHBM_sub16_w200_MRF40.mat')
sub_16_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time2/Ind_parcellation_MSHBM_sub16_w200_MRF40.mat')
sub_17_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time1/Ind_parcellation_MSHBM_sub17_w200_MRF40.mat')
sub_17_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time2/Ind_parcellation_MSHBM_sub17_w200_MRF40.mat')
sub_18_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time1/Ind_parcellation_MSHBM_sub18_w200_MRF40.mat')
sub_18_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time2/Ind_parcellation_MSHBM_sub18_w200_MRF40.mat')
sub_19_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time1/Ind_parcellation_MSHBM_sub19_w200_MRF40.mat')
sub_19_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/time2/Ind_parcellation_MSHBM_sub19_w200_MRF40.mat')

subs <- list(
  sub1=list(sub_1_t1,sub_1_t2),
  sub2=list(sub_2_t1,sub_2_t2),
  sub3=list(sub_3_t1,sub_3_t2),
  sub4=list(sub_4_t1,sub_4_t2),
  sub5=list(sub_5_t1,sub_5_t2),
  sub6=list(sub_6_t1,sub_6_t2),
  sub7=list(sub_7_t1,sub_7_t2),
  sub8=list(sub_8_t1,sub_8_t2),
  sub9=list(sub_9_t1,sub_9_t2),
  sub10=list(sub_10_t1,sub_10_t2),
  sub11=list(sub_11_t1,sub_11_t2),
  sub12=list(sub_12_t1,sub_12_t2),
  sub13=list(sub_13_t1,sub_13_t2),
  sub14=list(sub_14_t1,sub_14_t2),
  sub15=list(sub_15_t1,sub_15_t2),
  sub16=list(sub_16_t1,sub_16_t2),
  sub17=list(sub_17_t1,sub_17_t2),
  sub18=list(sub_18_t1,sub_18_t2),
  sub19=list(sub_19_t1,sub_19_t2)
)

### projecting parcellations onto surface 

#sub1
sub1_x_t1 <- as.xifti(cortexL = sub_1_t1$lh.labels,
                      cortexR = sub_1_t1$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

sub1_x_t2 <- as.xifti(cortexL = sub_1_t2$lh.labels,
                      cortexR = sub_1_t2$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

colors <- c("#000000", "#781286","#FF0101","#4682B4", "#2ACCA4", "#4A9B3C", "#01760E", "#C43AFA", "#FF98D5", "#C8F8A4", "#7A8732", "#778CB0", "#E69422", "#87324A", "#0C30FF", "#010182", "#FFFF01", "#CD3E4E")

view_xifti_surface(sub1_x_t1, color_mode = 'qualitative', colors = colors)
view_xifti_surface(sub1_x_t2, color_mode = 'qualitative', colors = colors)

#sub2
sub2_x_t1 <- as.xifti(cortexL = sub_2_t1$lh.labels,
                      cortexR = sub_2_t1$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

sub2_x_t2 <- as.xifti(cortexL = sub_2_t2$lh.labels,
                      cortexR = sub_2_t2$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

view_xifti_surface(sub2_x_t1, color_mode = 'qualitative', colors = colors)
view_xifti_surface(sub2_x_t2, color_mode = 'qualitative', colors = colors)

#sub3
sub3_x_t1 <- as.xifti(cortexL = sub_3_t1$lh.labels,
                      cortexR = sub_3_t1$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

sub3_x_t2 <- as.xifti(cortexL = sub_3_t2$lh.labels,
                      cortexR = sub_3_t2$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

view_xifti_surface(sub3_x_t1, color_mode = 'qualitative', colors = colors)
view_xifti_surface(sub3_x_t2, color_mode = 'qualitative', colors = colors)

