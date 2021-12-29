# test re-test of DBIS NMF parcellations
# 11/2021
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
library(gridExtra)
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




##### LOAD IN INDIVIDUALIZED MATRICES - SCALED

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
  

##### LOAD IN INDIVIDUALIZED MATRICES

# time 1
p1_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time1/net_mats/p1.mat')$p1
p2_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time1/net_mats/p2.mat')$p2
p3_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time1/net_mats/p3.mat')$p3
p4_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time1/net_mats/p4.mat')$p4
p5_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time1/net_mats/p5.mat')$p5
p6_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time1/net_mats/p6.mat')$p6
p7_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time1/net_mats/p7.mat')$p7
p8_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time1/net_mats/p8.mat')$p8
p9_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time1/net_mats/p9.mat')$p9
p10_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time1/net_mats/p10.mat')$p10
p11_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time1/net_mats/p11.mat')$p11
p12_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time1/net_mats/p12.mat')$p12
p13_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time1/net_mats/p13.mat')$p13
p14_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time1/net_mats/p14.mat')$p14
p15_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time1/net_mats/p15.mat')$p15
p16_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time1/net_mats/p16.mat')$p16
p17_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time1/net_mats/p17.mat')$p17
p18_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time1/net_mats/p18.mat')$p18
p19_t1 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time1/net_mats/p19.mat')$p19

#time 2
p1_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time2/net_mats/p1.mat')$p1
p2_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time2/net_mats/p2.mat')$p2
p3_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time2/net_mats/p3.mat')$p3
p4_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time2/net_mats/p4.mat')$p4
p5_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time2/net_mats/p5.mat')$p5
p6_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time2/net_mats/p6.mat')$p6
p7_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time2/net_mats/p7.mat')$p7
p8_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time2/net_mats/p8.mat')$p8
p9_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time2/net_mats/p9.mat')$p9
p10_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time2/net_mats/p10.mat')$p10
p11_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time2/net_mats/p11.mat')$p11
p12_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time2/net_mats/p12.mat')$p12
p13_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time2/net_mats/p13.mat')$p13
p14_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time2/net_mats/p14.mat')$p14
p15_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time2/net_mats/p15.mat')$p15
p16_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time2/net_mats/p16.mat')$p16
p17_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time2/net_mats/p17.mat')$p17
p18_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time2/net_mats/p18.mat')$p18
p19_t2 <- read_mat('/Users/ew198/Documents/individual_fns/nmf/out_100/time2/net_mats/p19.mat')$p19

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


#### CONVERT INTO HARD LABELS

nmf_hardlabels <- nmf_subs

for (i in 1:19){
  for (j in 1:2){
    for (k in 1:59412){
    nmf_hardlabels[[i]][[j]][k,] <- as.numeric((nmf_subs[[i]][[j]][k,] == max(nmf_subs[[i]][[j]][k,])))
    }
    for (n in 1:17){
        nmf_hardlabels[[i]][[j]][,n][nmf_hardlabels[[i]][[j]][,n] == 1] <- n
    }
    assign(paste('hardlabels_sub', i, '_t', j, sep = ''), rowSums(nmf_hardlabels[[i]][[j]]))
  }
}

nmf_hardlabels_subs <- list(
  sub1=list(hardlabels_sub1_t1,hardlabels_sub1_t2),
  sub2=list(hardlabels_sub2_t1,hardlabels_sub2_t2),
  sub3=list(hardlabels_sub3_t1,hardlabels_sub3_t2),
  sub4=list(hardlabels_sub4_t1,hardlabels_sub4_t2),
  sub5=list(hardlabels_sub5_t1,hardlabels_sub5_t2),
  sub6=list(hardlabels_sub6_t1,hardlabels_sub6_t2),
  sub7=list(hardlabels_sub7_t1,hardlabels_sub7_t2),
  sub8=list(hardlabels_sub8_t1,hardlabels_sub8_t2),
  sub9=list(hardlabels_sub9_t1,hardlabels_sub9_t2),
  sub10=list(hardlabels_sub10_t1,hardlabels_sub10_t2),
  sub11=list(hardlabels_sub11_t1,hardlabels_sub11_t2),
  sub12=list(hardlabels_sub12_t1,hardlabels_sub12_t2),
  sub13=list(hardlabels_sub13_t1,hardlabels_sub13_t2),
  sub14=list(hardlabels_sub14_t1,hardlabels_sub14_t2),
  sub15=list(hardlabels_sub15_t1,hardlabels_sub15_t2),
  sub16=list(hardlabels_sub16_t1,hardlabels_sub16_t2),
  sub17=list(hardlabels_sub17_t1,hardlabels_sub17_t2),
  sub18=list(hardlabels_sub18_t1,hardlabels_sub18_t2),
  sub19=list(hardlabels_sub19_t1,hardlabels_sub19_t2)
)


