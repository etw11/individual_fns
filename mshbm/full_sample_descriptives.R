## generating descriptive statistics on the individualized parcellations in the full 762 sample
# 3/2022
library(raveio)
library(plotwidgets)
library(ggplot2)
library(grid)
library(gridExtra) 
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


## load in group parcellation


dbis_colors <- c("#4682B4",
               "#FFFF01",
               "#4A9B3C",
               "#0C30FF",
               "#CD3E4E",
               "#010182",
               "#C8F8A4",
               "#FF98D5",
               "#FF0101",
               "#E69422",
               "#778CB0",
               "#87324A",
               "#781286",
               "#2ACCA4",
               "#01760E",
               "#C43AFA",
               "#7A8732")

group_mat <- read_mat('/Users/ew198/Documents/individual_fns/full_sample/group/group.mat')

group_mat$lh.labels[group_mat$lh.labels == 0] <- NA
group_mat$rh.labels[group_mat$rh.labels == 0] <- NA

group_mat_x<- as.xifti(cortexL = group_mat$lh.labels,
                     cortexR = group_mat$rh.labels,
                     surfL = lh_very_inflated,
                     surfR = rh_very_inflated,
                     HCP_32k_auto_mwall = TRUE)

view_xifti_surface(group_mat_x, color_mode = 'qualitative', colors = dbis_colors)

setwd("/Users/ew198/Documents/individual_fns/full_sample/categorical/")

filenames <- list.files(".", pattern="*.mat", full.names=TRUE)

network_representation <- matrix(0, 762, 17)
for (i in 1:762) {
  lh_temp <- read_mat(filenames[i])$lh.labels
  rh_temp <- read_mat(filenames[i])$rh.labels
  for (n in 1:17){
    network_representation[i,n] <- sum(length(lh_temp[lh_temp == n]),  length(rh_temp[rh_temp == n]))
  }
}


p_1 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,1])) + 
  geom_histogram(color=dbis_colors[1], fill=dbis_colors[1], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,1])),
             color='black', linetype="dashed", size=1) +
  theme_classic() +
  ylim(0, 120) +
  xlim(1300, 7400)+
  xlab('network 1')
p_2 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,2])) + 
  geom_histogram(color=dbis_colors[2], fill=dbis_colors[2], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,2])),
             color='black', linetype="dashed", size=1) +
  theme_classic() +
  ylim(0, 120) +
  xlim(1300, 7400)+
  xlab('network 2')
p_3 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,3])) + 
  geom_histogram(color=dbis_colors[3], fill=dbis_colors[3], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,3])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 120) +
  xlim(1300, 7400)+
  xlab('network 3')
p_4 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,4])) + 
  geom_histogram(color=dbis_colors[4], fill=dbis_colors[4], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,4])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 120) +
  xlim(1300, 7400)+
  xlab('network 4')
p_5 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,5])) + 
  geom_histogram(color=dbis_colors[5], fill=dbis_colors[5], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,5])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 120) +
  xlim(1300, 7400)+
  xlab('network 5')
p_6 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,6])) + 
  geom_histogram(color=dbis_colors[6], fill=dbis_colors[6], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,6])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 120) +
  xlim(1300, 7400)+
  xlab('network 6')
p_7 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,7])) + 
  geom_histogram(color=dbis_colors[7], fill=dbis_colors[7], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,7])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 120) +
  xlim(1300, 7400)+
  xlab('network 7')
p_8 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,8])) + 
  geom_histogram(color=dbis_colors[8], fill=dbis_colors[8], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,8])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 120) +
  xlim(1300, 7400)+
  xlab('network 8')
p_9 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,9])) + 
  geom_histogram(color=dbis_colors[9], fill=dbis_colors[9], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,9])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 120) +
  xlim(1300, 7400)+
  xlab('network 9')
p_10 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,10])) + 
  geom_histogram(color=dbis_colors[10], fill=dbis_colors[10], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,10])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 120) +
  xlim(1300, 7400)+
  xlab('network 10')
p_11 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,11])) + 
  geom_histogram(color=dbis_colors[11], fill=dbis_colors[11], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,11])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 120) +
  xlim(1300, 7400)+
  xlab('network 11')
p_12 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,12])) + 
  geom_histogram(color=dbis_colors[12], fill=dbis_colors[12], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,12])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 120) +
  xlim(1300, 7400)+
  xlab('network 12')
p_13 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,13])) + 
  geom_histogram(color=dbis_colors[13], fill=dbis_colors[13], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,13])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 120) +
  xlim(1300, 7400)+
  xlab('network 13')
p_14 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,14])) + 
  geom_histogram(color=dbis_colors[14], fill=dbis_colors[14], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,14])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 120) +
  xlim(1300, 7400)+
  xlab('network 14')
p_15 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,15])) + 
  geom_histogram(color=dbis_colors[15], fill=dbis_colors[15], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,15])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 120) +
  xlim(1300, 7400)+
  xlab('network 15')
p_16 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,16])) + 
  geom_histogram(color=dbis_colors[16], fill=dbis_colors[16], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,16])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 120) +
  xlim(1300, 7400)+
  xlab('network 16')
p_17 <- ggplot(as.data.frame(network_representation), aes(x=network_representation[,17])) + 
  geom_histogram(color=dbis_colors[17], fill=dbis_colors[17], alpha=1, binwidth =100) +
  geom_vline(aes(xintercept=mean(network_representation[,17])),
             color='black', linetype="dashed", size=1) +
  theme_classic()+
  ylim(0, 120) +
  xlim(1300, 7400)+
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

