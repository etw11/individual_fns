# test re-test of DBIS MS-HBM parcellations
# 11/2021


###### initialization ######
library(rmatio)
library(raveio)
library(ggseg)
library(ggsegExtra)
library(superheat)
library(mclustcomp)
library(plotwidgets)
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

### HCP 32

sub_1_t1 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time1/Ind_parcellation_MSHBM_sub1_w200_MRF40.mat')
sub_1_t2 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time2/Ind_parcellation_MSHBM_sub1_w200_MRF40.mat')
sub_2_t1 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time1/Ind_parcellation_MSHBM_sub2_w200_MRF40.mat')
sub_2_t2 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time2/Ind_parcellation_MSHBM_sub2_w200_MRF40.mat')
sub_3_t1 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time1/Ind_parcellation_MSHBM_sub3_w200_MRF40.mat')
sub_3_t2 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time2/Ind_parcellation_MSHBM_sub3_w200_MRF40.mat')
sub_4_t1 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time1/Ind_parcellation_MSHBM_sub4_w200_MRF40.mat')
sub_4_t2 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time2/Ind_parcellation_MSHBM_sub4_w200_MRF40.mat')
sub_5_t1 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time1/Ind_parcellation_MSHBM_sub5_w200_MRF40.mat')
sub_5_t2 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time2/Ind_parcellation_MSHBM_sub5_w200_MRF40.mat')
sub_6_t1 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time1/Ind_parcellation_MSHBM_sub6_w200_MRF40.mat')
sub_6_t2 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time2/Ind_parcellation_MSHBM_sub6_w200_MRF40.mat')
sub_7_t1 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time1/Ind_parcellation_MSHBM_sub7_w200_MRF40.mat')
sub_7_t2 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time2/Ind_parcellation_MSHBM_sub7_w200_MRF40.mat')
sub_8_t1 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time1/Ind_parcellation_MSHBM_sub8_w200_MRF40.mat')
sub_8_t2 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time2/Ind_parcellation_MSHBM_sub8_w200_MRF40.mat')
sub_9_t1 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time1/Ind_parcellation_MSHBM_sub9_w200_MRF40.mat')
sub_9_t2 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time2/Ind_parcellation_MSHBM_sub10_w200_MRF40.mat')
sub_10_t1 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time1/Ind_parcellation_MSHBM_sub10_w200_MRF40.mat')
sub_10_t2 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time2/Ind_parcellation_MSHBM_sub10_w200_MRF40.mat')
sub_11_t1 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time1/Ind_parcellation_MSHBM_sub11_w200_MRF40.mat')
sub_11_t2 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time2/Ind_parcellation_MSHBM_sub11_w200_MRF40.mat')
sub_12_t1 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time1/Ind_parcellation_MSHBM_sub12_w200_MRF40.mat')
sub_12_t2 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time2/Ind_parcellation_MSHBM_sub12_w200_MRF40.mat')
sub_13_t1 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time1/Ind_parcellation_MSHBM_sub13_w200_MRF40.mat')
sub_13_t2 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time2/Ind_parcellation_MSHBM_sub13_w200_MRF40.mat')
sub_14_t1 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time1/Ind_parcellation_MSHBM_sub14_w200_MRF40.mat')
sub_14_t2 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time2/Ind_parcellation_MSHBM_sub14_w200_MRF40.mat')
sub_15_t1 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time1/Ind_parcellation_MSHBM_sub15_w200_MRF40.mat')
sub_15_t2 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time2/Ind_parcellation_MSHBM_sub15_w200_MRF40.mat')
sub_16_t1 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time1/Ind_parcellation_MSHBM_sub16_w200_MRF40.mat')
sub_16_t2 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time2/Ind_parcellation_MSHBM_sub16_w200_MRF40.mat')
sub_17_t1 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time1/Ind_parcellation_MSHBM_sub17_w200_MRF40.mat')
sub_17_t2 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time2/Ind_parcellation_MSHBM_sub17_w200_MRF40.mat')
sub_18_t1 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time1/Ind_parcellation_MSHBM_sub18_w200_MRF40.mat')
sub_18_t2 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time2/Ind_parcellation_MSHBM_sub18_w200_MRF40.mat')
sub_19_t1 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time1/Ind_parcellation_MSHBM_sub19_w200_MRF40.mat')
sub_19_t2 <- read_mat('/Users/ew198/Documents/individual_fns/hcp/time2/Ind_parcellation_MSHBM_sub19_w200_MRF40.mat')

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

