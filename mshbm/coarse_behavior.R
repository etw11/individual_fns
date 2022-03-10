## testing network size and gait, auditory discrimination, IQ
## 3/3/2022

library(ggplot2)
library(raveio)
library(ppcor)
library(QuantPsyc)

### LOAD BEHAVIOR
load("/Users/ew198/Documents/individual_fns/behavior/Ethan_proj1_sensory45_20211111.rdata")

behavior <- Ethan_proj1_sensory45_20211111

# generate index of behavior
gid <- unlist(read.delim('/Users/ew198/Documents/individual_fns/behavior/gid_dbis_762.txt', header = FALSE))
gid_snum <- as.numeric(gsub('sub-', '', gid))

index <- behavior$snum %in% gid_snum

behavior_subset <- behavior[index,]

### LOAD HEAD MOTION

head_motion <- read.csv("/Users/ew198/Documents/individual_fns/behavior/fMRI_QC_averageFD.csv", header = TRUE)
head_motion$bidsid <- as.numeric(gsub('sub-', '', head_motion$bidsid ))
motion_index <- head_motion$bidsid %in% gid_snum
motion_subset <- head_motion[motion_index,]

### LOAD CATEGORICAL PARCELLATIONS
setwd("/Users/ew198/Documents/individual_fns/full_sample/categorical")
filenames <- data.frame(mshbmid = c(list.files(".", pattern="*.mat", full.names=TRUE)), 
                        file = c(list.files(".", pattern="*.mat", full.names=TRUE)))
filenames$mshbmid <- gsub('./Ind_parcellation_MSHBM_sub', '', filenames$mshbmid)
filenames$mshbmid <- gsub('_w200_MRF40.mat', '', filenames$mshbmid)
filenames$mshbmid <- as.numeric(filenames$mshbmid)

filenames_sorted <- filenames[order(filenames$mshbmid),]

cat_mat <- matrix(0, 762, 17)
for (i in 1:762) {
  temp <- c(read_mat(filenames_sorted[i,2])$lh.labels, read_mat(filenames_sorted[i,2])$rh.labels)
  for (j in 1:17){
    cat_mat[i,j] <- length(temp[temp == j])
  }
}

network_labels <- c("somatomotor_1",
                       "default_1",
                       "dorsal_attention_1",
                       "somatomotor_4",
                       "default_3",
                       "default_2",
                       "limbic_1",
                       "frontoparietal_3",
                       "visual_2",
                       "frontoparietal_1",
                       "limbic_3",
                       "frontoparietal_2",
                       "visual_1",
                       "somatomotor_3",
                       "somatomotor_2",
                       "ventral_attention_1",
                       "limbic_2")

## create one dataframe

df <- data.frame(motion_subset, cat_mat, behavior_subset)
df_no_outlier <- df[df$X11 < 6000, ]
df_no_outlier <- lapply(df_no_outlier[,-c(1,3,21,22)], scale)
df_no_outlier$sex <- behavior_subset[df$X11 < 6000, ]$sex
df_no_outlier$sex <- as.factor(df_no_outlier$sex)
df <- lapply(df[,-c(1,3,21,22)], scale)
df$sex <- behavior_subset$sex
df$sex <- as.factor(df$sex)


# IQ correlations


iq1  <- summary(lm(data=df, fsIQ45_STD~X1 + sex + AverageFD))
iq2  <- summary(lm(data=df, fsIQ45_STD~X2 + sex + AverageFD))
iq3  <- summary(lm(data=df, fsIQ45_STD~X3 + sex + AverageFD))
iq4  <- summary(lm(data=df, fsIQ45_STD~X4 + sex + AverageFD))
iq5  <- summary(lm(data=df, fsIQ45_STD~X5 + sex + AverageFD))
iq6  <- summary(lm(data=df, fsIQ45_STD~X6 + sex + AverageFD))
iq7  <- summary(lm(data=df, fsIQ45_STD~X7 + sex + AverageFD))
iq8  <- summary(lm(data=df, fsIQ45_STD~X8 + sex + AverageFD))
iq9  <- summary(lm(data=df, fsIQ45_STD~X9 + sex + AverageFD))
iq10 <- summary(lm(data=df, fsIQ45_STD~X10 + sex + AverageFD))
iq11 <- summary(lm(data=df, fsIQ45_STD~X11 + sex + AverageFD))
iq12 <- summary(lm(data=df, fsIQ45_STD~X12 + sex + AverageFD))
iq13 <- summary(lm(data=df, fsIQ45_STD~X13 + sex + AverageFD))
iq14 <- summary(lm(data=df, fsIQ45_STD~X14 + sex + AverageFD))
iq15 <- summary(lm(data=df, fsIQ45_STD~X15 + sex + AverageFD))
iq16 <- summary(lm(data=df, fsIQ45_STD~X16 + sex + AverageFD))
iq17 <- summary(lm(data=df, fsIQ45_STD~X17 + sex + AverageFD))