ggplot(network_descriptives, aes(x=mean, y=sd_norm)) +
  geom_point() +
  labs(x = "network size",
       y = "network size standard deviation")



### generating full sample variability map


# calculate frequency of overlapping network assignments across cortex


setwd("/Users/ew198/Documents/individual_fns/full_sample/categorical/")
filenames <- list.files(".", pattern="*.mat", full.names=TRUE)

everyone <- matrix(0, 64984, 762)
for (i in 1:762) {
  everyone[,i] <- c(read_mat(filenames[i])$lh.labels, read_mat(filenames[i])$rh.labels)
}


agreement_mat <- rep(0, 64984)
for (i in 1:64984){
  agreement_mat[i] <- max(as.data.frame(table(as.integer(everyone[i,])))$Freq)
}

# projecting them into a surface

overlap_x <- as.xifti(cortexL = agreement_mat[1:32492],
                         cortexR = agreement_mat[32493:64984],
                         surfL = lh_very_inflated,
                         surfR = rh_very_inflated,
                         HCP_32k_auto_mwall = TRUE)

view_xifti_surface(overlap_x, color_mode = 'qualitative')
view_xifti_surface(overlap_x)


overlap_x <- as.xifti(cortexL = agreement_mat[1:32492],
                      cortexR = agreement_mat[32493:64984],
                      surfL = lh_pial,
                      surfR = rh_pial,
                      HCP_32k_auto_mwall = TRUE)

view_xifti_surface(overlap_x, color_mode = 'qualitative')
view_xifti_surface(overlap_x)



### comparison with yeo networks


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


dbis7_colors <- c("#00760E",
                  "#E69422",
                  "#4682B4",
                  "#781286",
                  "#CD3E4E",
                  "#DCF8A4",
                  "#C43AFA")
  
group_mat <- read_mat('/Users/ew198/Documents/individual_fns/full_sample/group/group.mat')

group_mat$lh.labels[group_mat$lh.labels == 0] <- NA
group_mat$rh.labels[group_mat$rh.labels == 0] <- NA

group_mat_x<- as.xifti(cortexL = group_mat$lh.labels,
                       cortexR = group_mat$rh.labels,
                       surfL = lh_very_inflated,
                       surfR = rh_very_inflated,
                       HCP_32k_auto_mwall = TRUE)

view_xifti_surface(group_mat_x, color_mode = 'qualitative', colors = dbis_colors)


### 7 network

group7_mat <- read_mat('/Users/ew198/Documents/individual_fns/full_sample/seven_network/group.mat')

group7_mat$lh.labels[group7_mat$lh.labels == 0] <- NA
group7_mat$rh.labels[group7_mat$rh.labels == 0] <- NA

group7_x <- as.xifti(cortexL = group7_mat$lh.labels,
                      cortexR = group7_mat$rh.labels,
                      surfL = lh_very_inflated,
                      surfR = rh_very_inflated,
                      HCP_32k_auto_mwall = TRUE)

view_xifti_surface(group7_x, color_mode = 'qualitative', colors = dbis7_colors)

## yeo templates

yeo_colors <- read.csv('/Users/ew198/Documents/individual_fns/yeo17_colors.csv', header = FALSE)
yeo_rgb <- yeo_colors[,3:5]
colnames(yeo_rgb) <- c("red", "green", "blue")
yeo_colors <- rgb2col(t(yeo_rgb))

yeo7_colors <- read.csv('/Users/ew198/Documents/individual_fns/yeo7_colors.csv', header = TRUE)
colnames(yeo7_colors) <- c("red", "green", "blue")
yeo7_colors <- rgb2col(t(yeo7_colors))

yeo17 <- read_cifti('/Users/ew198/Documents/CBIG-master/stable_projects/brain_parcellation/Yeo2011_fcMRI_clustering/1000subjects_reference/Yeo_JNeurophysiol11_SplitLabels/fs_LR32k/Yeo2011_17Networks_N1000.dlabel.nii')

yeo17$data$cortex_left[yeo17$data$cortex_left == 0] <- NA
yeo17$data$cortex_right[yeo17$data$cortex_right == 0] <- NA

yeo17_x<- as.xifti(cortexL = yeo17$data$cortex_left,
                   cortexR = yeo17$data$cortex_right,
                   surfL = lh_very_inflated,
                   surfR = rh_very_inflated,
                   HCP_32k_auto_mwall = TRUE)

view_xifti_surface(yeo17_x, color_mode = 'qualitative', colors = yeo_colors)

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



pallette <- data.frame(colors=c("#CD3E4E",
                       "#778CB0",
                       "#4682B4",
                       "#FF98D5",
                       "#781286",
                       "#87324A",
                       "#2ACCA4",
                       "#0C30FF",
                       "#E69422",
                       "#FFFF01",
                       "#C43AFA",
                       "#4A9B3C",
                       "#FF0101",
                       "#C8F8A4",
                       "#010182",
                       "#7A8732",
                       "#01760E"),
                       
                       networks=c()
                       )

view_xifti_surface(yeo17_x, color_mode = 'qualitative', colors = dbis_colors)


my_hist <- ggplot(diamonds, aes(clarity, fill = cut)) + 
  geom_bar() 

