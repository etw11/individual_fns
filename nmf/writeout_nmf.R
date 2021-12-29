# write out test retest NMF DBIS parcellations as CIFTI files
# 12/2021
# Ethan Whitman

###### initialization ######
library(rmatio)
library(raveio)
library(ggseg)
library(ggsegExtra)
library(superheat)
library(mclustcomp)
library(psych)
library(ggplot2)
library(ggalt)
library(ciftiTools)
ciftiTools.setOption("wb_path", "/Applications/workbench/bin_macosx64/wb_command")

# load surfaces
lh_pial <- read_surf('/Users/ew198/Documents/CBIG-master/data/templates/surface/fs_LR_32k/surf/lh.pial_orig.gii')
rh_pial <- read_surf('/Users/ew198/Documents/CBIG-master/data/templates/surface/fs_LR_32k/surf/rh.pial_orig.gii')

lh_inflated <- read_surf('/Users/ew198/Documents/CBIG-master/data/templates/surface/fs_LR_32k/surf/lh.inflated.gii')
rh_inflated <- read_surf('/Users/ew198/Documents/CBIG-master/data/templates/surface/fs_LR_32k/surf/rh.inflated.gii')

lh_very_inflated <- read_surf('/Users/ew198/Documents/CBIG-master/data/templates/surface/fs_LR_32k/surf/lh.very_inflated.gii')
rh_very_inflated <- read_surf('/Users/ew198/Documents/CBIG-master/data/templates/surface/fs_LR_32k/surf/rh.very_inflated.gii')

lh_medialwall <- read_surf('/Users/ew198/Documents/CBIG-master/data/templates/surface/fs_LR_32k/label/lh.medialwall.gii')
rh_medialwall <- read_surf('/Users/ew198/Documents/CBIG-master/data/templates/surface/fs_LR_32k/label/rh.medialwall.gii')

medial_mask <- read_mat('/Users/ew198/Documents/CBIG-master/stable_projects/brain_parcellation/Kong2019_MSHBM/lib/fs_LR_32k_medial_mask.mat')

##### LOAD IN INDIVIDUALIZED MATRICES

# time 1
p1_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time1/net_mats/p1.mat')$p1
p2_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time1/net_mats/p2.mat')$p2
p3_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time1/net_mats/p3.mat')$p3
p4_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time1/net_mats/p4.mat')$p4
p5_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time1/net_mats/p5.mat')$p5
p6_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time1/net_mats/p6.mat')$p6
p7_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time1/net_mats/p7.mat')$p7
p8_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time1/net_mats/p8.mat')$p8
p9_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time1/net_mats/p9.mat')$p9
p10_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time1/net_mats/p10.mat')$p10
p11_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time1/net_mats/p11.mat')$p11
p12_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time1/net_mats/p12.mat')$p12
p13_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time1/net_mats/p13.mat')$p13
p14_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time1/net_mats/p14.mat')$p14
p15_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time1/net_mats/p15.mat')$p15
p16_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time1/net_mats/p16.mat')$p16
p17_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time1/net_mats/p17.mat')$p17
p18_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time1/net_mats/p18.mat')$p18
p19_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time1/net_mats/p19.mat')$p19

#time 2
p1_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time2/net_mats/p1.mat')$p1
p2_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time2/net_mats/p2.mat')$p2
p3_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time2/net_mats/p3.mat')$p3
p4_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time2/net_mats/p4.mat')$p4
p5_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time2/net_mats/p5.mat')$p5
p6_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time2/net_mats/p6.mat')$p6
p7_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time2/net_mats/p7.mat')$p7
p8_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time2/net_mats/p8.mat')$p8
p9_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time2/net_mats/p9.mat')$p9
p10_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time2/net_mats/p10.mat')$p10
p11_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time2/net_mats/p11.mat')$p11
p12_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time2/net_mats/p12.mat')$p12
p13_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time2/net_mats/p13.mat')$p13
p14_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time2/net_mats/p14.mat')$p14
p15_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time2/net_mats/p15.mat')$p15
p16_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time2/net_mats/p16.mat')$p16
p17_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time2/net_mats/p17.mat')$p17
p18_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time2/net_mats/p18.mat')$p18
p19_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/time2/net_mats/p19.mat')$p19