# gait correlations

gait1  <- summary(lm(data=df, Velocity_avg45~X1 + sex + AverageFD))
gait2  <- summary(lm(data=df, Velocity_avg45~X2 + sex + AverageFD))
gait3  <- summary(lm(data=df, Velocity_avg45~X3 + sex + AverageFD))
gait4  <- summary(lm(data=df, Velocity_avg45~X4 + sex + AverageFD))
gait5  <- summary(lm(data=df, Velocity_avg45~X5 + sex + AverageFD))
gait6  <- summary(lm(data=df, Velocity_avg45~X6 + sex + AverageFD))
gait7  <- summary(lm(data=df, Velocity_avg45~X7 + sex + AverageFD))
gait8  <- summary(lm(data=df, Velocity_avg45~X8 + sex + AverageFD))
gait9  <- summary(lm(data=df, Velocity_avg45~X9 + sex + AverageFD))
gait10 <- summary(lm(data=df, Velocity_avg45~X10 + sex + AverageFD))
gait11 <- summary(lm(data=df, Velocity_avg45~X11 + sex + AverageFD))
gait12 <- summary(lm(data=df, Velocity_avg45~X12 + sex + AverageFD))
gait13 <- summary(lm(data=df, Velocity_avg45~X13 + sex + AverageFD))
gait14 <- summary(lm(data=df, Velocity_avg45~X14 + sex + AverageFD))
gait15 <- summary(lm(data=df, Velocity_avg45~X15 + sex + AverageFD))
gait16 <- summary(lm(data=df, Velocity_avg45~X16 + sex + AverageFD))
gait17 <- summary(lm(data=df, Velocity_avg45~X17 + sex + AverageFD))


# auditory correlations

auditory1  <- summary(lm(data=df, lisnslcsrtscp45~X1 + sex + AverageFD))
auditory2  <- summary(lm(data=df, lisnslcsrtscp45~X2 + sex + AverageFD))
auditory3  <- summary(lm(data=df, lisnslcsrtscp45~X3 + sex + AverageFD))
auditory4  <- summary(lm(data=df, lisnslcsrtscp45~X4 + sex + AverageFD))
auditory5  <- summary(lm(data=df, lisnslcsrtscp45~X5 + sex + AverageFD))
auditory6  <- summary(lm(data=df, lisnslcsrtscp45~X6 + sex + AverageFD))
auditory7  <- summary(lm(data=df, lisnslcsrtscp45~X7 + sex + AverageFD))
auditory8  <- summary(lm(data=df, lisnslcsrtscp45~X8 + sex + AverageFD))
auditory9  <- summary(lm(data=df, lisnslcsrtscp45~X9 + sex + AverageFD))
auditory10 <- summary(lm(data=df, lisnslcsrtscp45~X10 + sex + AverageFD))
auditory11 <- summary(lm(data=df, lisnslcsrtscp45~X11 + sex + AverageFD))
auditory12 <- summary(lm(data=df, lisnslcsrtscp45~X12 + sex + AverageFD))
auditory13 <- summary(lm(data=df, lisnslcsrtscp45~X13 + sex + AverageFD))
auditory14 <- summary(lm(data=df, lisnslcsrtscp45~X14 + sex + AverageFD))
auditory15 <- summary(lm(data=df, lisnslcsrtscp45~X15 + sex + AverageFD))
auditory16 <- summary(lm(data=df, lisnslcsrtscp45~X16 + sex + AverageFD))
auditory17 <- summary(lm(data=df, lisnslcsrtscp45~X17 + sex + AverageFD))


## beta_table

beta_table <- as.data.frame(matrix(0, 17, 3))
colnames(beta_table) <- c("iq", "gait", "auditory")
beta_table$iq <- c(unlist(iq1$coefficients[2,1]),
                   unlist(iq2$coefficients[2,1]),
                   unlist(iq3$coefficients[2,1]),
                   unlist(iq4$coefficients[2,1]),
                   unlist(iq5$coefficients[2,1]),
                   unlist(iq6$coefficients[2,1]),
                   unlist(iq7$coefficients[2,1]),
                   unlist(iq8$coefficients[2,1]),
                   unlist(iq9$coefficients[2,1]),
                   unlist(iq10$coefficients[2,1]),
                   unlist(iq11$coefficients[2,1]),
                   unlist(iq12$coefficients[2,1]),
                   unlist(iq13$coefficients[2,1]),
                   unlist(iq14$coefficients[2,1]),
                   unlist(iq15$coefficients[2,1]),
                   unlist(iq16$coefficients[2,1]),
                   unlist(iq17$coefficients[2,1]))