### BOOTSTRAP

sub_1_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time1/Ind_parcellation_MSHBM_sub1_w200_MRF40.mat')
sub_1_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time2/Ind_parcellation_MSHBM_sub1_w200_MRF40.mat')
sub_2_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time1/Ind_parcellation_MSHBM_sub2_w200_MRF40.mat')
sub_2_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time2/Ind_parcellation_MSHBM_sub2_w200_MRF40.mat')
sub_3_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time1/Ind_parcellation_MSHBM_sub3_w200_MRF40.mat')
sub_3_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time2/Ind_parcellation_MSHBM_sub3_w200_MRF40.mat')
sub_4_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time1/Ind_parcellation_MSHBM_sub4_w200_MRF40.mat')
sub_4_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time2/Ind_parcellation_MSHBM_sub4_w200_MRF40.mat')
sub_5_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time1/Ind_parcellation_MSHBM_sub5_w200_MRF40.mat')
sub_5_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time2/Ind_parcellation_MSHBM_sub5_w200_MRF40.mat')
sub_6_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time1/Ind_parcellation_MSHBM_sub6_w200_MRF40.mat')
sub_6_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time2/Ind_parcellation_MSHBM_sub6_w200_MRF40.mat')
sub_7_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time1/Ind_parcellation_MSHBM_sub7_w200_MRF40.mat')
sub_7_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time2/Ind_parcellation_MSHBM_sub7_w200_MRF40.mat')
sub_8_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time1/Ind_parcellation_MSHBM_sub8_w200_MRF40.mat')
sub_8_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time2/Ind_parcellation_MSHBM_sub8_w200_MRF40.mat')
sub_9_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time1/Ind_parcellation_MSHBM_sub9_w200_MRF40.mat')
sub_9_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time2/Ind_parcellation_MSHBM_sub10_w200_MRF40.mat')
sub_10_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time1/Ind_parcellation_MSHBM_sub10_w200_MRF40.mat')
sub_10_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time2/Ind_parcellation_MSHBM_sub10_w200_MRF40.mat')
sub_11_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time1/Ind_parcellation_MSHBM_sub11_w200_MRF40.mat')
sub_11_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time2/Ind_parcellation_MSHBM_sub11_w200_MRF40.mat')
sub_12_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time1/Ind_parcellation_MSHBM_sub12_w200_MRF40.mat')
sub_12_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time2/Ind_parcellation_MSHBM_sub12_w200_MRF40.mat')
sub_13_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time1/Ind_parcellation_MSHBM_sub13_w200_MRF40.mat')
sub_13_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time2/Ind_parcellation_MSHBM_sub13_w200_MRF40.mat')
sub_14_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time1/Ind_parcellation_MSHBM_sub14_w200_MRF40.mat')
sub_14_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time2/Ind_parcellation_MSHBM_sub14_w200_MRF40.mat')
sub_15_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time1/Ind_parcellation_MSHBM_sub15_w200_MRF40.mat')
sub_15_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time2/Ind_parcellation_MSHBM_sub15_w200_MRF40.mat')
sub_16_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time1/Ind_parcellation_MSHBM_sub16_w200_MRF40.mat')
sub_16_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time2/Ind_parcellation_MSHBM_sub16_w200_MRF40.mat')
sub_17_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time1/Ind_parcellation_MSHBM_sub17_w200_MRF40.mat')
sub_17_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time2/Ind_parcellation_MSHBM_sub17_w200_MRF40.mat')
sub_18_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time1/Ind_parcellation_MSHBM_sub18_w200_MRF40.mat')
sub_18_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time2/Ind_parcellation_MSHBM_sub18_w200_MRF40.mat')
sub_19_t1 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time1/Ind_parcellation_MSHBM_sub19_w200_MRF40.mat')
sub_19_t2 <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/bootstrap/time2/Ind_parcellation_MSHBM_sub19_w200_MRF40.mat')

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
sub_1_t1$lh.labels[sub_1_t1$lh.labels == 0] <- NA
sub_1_t1$rh.labels[sub_1_t1$rh.labels == 0] <- NA
sub1_x_t1 <- as.xifti(cortexL = sub_1_t1$lh.labels,
                      cortexR = sub_1_t1$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

sub_1_t2$lh.labels[sub_1_t2$lh.labels == 0] <- NA
sub_1_t2$rh.labels[sub_1_t2$rh.labels == 0] <- NA
sub1_x_t2 <- as.xifti(cortexL = sub_1_t2$lh.labels,
                      cortexR = sub_1_t2$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)


yeo_colors <- read.csv('/Users/ew198/Documents/individual_fns/yeo17_colors.csv', header = FALSE)
yeo_rgb <- yeo_colors[,3:5]
colnames(yeo_rgb) <- c("red", "green", "blue")
yeo_colors <- rgb2col(t(yeo_rgb))


dbis_colors <- c("#2ACCA4",
                 "#778CB0",
                 "#01760E",
                 "#CD3E4E",
                 "#0C30FF",
                 "#010182",
                 "#FFFF01",
                 "#E69422",
                 "#C8F8A4",
                 "#87324A",
                 "#4A9B3C",
                 "#FF98D5",
                 "#4682B4",
                 "#C43AFA",
                 "#781286",
                 "#FF0101",
                 "#7A8732")

colors <- c("#781286",
            "#FF0101",
            "#4682B4", 
            "#2ACCA4", 
            "#4A9B3C", 
            "#01760E", 
            "#C43AFA", 
            "#FF98D5", 
            "#C8F8A4", 
            "#7A8732", 
            "#778CB0", 
            "#E69422", 
            "#87324A", 
            "#0C30FF", 
            "#010182", 
            "#FFFF01", 
            "#CD3E4E")


yeo7_colors <- read.csv('/Users/ew198/Documents/individual_fns/yeo7_colors.csv', header = TRUE)
colnames(yeo7_colors) <- c("red", "green", "blue")
yeo7_colors <- rgb2col(t(yeo7_colors))

dbis7_colors <- c("#00760E",
                  "#C43AFA",
                  "#DCF8A4",
                  "#E69422",
                  "#781286",
                  "#CD3E4E",
                  "#4682B4")

view_xifti_surface(sub1_x_t1, color_mode = 'qualitative', colors = dbis_colors)
view_xifti_surface(sub1_x_t2, color_mode = 'qualitative', colors = dbis_colors)

#sub2
sub_2_t1$lh.labels[sub_2_t1$lh.labels == 0] <- NA
sub_2_t1$rh.labels[sub_2_t1$rh.labels == 0] <- NA
sub2_x_t1 <- as.xifti(cortexL = sub_2_t1$lh.labels,
                      cortexR = sub_2_t1$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

sub_2_t2$lh.labels[sub_2_t2$lh.labels == 0] <- NA
sub_2_t2$rh.labels[sub_2_t2$rh.labels == 0] <- NA
sub2_x_t2 <- as.xifti(cortexL = sub_2_t2$lh.labels,
                      cortexR = sub_2_t2$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

view_xifti_surface(sub2_x_t1, color_mode = 'qualitative', colors = dbis_colors)
view_xifti_surface(sub2_x_t2, color_mode = 'qualitative', colors = dbis_colors)

#sub3
sub_3_t1$lh.labels[sub_3_t1$lh.labels == 0] <- NA
sub_3_t1$rh.labels[sub_3_t1$rh.labels == 0] <- NA
sub3_x_t1 <- as.xifti(cortexL = sub_3_t1$lh.labels,
                      cortexR = sub_3_t1$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

sub_3_t2$lh.labels[sub_3_t2$lh.labels == 0] <- NA
sub_3_t2$rh.labels[sub_3_t2$rh.labels == 0] <- NA
sub3_x_t2 <- as.xifti(cortexL = sub_3_t2$lh.labels,
                      cortexR = sub_3_t2$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

view_xifti_surface(sub3_x_t1, color_mode = 'qualitative', colors = dbis_colors)
view_xifti_surface(sub3_x_t2, color_mode = 'qualitative', colors = dbis_colors)



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

view_xifti_surface(overlap_x_t1, color_mode = 'qualitative')
view_xifti_surface(overlap_x_t2)


### visualizing twohundred group parcellation

group_mat <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/group/group.mat')

group_mat$lh.labels[group_mat$lh.labels == 0] <- NA
group_mat$rh.labels[group_mat$rh.labels == 0] <- NA

group_mat_x<- as.xifti(cortexL = group_mat$lh.labels,
                      cortexR = group_mat$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

view_xifti_surface(group_mat_x, color_mode = 'qualitative', colors = dbis_colors)

### 7 network parcellation

group_7_mat <- read_mat('/Users/ew198/Documents/individual_fns/all_priors/twohundred/group_7/group.mat')

group_7_mat$lh.labels[group_7_mat$lh.labels == 0] <- NA
group_7_mat$rh.labels[group_7_mat$rh.labels == 0] <- NA

group_7_mat_x<- as.xifti(cortexL = group_7_mat$lh.labels,
                       cortexR = group_7_mat$rh.labels,
                       surfL = lh_very_inflated,
                       surfR = rh_very_inflated,
                       HCP_32k_auto_mwall = TRUE)

view_xifti_surface(group_7_mat_x, color_mode = 'qualitative', colors = dbis7_colors)

### HCP 32 group parcellation

hcp_mat <- read_mat('/Users/ew198/Documents/individual_fns/hcp/group.mat')

hcp_mat$lh.labels[hcp_mat$lh.labels == 0] <- NA
hcp_mat$rh.labels[hcp_mat$rh.labels == 0] <- NA

hcp_mat_x<- as.xifti(cortexL = hcp_mat$lh.labels,
                         cortexR = hcp_mat$rh.labels,
                         surfL = lh_very_inflated,
                         surfR = rh_very_inflated,
                         HCP_32k_auto_mwall = TRUE)

view_xifti_surface(hcp_mat_x, color_mode = 'qualitative', colors = dbis_colors)

## yeo templates

yeo17 <- read_cifti('/Users/ew198/Documents/CBIG-master/stable_projects/brain_parcellation/Yeo2011_fcMRI_clustering/1000subjects_reference/Yeo_JNeurophysiol11_SplitLabels/fs_LR32k/Yeo2011_17Networks_N1000.dlabel.nii')

yeo17$data$cortex_left[yeo17$data$cortex_left == 0] <- NA
yeo17$data$cortex_right[yeo17$data$cortex_right == 0] <- NA

yeo17_x<- as.xifti(cortexL = yeo17$data$cortex_left,
                       cortexR = yeo17$data$cortex_right,
                       surfL = lh_very_inflated,
                       surfR = rh_very_inflated,
                       HCP_32k_auto_mwall = TRUE)

view_xifti_surface(yeo17_x, color_mode = 'qualitative', colors = colors)


# yeo 7 network template

yeo7 <- read_cifti('/Users/ew198/Documents/CBIG-master/stable_projects/brain_parcellation/Yeo2011_fcMRI_clustering/1000subjects_reference/Yeo_JNeurophysiol11_SplitLabels/fs_LR32k/Yeo2011_7Networks_N1000.dlabel.nii')

yeo7$data$cortex_left[yeo7$data$cortex_left == 0] <- NA
yeo7$data$cortex_right[yeo7$data$cortex_right == 0] <- NA

yeo7_x<- as.xifti(cortexL = yeo7$data$cortex_left,
                   cortexR = yeo7$data$cortex_right,
                   surfL = lh_very_inflated,
                   surfR = rh_very_inflated,
                   HCP_32k_auto_mwall = TRUE)

view_xifti_surface(yeo7_x, color_mode = 'qualitative', colors = yeo7_colors)

##### DESCRIPTIVES

lh_all_df <- data.frame(sub_1_t1$lh.labels,
                        sub_2_t1$lh.labels,
                        sub_3_t1$lh.labels,
                        sub_4_t1$lh.labels,
                        sub_5_t1$lh.labels,
                        sub_6_t1$lh.labels,
                        sub_7_t1$lh.labels,
                        sub_8_t1$lh.labels,
                        sub_9_t1$lh.labels,
                        sub_10_t1$lh.labels,
                        sub_11_t1$lh.labels,
                        sub_12_t1$lh.labels,
                        sub_13_t1$lh.labels,
                        sub_14_t1$lh.labels,
                        sub_15_t1$lh.labels,
                        sub_16_t1$lh.labels,
                        sub_17_t1$lh.labels,
                        sub_18_t1$lh.labels,
                        sub_19_t1$lh.labels)

rh_all_df <- data.frame(sub_1_t1$rh.labels,
                        sub_2_t1$rh.labels,
                        sub_3_t1$rh.labels,
                        sub_4_t1$rh.labels,
                        sub_5_t1$rh.labels,
                        sub_6_t1$rh.labels,
                        sub_7_t1$rh.labels,
                        sub_8_t1$rh.labels,
                        sub_9_t1$rh.labels,
                        sub_10_t1$rh.labels,
                        sub_11_t1$rh.labels,
                        sub_12_t1$rh.labels,
                        sub_13_t1$rh.labels,
                        sub_14_t1$rh.labels,
                        sub_15_t1$rh.labels,
                        sub_16_t1$rh.labels,
                        sub_17_t1$rh.labels,
                        sub_18_t1$rh.labels,
                        sub_19_t1$rh.labels)



network_representation <- matrix(0, 19, 17)
for (i in 1:19) {
  lh_temp <- lh_all_df[,i]
  rh_temp <- rh_all_df[,i]
  for (n in 1:17){
    network_representation[i,n] <- sum(length(lh_temp[lh_temp == n]),  length(rh_temp[rh_temp == n]))
  }
}

p_1 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,1])) + 
  geom_histogram(color=colors[1+1], fill=colors[1+1], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,1])),
             color='black', linetype="dashed", size=1) +
  theme_classic() +
  ylim(0, 5) +
  xlim(1300, 7400)+
  xlab('network 1')