# % overlap within participants
perc_overlap_within<-c(rep(0, 19))
sdc_within<-c(rep(0, 19))
for (i in 1:19){
  perc_overlap_within[i] <- length(nmf_hardlabels_subs[[i]][[1]][which(nmf_hardlabels_subs[[i]][[1]] == nmf_hardlabels_subs[[i]][[2]])]) / length(nmf_hardlabels_subs[[i]][[1]])
  sdc_within[i] <- mclustcomp(as.integer(nmf_hardlabels_subs[[i]][[1]]), as.integer(nmf_hardlabels_subs[[i]][[2]]), types = "sdc")$scores
}


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


### VISUALIZATION

network_a_lh_mwall <- c(rep(0, 32492))
network_b_lh_mwall <- c(rep(0, 32492))
lh_s1_t1_hardlabels <- c(rep(0, 32492))
lh_s1_t2_hardlabels <- c(rep(0, 32492))
lh_s1_n8_t1_softlabels <- c(rep(0, 32492))
lh_s1_n8_t2_softlabels <- c(rep(0, 32492))
x <- 1
for (i in 1:32492){
  if (medial_mask$medial.mask[i] == 1){
    network_a_lh_mwall[i] <- network_a[x]
    network_b_lh_mwall[i] <- network_b[x]
    lh_s1_t1_hardlabels[i] <- hardlabels_sub1_t1[x]
    lh_s1_t2_hardlabels[i] <- hardlabels_sub1_t2[x]
    lh_s1_n8_t1_softlabels[i] <- p1_t1[x,8]
    lh_s1_n8_t2_softlabels[i] <- p1_t2[x,8]
    x <- (x+1)
  } else if (medial_mask$medial.mask[i] == 0) {
    network_a_lh_mwall[i] <- NA
    network_b_lh_mwall[i] <- NA
    lh_s1_t1_hardlabels[i] <- NA
    lh_s1_t2_hardlabels[i] <- NA
    lh_s1_n8_t1_softlabels[i] <- NA
    lh_s1_n8_t2_softlabels[i] <- NA
  }
}

network_a_rh_mwall <- c(rep(0, 32492))
network_b_rh_mwall <- c(rep(0, 32492))
rh_s1_t1_hardlabels <- c(rep(0, 32492))
rh_s1_t2_hardlabels <- c(rep(0, 32492))
rh_s1_n8_t1_softlabels <- c(rep(0, 32492))
rh_s1_n8_t2_softlabels <- c(rep(0, 32492))
x <- 29697
for (i in 1:32492){
  if (medial_mask$medial.mask[(i+32492)] == 1){
    network_a_rh_mwall[i] <- network_a[x]
    network_b_rh_mwall[i] <- network_b[x]
    rh_s1_t1_hardlabels[i] <- hardlabels_sub1_t1[x]
    rh_s1_t2_hardlabels[i] <- hardlabels_sub1_t2[x]
    rh_s1_n8_t1_softlabels[i] <- p1_t1[x,8]
    rh_s1_n8_t2_softlabels[i] <- p1_t2[x,8]
    x <- (x+1)
  } else if (medial_mask$medial.mask[(i+32492)] == 0) {
    network_a_rh_mwall[i] <- NA
    network_b_rh_mwall[i] <- NA
    rh_s1_t1_hardlabels[i] <- NA
    rh_s1_t2_hardlabels[i] <- NA  
    rh_s1_n8_t1_softlabels[i] <- NA
    rh_s1_n8_t2_softlabels[i] <- NA
  }
}

rh_s1_n1_t1_softlabels[rh_s1_n1_t1_softlabels == 0] <- NA
rh_s1_n1_t2_softlabels[rh_s1_n1_t2_softlabels == 0] <- NA
lh_s1_n1_t1_softlabels[lh_s1_n1_t1_softlabels == 0] <- NA
lh_s1_n1_t2_softlabels[lh_s1_n1_t2_softlabels == 0] <- NA