beta_table$gait <- c(unlist(gait1$coefficients[2,1]),
                   unlist(gait2$coefficients[2,1]),
                   unlist(gait3$coefficients[2,1]),
                   unlist(gait4$coefficients[2,1]),
                   unlist(gait5$coefficients[2,1]),
                   unlist(gait6$coefficients[2,1]),
                   unlist(gait7$coefficients[2,1]),
                   unlist(gait8$coefficients[2,1]),
                   unlist(gait9$coefficients[2,1]),
                   unlist(gait10$coefficients[2,1]),
                   unlist(gait11$coefficients[2,1]),
                   unlist(gait12$coefficients[2,1]),
                   unlist(gait13$coefficients[2,1]),
                   unlist(gait14$coefficients[2,1]),
                   unlist(gait15$coefficients[2,1]),
                   unlist(gait16$coefficients[2,1]),
                   unlist(gait17$coefficients[2,1]))

beta_table$auditory <- c(unlist(auditory1$coefficients[2,1]),
                     unlist(auditory2$coefficients[2,1]),
                     unlist(auditory3$coefficients[2,1]),
                     unlist(auditory4$coefficients[2,1]),
                     unlist(auditory5$coefficients[2,1]),
                     unlist(auditory6$coefficients[2,1]),
                     unlist(auditory7$coefficients[2,1]),
                     unlist(auditory8$coefficients[2,1]),
                     unlist(auditory9$coefficients[2,1]),
                     unlist(auditory10$coefficients[2,1]),
                     unlist(auditory11$coefficients[2,1]),
                     unlist(auditory12$coefficients[2,1]),
                     unlist(auditory13$coefficients[2,1]),
                     unlist(auditory14$coefficients[2,1]),
                     unlist(auditory15$coefficients[2,1]),
                     unlist(auditory16$coefficients[2,1]),
                     unlist(auditory17$coefficients[2,1]))

p_table <- as.data.frame(matrix(0, 17, 3))
colnames(p_table) <- c("iq", "gait", "auditory")
p_table$iq <- c(unlist(iq1$coefficients[2,4]),
                   unlist(iq2$coefficients[2,4]),
                   unlist(iq3$coefficients[2,4]),
                   unlist(iq4$coefficients[2,4]),
                   unlist(iq5$coefficients[2,4]),
                   unlist(iq6$coefficients[2,4]),
                   unlist(iq7$coefficients[2,4]),
                   unlist(iq8$coefficients[2,4]),
                   unlist(iq9$coefficients[2,4]),
                   unlist(iq10$coefficients[2,4]),
                   unlist(iq11$coefficients[2,4]),
                   unlist(iq12$coefficients[2,4]),
                   unlist(iq13$coefficients[2,4]),
                   unlist(iq14$coefficients[2,4]),
                   unlist(iq15$coefficients[2,4]),
                   unlist(iq16$coefficients[2,4]),
                   unlist(iq17$coefficients[2,4]))

p_table$gait <- c(unlist(gait1$coefficients[2,4]),
                     unlist(gait2$coefficients[2,4]),
                     unlist(gait3$coefficients[2,4]),
                     unlist(gait4$coefficients[2,4]),
                     unlist(gait5$coefficients[2,4]),
                     unlist(gait6$coefficients[2,4]),
                     unlist(gait7$coefficients[2,4]),
                     unlist(gait8$coefficients[2,4]),
                     unlist(gait9$coefficients[2,4]),
                     unlist(gait10$coefficients[2,4]),
                     unlist(gait11$coefficients[2,4]),
                     unlist(gait12$coefficients[2,4]),
                     unlist(gait13$coefficients[2,4]),
                     unlist(gait14$coefficients[2,4]),
                     unlist(gait15$coefficients[2,4]),
                     unlist(gait16$coefficients[2,4]),
                     unlist(gait17$coefficients[2,4]))