p_2 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,2])) + 
  geom_histogram(color=colors[2+1], fill=colors[2+1], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,2])),
             color='black', linetype="dashed", size=1) +
  theme_classic() +
  ylim(0, 5)+
  xlim(1300, 7400)+
  xlab('network 2')
p_3 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,3])) + 
  geom_histogram(color=colors[3+1], fill=colors[3+1], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,3])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 5)+
  xlim(1300, 7400)+
  xlab('network 3')
p_4 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,4])) + 
  geom_histogram(color=colors[4+1], fill=colors[4+1], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,4])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 5)+
  xlim(1300, 7400)+
  xlab('network 4')
p_5 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,5])) + 
  geom_histogram(color=colors[5+1], fill=colors[5+1], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,5])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 5)+
  xlim(1300, 7400)+
  xlab('network 5')
p_6 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,6])) + 
  geom_histogram(color=colors[6+1], fill=colors[6+1], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,6])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 5)+
  xlim(1300, 7400)+
  xlab('network 6')
p_7 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,7])) + 
  geom_histogram(color=colors[7+1], fill=colors[7+1], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,7])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 5)+
  xlim(1300, 7400)+
  xlab('network 7')
p_8 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,8])) + 
  geom_histogram(color=colors[8+1], fill=colors[8+1], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,8])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 5)+
  xlim(1300, 7400)+
  xlab('network 8')