test_a <- as.xifti(cortexL = lh_s1_t2_hardlabels,
                 cortexR = network_a_rh_mwall,
                 surfL = lh_very_inflated,
                 surfR = rh_very_inflated,
                 HCP_32k_auto_mwall = TRUE)

test_b <- as.xifti(cortexL = network_b_lh_mwall,
                   cortexR = network_b_rh_mwall,
                   surfL = lh_very_inflated,
                   surfR = rh_very_inflated,
                   HCP_32k_auto_mwall = TRUE)

view_xifti_surface(test_a)
view_xifti_surface(test_b)



# HARD LABELS SUBJECT 1

s1_t1_hardlabels_x <- as.xifti(cortexL = lh_s1_t1_hardlabels,
                    cortexR = rh_s1_t1_hardlabels,
                    surfL = lh_very_inflated,
                    surfR = rh_very_inflated,
                    HCP_32k_auto_mwall = TRUE)

s1_t2_hardlabels_x <- as.xifti(cortexL = lh_s1_t2_hardlabels,
                    cortexR = rh_s1_t2_hardlabels,
                    surfL = lh_very_inflated,
                    surfR = rh_very_inflated,
                    HCP_32k_auto_mwall = TRUE)

colors <- c("#000000", "#781286","#FF0101","#4682B4", "#2ACCA4", "#4A9B3C", "#01760E", "#C43AFA", "#FF98D5", "#C8F8A4", "#7A8732", "#778CB0", "#E69422", "#87324A", "#0C30FF", "#010182", "#FFFF01", "#CD3E4E")

view_xifti_surface(s1_t1_hardlabels_x, color_mode = 'qualitative', colors = colors)
view_xifti_surface(s1_t2_hardlabels_x, color_mode = 'qualitative', colors = colors)



# SOFT LABELS SUBJECT 1 

s1_n8_t1_softlabels_x <- as.xifti(cortexL = lh_s1_n8_t1_softlabels,
                               cortexR = rh_s1_n8_t1_softlabels,
                               surfL = lh_very_inflated,
                               surfR = rh_very_inflated,
                               HCP_32k_auto_mwall = TRUE)

s1_n8_t2_hardlabels_x <- as.xifti(cortexL = lh_s1_n8_t2_softlabels,
                               cortexR = rh_s1_n8_t2_softlabels,
                               surfL = lh_very_inflated,
                               surfR = rh_very_inflated,
                               HCP_32k_auto_mwall = TRUE)


view_xifti_surface(s1_n8_t1_softlabels_x)
view_xifti_surface(s1_n8_t2_hardlabels_x)



### CALCULATING SOFT LABEL ICCS

softlabel_iccs <- matrix(0, 19, 17)
for (s in 1:19){
  for (n in 1:17){
    softlabel_iccs[s,n] <- ICC(data.frame(nmf_subs[[s]][[1]][,n], nmf_subs[[s]][[2]][,n]))$results$ICC[3]
  }
}
# save(softlabel_iccs, file = "softlabel_iccs.R")
save(softlabel_iccs, file = "softlabel_iccs_scaled.R")

load("/Users/ew198/Documents/individual_fns/nmf/out_100/softlabel_iccs.R")

avg_network_iccs <- colMeans(softlabel_iccs)

mean(avg_network_iccs)

superheat(softlabel_iccs)

hist(avg_network_iccs, breaks = 15)
  
  
softlabel_iccs_concat <- rep(0, 19)
for (s in 1:19){
  softlabel_iccs_concat[s] <- ICC(
    data.frame(c(nmf_subs[[s]][[1]][,1], nmf_subs[[s]][[1]][,2], nmf_subs[[s]][[1]][,3], 
                 nmf_subs[[s]][[1]][,4], nmf_subs[[s]][[1]][,5], nmf_subs[[s]][[1]][,6], 
                 nmf_subs[[s]][[1]][,7], nmf_subs[[s]][[1]][,8], nmf_subs[[s]][[1]][,9], 
                 nmf_subs[[s]][[1]][,10], nmf_subs[[s]][[1]][,11], nmf_subs[[s]][[1]][,12], 
                 nmf_subs[[s]][[1]][,13], nmf_subs[[s]][[1]][,14], nmf_subs[[s]][[1]][,15], 
                 nmf_subs[[s]][[1]][,16], nmf_subs[[s]][[1]][,17]),
               
               c(nmf_subs[[s]][[2]][,1], nmf_subs[[s]][[2]][,2], nmf_subs[[s]][[2]][,3], 
                 nmf_subs[[s]][[2]][,4], nmf_subs[[s]][[2]][,5], nmf_subs[[s]][[2]][,6], 
                 nmf_subs[[s]][[2]][,7], nmf_subs[[s]][[2]][,8], nmf_subs[[s]][[2]][,9], 
                 nmf_subs[[s]][[2]][,10], nmf_subs[[s]][[2]][,11], nmf_subs[[s]][[2]][,12], 
                 nmf_subs[[s]][[2]][,13], nmf_subs[[s]][[2]][,14], nmf_subs[[s]][[2]][,15], 
                 nmf_subs[[s]][[2]][,16], nmf_subs[[s]][[2]][,17])))$results$ICC[3]
}