p_table$auditory <- c(unlist(auditory1$coefficients[2,4]),
                         unlist(auditory2$coefficients[2,4]),
                         unlist(auditory3$coefficients[2,4]),
                         unlist(auditory4$coefficients[2,4]),
                         unlist(auditory5$coefficients[2,4]),
                         unlist(auditory6$coefficients[2,4]),
                         unlist(auditory7$coefficients[2,4]),
                         unlist(auditory8$coefficients[2,4]),
                         unlist(auditory9$coefficients[2,4]),
                         unlist(auditory10$coefficients[2,4]),
                         unlist(auditory11$coefficients[2,4]),
                         unlist(auditory12$coefficients[2,4]),
                         unlist(auditory13$coefficients[2,4]),
                         unlist(auditory14$coefficients[2,4]),
                         unlist(auditory15$coefficients[2,4]),
                         unlist(auditory16$coefficients[2,4]),
                         unlist(auditory17$coefficients[2,4]))

p_table_fdr <- data.frame(
                iq = p.adjust(p_table$iq, method = 'fdr', n = 51),
                gait = p.adjust(p_table$gait, method = 'fdr', n = 51),
                auditory = p.adjust(p_table$auditory, method = 'fdr', n = 51))

rownames(beta_table) <- network_labels
rownames(p_table) <- network_labels
rownames(p_table_fdr) <- network_labels



### scatterplots

##### IQ

iq_resid <- resid(lm(data=df, fsIQ45_STD~sex + AverageFD))