p_9 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,9])) + 
  geom_histogram(color=colors[9+1], fill=colors[9+1], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,9])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 5)+
  xlim(1300, 7400)+
  xlab('network 9')
p_10 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,10])) + 
  geom_histogram(color=colors[10+1], fill=colors[10+1], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,10])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 5)+
  xlim(1300, 7400)+
  xlab('network 10')
p_11 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,11])) + 
  geom_histogram(color=colors[11+1], fill=colors[11+1], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,11])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 5)+
  xlim(1300, 7400)+
  xlab('network 11')
p_12 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,12])) + 
  geom_histogram(color=colors[12+1], fill=colors[12+1], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,12])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 5)+
  xlim(1300, 7400)+
  xlab('network 12')
p_13 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,13])) + 
  geom_histogram(color=colors[13+1], fill=colors[13+1], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,13])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 5)+
  xlim(1300, 7400)+
  xlab('network 13')
p_14 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,14])) + 
  geom_histogram(color=colors[14+1], fill=colors[14+1], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,14])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 5)+
  xlim(1300, 7400)+
  xlab('network 14')
p_15 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,15])) + 
  geom_histogram(color=colors[15+1], fill=colors[15+1], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,15])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 5)+
  xlim(1300, 7400)+
  xlab('network 15')
p_16 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,16])) + 
  geom_histogram(color=colors[16+1], fill=colors[16+1], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,16])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 5)+
  xlim(1300, 7400)+
  xlab('network 16')