nmf_subs <- list(
  sub1=list(p1_t1,p1_t2),
  sub2=list(p2_t1,p2_t2),
  sub3=list(p3_t1,p3_t2),
  sub4=list(p4_t1,p4_t2),
  sub5=list(p5_t1,p5_t2),
  sub6=list(p6_t1,p6_t2),
  sub7=list(p7_t1,p7_t2),
  sub8=list(p8_t1,p8_t2),
  sub9=list(p9_t1,p9_t2),
  sub10=list(p10_t1,p10_t2),
  sub11=list(p11_t1,p11_t2),
  sub12=list(p12_t1,p12_t2),
  sub13=list(p13_t1,p13_t2),
  sub14=list(p14_t1,p14_t2),
  sub15=list(p15_t1,p15_t2),
  sub16=list(p16_t1,p16_t2),
  sub17=list(p17_t1,p17_t2),
  sub18=list(p18_t1,p18_t2),
  sub19=list(p19_t1,p19_t2)
)


### ADD MEDIAL WALL, CREATE XIFTIS, WRITE AS CIFTI

for (s in 1:19){
  for (n in 1:17){
    lh_temp_t1_softlabels <- c(rep(0, 32492))
    lh_temp_t2_softlabels <- c(rep(0, 32492))
    x <- 1
    for (i in 1:32492){
      if (medial_mask$medial.mask[i] == 1){
        lh_temp_t1_softlabels[i] <- nmf_subs[[s]][[1]][x,n]
        lh_temp_t2_softlabels[i] <- nmf_subs[[s]][[2]][x,n]
        x <- (x+1)
      } else if (medial_mask$medial.mask[i] == 0) {
        lh_temp_t1_softlabels[i] <- NA
        lh_temp_t2_softlabels[i] <- NA
      }
    }
    
    
    rh_temp_t1_softlabels <- c(rep(0, 32492))
    rh_temp_t2_softlabels <- c(rep(0, 32492))
    x <- 29697
    for (i in 1:32492){
      if (medial_mask$medial.mask[(i+32492)] == 1){
        rh_temp_t1_softlabels[i] <- nmf_subs[[s]][[1]][x,n]
        rh_temp_t2_softlabels[i] <- nmf_subs[[s]][[2]][x,n]
        x <- (x+1)
      } else if (medial_mask$medial.mask[(i+32492)] == 0) {
        rh_temp_t1_softlabels[i] <- NA
        rh_temp_t2_softlabels[i] <- NA
      }
    }
    
     assign(paste('p', s, '_', 'n', n, '_t1_x', sep = ''), as.xifti(cortexL = lh_temp_t1_softlabels,
                                                           cortexR = rh_temp_t1_softlabels,
                                                           surfL = lh_very_inflated,
                                                           surfR = rh_very_inflated,
                                                           HCP_32k_auto_mwall = TRUE))
    
     assign(paste('p', s, '_', 'n', n, '_t2_x', sep = ''),  as.xifti(cortexL = lh_temp_t2_softlabels,
                                                            cortexR = rh_temp_t2_softlabels,
                                                            surfL = lh_very_inflated,
                                                            surfR = rh_very_inflated,
                                                            HCP_32k_auto_mwall = TRUE))
     
     setwd('/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/cifti_out/')
     setwd(as.character(get("s")))
     setwd(as.character(get("n")))
     
     write_cifti(as.xifti(cortexL = lh_temp_t1_softlabels,
                          cortexR = rh_temp_t1_softlabels,
                          surfL = lh_very_inflated,
                          surfR = rh_very_inflated,
                          HCP_32k_auto_mwall = TRUE),
                          cifti_fname = "t1_scaled.dscalar.nii")
     
     write_cifti(as.xifti(cortexL = lh_temp_t2_softlabels,
                          cortexR = rh_temp_t2_softlabels,
                          surfL = lh_very_inflated,
                          surfR = rh_very_inflated,
                          HCP_32k_auto_mwall = TRUE),
                          cifti_fname = "t2_scaled.dscalar.nii")
     
     setwd("../..")
     
  }
}


view_xifti_surface(p1_n1_t1_x)