# save(softlabel_iccs_concat, file = "softlabel_iccs_concat.R")
save(softlabel_iccs_concat, file = "softlabel_iccs_concat_scaled.R")

load("/Users/ew198/Documents/individual_fns/nmf/out_100/softlabel_iccs_concat.R")


hist(softlabel_iccs_concat)
mean(softlabel_iccs_concat)



### CALCULATING SOFT LABEL ICCS BETWEEN SUBJECTS

softlabel_between_subjects <- matrix(0, 19, 19)
for (i in 1:19){
  for (j in 1:19){
    softlabel_between_subjects[i,j] <- ICC(
    data.frame(c(nmf_subs[[i]][[1]][,1], nmf_subs[[i]][[1]][,2], nmf_subs[[i]][[1]][,3], 
                 nmf_subs[[i]][[1]][,4], nmf_subs[[i]][[1]][,5], nmf_subs[[i]][[1]][,6], 
                 nmf_subs[[i]][[1]][,7], nmf_subs[[i]][[1]][,8], nmf_subs[[i]][[1]][,9], 
                 nmf_subs[[i]][[1]][,10], nmf_subs[[i]][[1]][,11], nmf_subs[[i]][[1]][,12], 
                 nmf_subs[[i]][[1]][,13], nmf_subs[[i]][[1]][,14], nmf_subs[[i]][[1]][,15], 
                 nmf_subs[[i]][[1]][,16], nmf_subs[[i]][[1]][,17]),
               
               c(nmf_subs[[j]][[2]][,1], nmf_subs[[j]][[2]][,2], nmf_subs[[j]][[2]][,3], 
                 nmf_subs[[j]][[2]][,4], nmf_subs[[j]][[2]][,5], nmf_subs[[j]][[2]][,6], 
                 nmf_subs[[j]][[2]][,7], nmf_subs[[j]][[2]][,8], nmf_subs[[j]][[2]][,9], 
                 nmf_subs[[j]][[2]][,10], nmf_subs[[j]][[2]][,11], nmf_subs[[j]][[2]][,12], 
                 nmf_subs[[j]][[2]][,13], nmf_subs[[j]][[2]][,14], nmf_subs[[j]][[2]][,15], 
                 nmf_subs[[j]][[2]][,16], nmf_subs[[j]][[2]][,17])))$results$ICC[3]
  }
}
# save(softlabel_between_subjects, file = "softlabel_between_subjects.R")
save(softlabel_between_subjects, file = "softlabel_between_subjects_scaled.R")

load("/Users/ew198/Documents/individual_fns/nmf/out_100/softlabel_between_subjects.R")

superheat(softlabel_between_subjects)

mean_between_icc <- mean(softlabel_between_subjects[upper.tri(softlabel_between_subjects, diag = FALSE)])

softlabel_between_subjects_ar <- array(0, dim = c(19, 19, 17))
for (i in 1:19){
  for (j in 1:19){
    for (n in 1:17){
    softlabel_between_subjects_ar[i,j,n] <- ICC(data.frame(nmf_subs[[i]][[1]][,n], nmf_subs[[j]][[2]][,n]))$results$ICC[3]
    }
  }
}
# save(softlabel_between_subjects_ar, file = "softlabel_between_subjects_ar.R")
save(softlabel_between_subjects_ar, file = "softlabel_between_subjects_ar_scaled.R")

load("/Users/ew198/Documents/individual_fns/nmf/out_100/softlabel_between_subjects_ar.R")

softlabel_between_subjects_network_avg <- rep(0, 17)
for (i in 1:17){
  softlabel_between_subjects_network_avg[i] <- mean(softlabel_between_subjects_ar[,,i][upper.tri(softlabel_between_subjects_ar[,,i])])
}