iq_1_p<- ggplot(df[!is.na(df$fsIQ45_STD),], aes(x=X1, y=iq_resid)) +
  geom_point(color=dbis_colors[1]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "IQ (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$fsIQ45_STD),]$X1, df[!is.na(df$fsIQ45_STD),]$fsIQ45_STD, df[!is.na(df$fsIQ45_STD),]$AverageFD) 

iq_2_p <- ggplot(df[!is.na(df$fsIQ45_STD),], aes(x=X2, y=iq_resid)) +
  geom_point(color='black') +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "IQ (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$fsIQ45_STD),]$X2, df[!is.na(df$fsIQ45_STD),]$fsIQ45_STD, df[!is.na(df$fsIQ45_STD),]$AverageFD) 

iq_3_p <- ggplot(df[!is.na(df$fsIQ45_STD),], aes(x=X3, y=iq_resid)) +
  geom_point(color=dbis_colors[3]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "IQ (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$fsIQ45_STD),]$X3, df[!is.na(df$fsIQ45_STD),]$fsIQ45_STD, df[!is.na(df$fsIQ45_STD),]$AverageFD) 

iq_4_p <- ggplot(df[!is.na(df$fsIQ45_STD),], aes(x=X4, y=iq_resid)) +
  geom_point(color=dbis_colors[4]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "IQ (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$fsIQ45_STD),]$X4, df[!is.na(df$fsIQ45_STD),]$fsIQ45_STD, df[!is.na(df$fsIQ45_STD),]$AverageFD) 

iq_5_p <- ggplot(df[!is.na(df$fsIQ45_STD),], aes(x=X5, y=iq_resid)) +
  geom_point(color=dbis_colors[5]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "IQ (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$fsIQ45_STD),]$X5, df[!is.na(df$fsIQ45_STD),]$fsIQ45_STD, df[!is.na(df$fsIQ45_STD),]$AverageFD) 

iq_6_p <- ggplot(df[!is.na(df$fsIQ45_STD),], aes(x=X6, y=iq_resid)) +
  geom_point(color=dbis_colors[6]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "IQ (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$fsIQ45_STD),]$X6, df[!is.na(df$fsIQ45_STD),]$fsIQ45_STD, df[!is.na(df$fsIQ45_STD),]$AverageFD) 

df_no_outlier <- df[!is.na(df$fsIQ45_STD),]
iq_7_p <- ggplot(df[df$X7 < 6000,], aes(x=X7, y=iq_resid[df$X7 < 6000])) +
  geom_point(color='black') +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "iq (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$fsIQ45_STD),]$X7, df[!is.na(df$fsIQ45_STD),]$fsIQ45_STD, df[!is.na(df$fsIQ45_STD),]$AverageFD) 

iq_8_p <- ggplot(df[!is.na(df$fsIQ45_STD),], aes(x=X8, y=iq_resid)) +
  geom_point(color=dbis_colors[8]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "IQ (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$fsIQ45_STD),]$X8, df[!is.na(df$fsIQ45_STD),]$fsIQ45_STD, df[!is.na(df$fsIQ45_STD),]$AverageFD) 

iq_9_p <- ggplot(df[!is.na(df$fsIQ45_STD),], aes(x=X9, y=iq_resid)) +
  geom_point(color=dbis_colors[9]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "IQ (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$fsIQ45_STD),]$X9, df[!is.na(df$fsIQ45_STD),]$fsIQ45_STD, df[!is.na(df$fsIQ45_STD),]$AverageFD) 

iq_10_p <- ggplot(df[!is.na(df$fsIQ45_STD),], aes(x=X10, y=iq_resid)) +
  geom_point(color=dbis_colors[10]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "IQ (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$fsIQ45_STD),]$X10, df[!is.na(df$fsIQ45_STD),]$fsIQ45_STD, df[!is.na(df$fsIQ45_STD),]$AverageFD) 

iq_11_p <- ggplot(df[df$X11 < 6000,], aes(x=X11, y=iq_resid[df$X11 < 6000])) +
  geom_point(color=dbis_colors[11]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "iq (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$fsIQ45_STD),]$X11, df[!is.na(df$fsIQ45_STD),]$fsIQ45_STD, df[!is.na(df$fsIQ45_STD),]$AverageFD) 

iq_12_p <- ggplot(df[!is.na(df$fsIQ45_STD),], aes(x=X12, y=iq_resid)) +
  geom_point(color=dbis_colors[12]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "IQ (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$fsIQ45_STD),]$X12, df[!is.na(df$fsIQ45_STD),]$fsIQ45_STD, df[!is.na(df$fsIQ45_STD),]$AverageFD) 

iq_13_p <- ggplot(df[!is.na(df$fsIQ45_STD),], aes(x=X13, y=iq_resid)) +
  geom_point(color=dbis_colors[13]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "IQ (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$fsIQ45_STD),]$X13, df[!is.na(df$fsIQ45_STD),]$fsIQ45_STD, df[!is.na(df$fsIQ45_STD),]$AverageFD) 

iq_14_p <- ggplot(df[!is.na(df$fsIQ45_STD),], aes(x=X14, y=iq_resid)) +
  geom_point(color=dbis_colors[14]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "IQ (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$fsIQ45_STD),]$X14, df[!is.na(df$fsIQ45_STD),]$fsIQ45_STD, df[!is.na(df$fsIQ45_STD),]$AverageFD) 

iq_15_p <- ggplot(df[!is.na(df$fsIQ45_STD),], aes(x=X15, y=iq_resid)) +
  geom_point(color=dbis_colors[15]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "IQ (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$fsIQ45_STD),]$X15, df[!is.na(df$fsIQ45_STD),]$fsIQ45_STD, df[!is.na(df$fsIQ45_STD),]$AverageFD) 

iq_16_p <- ggplot(df[!is.na(df$fsIQ45_STD),], aes(x=X16, y=iq_resid)) +
  geom_point(color=dbis_colors[16]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "IQ (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$fsIQ45_STD),]$X16, df[!is.na(df$fsIQ45_STD),]$fsIQ45_STD, df[!is.na(df$fsIQ45_STD),]$AverageFD) 

iq_17_p <- ggplot(df[!is.na(df$fsIQ45_STD),], aes(x=X17, y=iq_resid)) +
  geom_point(color=dbis_colors[17]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "IQ (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$fsIQ45_STD),]$X17, df[!is.na(df$fsIQ45_STD),]$fsIQ45_STD, df[!is.na(df$fsIQ45_STD),]$AverageFD) 


grid.arrange(iq_1_p,
             iq_2_p,
             iq_3_p,
             iq_4_p,
             iq_5_p,
             iq_6_p,
             iq_7_p,
             iq_8_p,
             iq_9_p,
             iq_10_p,
             iq_11_p,
             iq_12_p,
             iq_13_p,
             iq_14_p,
             iq_15_p,
             iq_16_p,
             iq_17_p, nrow = 2)


##### GAIT

gait_resid <- resid(lm(data=df, Velocity_avg45~sex + AverageFD))

gait_1_p<- ggplot(df[!is.na(df$Velocity_avg45),], aes(x=X1, y=gait_resid)) +
  geom_point(color=dbis_colors[1]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "gait (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$Velocity_avg45),]$X1, df[!is.na(df$Velocity_avg45),]$Velocity_avg45, df[!is.na(df$Velocity_avg45),]$AverageFD) 

gait_2_p <- ggplot(df[!is.na(df$Velocity_avg45),], aes(x=X2, y=gait_resid)) +
  geom_point(color='dbis_colors[2]') +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "gait (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$Velocity_avg45),]$X2, df[!is.na(df$Velocity_avg45),]$Velocity_avg45, df[!is.na(df$Velocity_avg45),]$AverageFD) 

gait_3_p <- ggplot(df[!is.na(df$Velocity_avg45),], aes(x=X3, y=gait_resid)) +
  geom_point(color=dbis_colors[3]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "gait (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$Velocity_avg45),]$X3, df[!is.na(df$Velocity_avg45),]$Velocity_avg45, df[!is.na(df$Velocity_avg45),]$AverageFD) 

gait_4_p <- ggplot(df[!is.na(df$Velocity_avg45),], aes(x=X4, y=gait_resid)) +
  geom_point(color=dbis_colors[4]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "gait (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$Velocity_avg45),]$X4, df[!is.na(df$Velocity_avg45),]$Velocity_avg45, df[!is.na(df$Velocity_avg45),]$AverageFD) 

gait_5_p <- ggplot(df[!is.na(df$Velocity_avg45),], aes(x=X5, y=gait_resid)) +
  geom_point(color=dbis_colors[5]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "gait (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$Velocity_avg45),]$X5, df[!is.na(df$Velocity_avg45),]$Velocity_avg45, df[!is.na(df$Velocity_avg45),]$AverageFD) 

gait_6_p <- ggplot(df[!is.na(df$Velocity_avg45),], aes(x=X6, y=gait_resid)) +
  geom_point(color=dbis_colors[6]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "gait (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$Velocity_avg45),]$X6, df[!is.na(df$Velocity_avg45),]$Velocity_avg45, df[!is.na(df$Velocity_avg45),]$AverageFD) 

df_no_outlier <- df[!is.na(df$Velocity_avg45),]
gait_7_p <- ggplot(df[df$X7 < 6000,], aes(x=X7, y=gait_resid[df$X7 < 6000])) +
  geom_point(color='black') +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "gait (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$Velocity_avg45),]$X7, df[!is.na(df$Velocity_avg45),]$Velocity_avg45, df[!is.na(df$Velocity_avg45),]$AverageFD) 

gait_8_p <- ggplot(df[!is.na(df$Velocity_avg45),], aes(x=X8, y=gait_resid)) +
  geom_point(color=dbis_colors[8]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "gait (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$Velocity_avg45),]$X8, df[!is.na(df$Velocity_avg45),]$Velocity_avg45, df[!is.na(df$Velocity_avg45),]$AverageFD) 

gait_9_p <- ggplot(df[!is.na(df$Velocity_avg45),], aes(x=X9, y=gait_resid)) +
  geom_point(color=dbis_colors[9]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "gait (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$Velocity_avg45),]$X9, df[!is.na(df$Velocity_avg45),]$Velocity_avg45, df[!is.na(df$Velocity_avg45),]$AverageFD) 

gait_10_p <- ggplot(df[!is.na(df$Velocity_avg45),], aes(x=X10, y=gait_resid)) +
  geom_point(color=dbis_colors[10]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "gait (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$Velocity_avg45),]$X10, df[!is.na(df$Velocity_avg45),]$Velocity_avg45, df[!is.na(df$Velocity_avg45),]$AverageFD) 

gait_11_p <- ggplot(df[df$X11 < 6000,], aes(x=X11, y=gait_resid[df$X11 < 6000])) +
  geom_point(color=dbis_colors[11]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "gait (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$Velocity_avg45),]$X11, df[!is.na(df$Velocity_avg45),]$Velocity_avg45, df[!is.na(df$Velocity_avg45),]$AverageFD) 

gait_12_p <- ggplot(df[!is.na(df$Velocity_avg45),], aes(x=X12, y=gait_resid)) +
  geom_point(color=dbis_colors[12]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "gait (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$Velocity_avg45),]$X12, df[!is.na(df$Velocity_avg45),]$Velocity_avg45, df[!is.na(df$Velocity_avg45),]$AverageFD) 

gait_13_p <- ggplot(df[!is.na(df$Velocity_avg45),], aes(x=X13, y=gait_resid)) +
  geom_point(color=dbis_colors[13]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "gait (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$Velocity_avg45),]$X13, df[!is.na(df$Velocity_avg45),]$Velocity_avg45, df[!is.na(df$Velocity_avg45),]$AverageFD) 

gait_14_p <- ggplot(df[!is.na(df$Velocity_avg45),], aes(x=X14, y=gait_resid)) +
  geom_point(color=dbis_colors[14]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "gait (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$Velocity_avg45),]$X14, df[!is.na(df$Velocity_avg45),]$Velocity_avg45, df[!is.na(df$Velocity_avg45),]$AverageFD) 

gait_15_p <- ggplot(df[!is.na(df$Velocity_avg45),], aes(x=X15, y=gait_resid)) +
  geom_point(color=dbis_colors[15]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "gait (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$Velocity_avg45),]$X15, df[!is.na(df$Velocity_avg45),]$Velocity_avg45, df[!is.na(df$Velocity_avg45),]$AverageFD) 

gait_16_p <- ggplot(df[!is.na(df$Velocity_avg45),], aes(x=X16, y=gait_resid)) +
  geom_point(color=dbis_colors[16]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "gait (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$Velocity_avg45),]$X16, df[!is.na(df$Velocity_avg45),]$Velocity_avg45, df[!is.na(df$Velocity_avg45),]$AverageFD) 

gait_17_p <- ggplot(df[!is.na(df$Velocity_avg45),], aes(x=X17, y=gait_resid)) +
  geom_point(color=dbis_colors[17]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "gait (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$Velocity_avg45),]$X17, df[!is.na(df$Velocity_avg45),]$Velocity_avg45, df[!is.na(df$Velocity_avg45),]$AverageFD) 


grid.arrange(gait_1_p,
             gait_2_p,
             gait_3_p,
             gait_4_p,
             gait_5_p,
             gait_6_p,
             gait_7_p,
             gait_8_p,
             gait_9_p,
             gait_10_p,
             gait_11_p,
             gait_12_p,
             gait_13_p,
             gait_14_p,
             gait_15_p,
             gait_16_p,
             gait_17_p, nrow = 2)


##### AUDITORY

auditory_resid <- resid(lm(data=df, lisnslcsrtscp45~sex + AverageFD))

auditory_1_p<- ggplot(df[!is.na(df$lisnslcsrtscp45),], aes(x=X1, y=auditory_resid)) +
  geom_point(color=dbis_colors[1]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "auditory (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X1, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

auditory_2_p <- ggplot(df[!is.na(df$lisnslcsrtscp45),], aes(x=X2, y=auditory_resid)) +
  geom_point(color=dbis_colors[2]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "auditory (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X2, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

auditory_3_p <- ggplot(df[!is.na(df$lisnslcsrtscp45),], aes(x=X3, y=auditory_resid)) +
  geom_point(color=dbis_colors[3]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "auditory (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X3, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

auditory_4_p <- ggplot(df[!is.na(df$lisnslcsrtscp45),], aes(x=X4, y=auditory_resid)) +
  geom_point(color=dbis_colors[4]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "auditory (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X4, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

auditory_5_p <- ggplot(df[!is.na(df$lisnslcsrtscp45),], aes(x=X5, y=auditory_resid)) +
  geom_point(color=dbis_colors[5]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "auditory (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X5, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

auditory_6_p <- ggplot(df[!is.na(df$lisnslcsrtscp45),], aes(x=X6, y=auditory_resid)) +
  geom_point(color=dbis_colors[6]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "auditory (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X6, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

auditory_7_p <- ggplot(df[!is.na(df$lisnslcsrtscp45),], aes(x=X7, y=auditory_resid)) +
  geom_point(color=dbis_colors[7]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "auditory (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X7, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

auditory_8_p <- ggplot(df[!is.na(df$lisnslcsrtscp45),], aes(x=X8, y=auditory_resid)) +
  geom_point(color=dbis_colors[8]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "auditory (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X8, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

auditory_9_p <- ggplot(df[!is.na(df$lisnslcsrtscp45),], aes(x=X9, y=auditory_resid)) +
  geom_point(color=dbis_colors[9]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "auditory (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X9, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

auditory_10_p <- ggplot(df[!is.na(df$lisnslcsrtscp45),], aes(x=X10, y=auditory_resid)) +
  geom_point(color=dbis_colors[10]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "auditory (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X10, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

auditory_11_p <- ggplot(df[!is.na(df$lisnslcsrtscp45),], aes(x=X11, y=auditory_resid)) +
  geom_point(color=dbis_colors[11]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "auditory (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X11, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

auditory_12_p <- ggplot(df[!is.na(df$lisnslcsrtscp45),], aes(x=X12, y=auditory_resid)) +
  geom_point(color=dbis_colors[12]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "auditory (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X12, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

auditory_13_p <- ggplot(df[!is.na(df$lisnslcsrtscp45),], aes(x=X13, y=auditory_resid)) +
  geom_point(color=dbis_colors[13]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "auditory (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X13, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

auditory_14_p <- ggplot(df[!is.na(df$lisnslcsrtscp45),], aes(x=X14, y=auditory_resid)) +
  geom_point(color=dbis_colors[14]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "auditory (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X14, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

auditory_15_p <- ggplot(df[!is.na(df$lisnslcsrtscp45),], aes(x=X15, y=auditory_resid)) +
  geom_point(color=dbis_colors[15]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "auditory (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X15, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

auditory_16_p <- ggplot(df[!is.na(df$lisnslcsrtscp45),], aes(x=X16, y=auditory_resid)) +
  geom_point(color=dbis_colors[16]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "auditory (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X16, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

auditory_17_p <- ggplot(df[!is.na(df$lisnslcsrtscp45),], aes(x=X17, y=auditory_resid)) +
  geom_point(color=dbis_colors[17]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "auditory (scaled and residualized)") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X17, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 


grid.arrange(auditory_1_p,
             auditory_2_p,
             auditory_3_p,
             auditory_4_p,
             auditory_5_p,
             auditory_6_p,
             auditory_7_p,
             auditory_8_p,
             auditory_9_p,
             auditory_10_p,
             auditory_11_p,
             auditory_12_p,
             auditory_13_p,
             auditory_14_p,
             auditory_15_p,
             auditory_16_p,
             auditory_17_p, nrow = 2)



##### MOTION


motion_1_p<- ggplot(df, aes(x=X1, y=AverageFD)) +
  geom_point(color=dbis_colors[1]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "motion") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X1, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

motion_2_p <- ggplot(df, aes(x=X2, y=AverageFD)) +
  geom_point(color=dbis_colors[2]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "motion") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X2, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

motion_3_p <- ggplot(df, aes(x=X3, y=AverageFD)) +
  geom_point(color=dbis_colors[3]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "motion") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X3, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

motion_4_p <- ggplot(df, aes(x=X4, y=AverageFD)) +
  geom_point(color=dbis_colors[4]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "motion") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X4, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

motion_5_p <- ggplot(df, aes(x=X5, y=AverageFD)) +
  geom_point(color=dbis_colors[5]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "motion") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X5, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

motion_6_p <- ggplot(df, aes(x=X6, y=AverageFD)) +
  geom_point(color=dbis_colors[6]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "motion") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X6, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

motion_7_p <- ggplot(df, aes(x=X7, y=AverageFD)) +
  geom_point(color=dbis_colors[7]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "motion") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X7, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

motion_8_p <- ggplot(df, aes(x=X8, y=AverageFD)) +
  geom_point(color=dbis_colors[8]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "motion") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X8, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

motion_9_p <- ggplot(df, aes(x=X9, y=AverageFD)) +
  geom_point(color=dbis_colors[9]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "motion") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X9, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

motion_10_p <- ggplot(df, aes(x=X10, y=AverageFD)) +
  geom_point(color=dbis_colors[10]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "motion") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X10, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

motion_11_p <- ggplot(df, aes(x=X11, y=AverageFD)) +
  geom_point(color=dbis_colors[11]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "motion") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X11, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

motion_12_p <- ggplot(df, aes(x=X12, y=AverageFD)) +
  geom_point(color=dbis_colors[12]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "motion") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X12, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

motion_13_p <- ggplot(df, aes(x=X13, y=AverageFD)) +
  geom_point(color=dbis_colors[13]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "motion") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X13, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

motion_14_p <- ggplot(df, aes(x=X14, y=AverageFD)) +
  geom_point(color=dbis_colors[14]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "motion") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X14, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

motion_15_p <- ggplot(df, aes(x=X15, y=AverageFD)) +
  geom_point(color=dbis_colors[15]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "motion") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X15, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

motion_16_p <- ggplot(df, aes(x=X16, y=AverageFD)) +
  geom_point(color=dbis_colors[16]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "motion") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X16, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 

motion_17_p <- ggplot(df, aes(x=X17, y=AverageFD)) +
  geom_point(color=dbis_colors[17]) +
  geom_smooth(method = 'lm', color = 'black') +
  labs(x = "network surface area",
       y = "motion") +
  theme_classic()
pcor.test(df[!is.na(df$lisnslcsrtscp45),]$X17, df[!is.na(df$lisnslcsrtscp45),]$lisnslcsrtscp45, df[!is.na(df$lisnslcsrtscp45),]$AverageFD) 


grid.arrange(motion_1_p,
             motion_2_p,
             motion_3_p,
             motion_4_p,
             motion_5_p,
             motion_6_p,
             motion_7_p,
             motion_8_p,
             motion_9_p,
             motion_10_p,
             motion_11_p,
             motion_12_p,
             motion_13_p,
             motion_14_p,
             motion_15_p,
             motion_16_p,
             motion_17_p, nrow = 2)