p_17 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,17])) + 
  geom_histogram(color=colors[17+1], fill=colors[17+1], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,17])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 5)+
  xlim(1300, 7400) +
  xlab('network 17')


grid.arrange(p_1,
             p_2,
             p_3,
             p_4,
             p_5,
             p_6,
             p_7,
             p_8,
             p_9,
             p_10,
             p_11,
             p_12,
             p_13,
             p_14,
             p_15,
             p_16,
             p_17, nrow = 2)


write_cifti(group_mat_x, cifti_fname = "twohundred_avg.nii")



# col combine
colnames(lh_all_df) <- c('sub1', 'sub2', 'sub3', 'sub4', 'sub5', 'sub6', 'sub7', 'sub8', 'sub9', 'sub10', 'sub11', 'sub12', 'sub13', 'sub14', 'sub15', 'sub16', 'sub17', 'sub18', 'sub19')
colnames(rh_all_df) <- c('sub1', 'sub2', 'sub3', 'sub4', 'sub5', 'sub6', 'sub7', 'sub8', 'sub9', 'sub10', 'sub11', 'sub12', 'sub13', 'sub14', 'sub15', 'sub16', 'sub17', 'sub18', 'sub19')
all_all_df <- t(rbind(lh_all_df, rh_all_df))


mean_net_rep <- rep(0, 17)
median_net_rep <- rep(0, 17)
sd_net_rep <- rep(0, 17)
sd_standardized_net_rep <- rep(0, 17)
min_net_rep <- rep(0, 17)
max_net_rep <- rep(0, 17)
for (i in 1:17){
    mean_net_rep[i] <- mean(network_representation[,i])
    median_net_rep[i] <- median(network_representation[,i])
    sd_net_rep[i] <- sd(network_representation[,i])
    sd_standardized_net_rep[i] <- sd(network_representation[,i]) / mean(network_representation[,i])
    min_net_rep[i] <- min(network_representation[,i])
    max_net_rep[i] <- max(network_representation[,i])
}

network_descriptives <- data.frame(mean = mean_net_rep,
                                   median = median_net_rep,
                                   sd = sd_net_rep,
                                   sd_norm = sd_standardized_net_rep,
                                   min = min_net_rep,
                                   max = max_net_rep)

ggplot(network_descriptives, aes(x=mean, y=sd_standardized_net_rep)) +
  geom_point() +
  labs(x = "network size",
       y = "network size standard deviation")