# dumbell plot visualizing between vs within person network ICCs

load("/Users/ew198/Documents/individual_fns/nmf/out_100/softlabel_iccs.R")
load("/Users/ew198/Documents/individual_fns/nmf/out_100/softlabel_iccs_concat.R")
load("/Users/ew198/Documents/individual_fns/nmf/out_100/softlabel_between_subjects.R")
load("/Users/ew198/Documents/individual_fns/nmf/out_100/softlabel_between_subjects_ar.R")
avg_network_iccs <- colMeans(softlabel_iccs)
mean_between_icc <- mean(softlabel_between_subjects[upper.tri(softlabel_between_subjects, diag = FALSE)])
softlabel_between_subjects_network_avg <- rep(0, 17)
for (i in 1:17){
  softlabel_between_subjects_network_avg[i] <- mean(softlabel_between_subjects_ar[,,i][upper.tri(softlabel_between_subjects_ar[,,i])])
}
db <- ggplot(
  data.frame(between=c(mean_between_icc, softlabel_between_subjects_network_avg),
             within=c(mean(softlabel_iccs_concat), avg_network_iccs),
             network=as.factor(c("ALL", as.character(1:17)))),
  aes(x=between, 
      xend=within, 
      y=network, 
      group=network)) + 
  expand_limits(x=c(0,1)) + 
  geom_vline(xintercept = (mean(avg_network_iccs))) +
  geom_dumbbell(color="#a3c4dc",
                colour_x="#a3c4dc", 
                size=0.75, 
                colour_xend="#0e668b") +
  labs(x="ICC",
       y="network",
       title="within vs between people network ICCs - unscaled")+
  theme(panel.grid.minor=element_blank(),
        panel.grid.major.y=element_blank())

df <- data.frame(between=c(mean_between_icc, softlabel_between_subjects_network_avg),
                 within=c(mean(softlabel_iccs_concat), avg_network_iccs),
                 network=as.factor(c("ALL", as.character(1:17))))

density_unscaled <- ggplot(df) +
  geom_density(aes(x=within)) + 
  expand_limits(x=c(0,1), y=c(0,4)) +
  labs(x="ICC",
       y="density",
       title="distribution of ICCs - unscaled")




load("/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/softlabel_iccs_scaled.R")
load("/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/softlabel_iccs_concat_scaled.R")
load("/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/softlabel_between_subjects_scaled.R")
load("/Users/ew198/Documents/individual_fns/nmf/out_100_scaled/softlabel_between_subjects_ar_scaled.R")
avg_network_iccs <- colMeans(softlabel_iccs)
mean_between_icc <- mean(softlabel_between_subjects[upper.tri(softlabel_between_subjects, diag = FALSE)])
softlabel_between_subjects_network_avg <- rep(0, 17)
for (i in 1:17){
  softlabel_between_subjects_network_avg[i] <- mean(softlabel_between_subjects_ar[,,i][upper.tri(softlabel_between_subjects_ar[,,i])])
}


db_scaled <- ggplot(
  data.frame(between=c(mean_between_icc, softlabel_between_subjects_network_avg),
             within=c(mean(softlabel_iccs_concat), avg_network_iccs),
             network=as.factor(c("ALL", as.character(1:17)))),
  aes(x=between, 
      xend=within, 
      y=network, 
      group=network)) + 
  expand_limits(x=c(0,1)) + 
  geom_density() +
  geom_dumbbell(color="#a3c4dc",
                colour_x="#a3c4dc", 
                size=0.75, 
                colour_xend="#0e668b") +
  labs(x="ICC",
       y="network",
       title="within vs between people network ICCs - scaled")+
  theme(panel.grid.minor=element_blank(),
        panel.grid.major.y=element_blank())

df <- data.frame(between=c(mean_between_icc, softlabel_between_subjects_network_avg),
                 within=c(mean(softlabel_iccs_concat), avg_network_iccs),
                 network=as.factor(c("ALL", as.character(1:17))))

density_scaled <- ggplot(df) +
  geom_density(aes(x=within)) + 
  expand_limits(x=c(0,1), y=c(0,4)) +
  labs(x="ICC",
       y="density",
       title="distribution of ICCs - scaled")


grid.arrange(db, db_scaled, ncol=1)
grid.arrange(density_unscaled, density_scaled, ncol=1)
grid.arrange(db, density_unscaled, db_scaled, density_scaled, ncol=1)


