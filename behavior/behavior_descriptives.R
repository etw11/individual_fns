# looking at behavior variables
# 2/2022
library(superheat)
library(ggplot2)
library(gridExtra)
library(dplyr)

load("/Users/ew198/Documents/individual_fns/behavior/Ethan_proj1_sensory45_20211111.rdata")

behavior <- Ethan_proj1_sensory45_20211111

# generate index of behavior
seg <- as.data.frame(read.csv('/Users/ew198/Documents/segregation/dbis_segregation.csv',  header = TRUE))[,2:3]
gid <- unlist(read.delim('/Users/ew198/Documents/individual_fns/behavior/gid_dbis_762.txt', header = FALSE))
gid_snum <- as.numeric(gsub('sub-', '', gid))

index <- behavior$snum %in% gid_snum

behavior_subset <- behavior[index,]

############################## 
######### summary ###########
############################## 

# calculate mean, median, sd, range

# imaging
summary_subset_df <- t(data.frame(n=rep(0, 14), mean=rep(0, 14), median=rep(0, 14), sd=rep(0, 14), min=rep(0, 14), max=rep(0, 14)))
colnames(summary_subset_df) <- colnames(behavior_subset)[3:16]
for (i in 3:16){
  summary_subset_df[1,(i-2)] <- sum(!is.na(behavior_subset[,i]))
  summary_subset_df[2,(i-2)] <- mean(behavior_subset[,i], na.rm = TRUE)
  summary_subset_df[3,(i-2)] <- median(behavior_subset[,i], na.rm = TRUE)
  summary_subset_df[4,(i-2)] <- sd(behavior_subset[,i], na.rm = TRUE)
  summary_subset_df[5,(i-2)] <- min(behavior_subset[,i], na.rm = TRUE)
  summary_subset_df[6,(i-2)] <- max(behavior_subset[,i], na.rm = TRUE)
}

# full
summary_df <- t(data.frame(n=rep(0, 14), mean=rep(0, 14), median=rep(0, 14), sd=rep(0, 14), min=rep(0, 14), max=rep(0, 14)))
colnames(summary_df) <- colnames(behavior)[3:16]
for (i in 3:16){
  summary_df[1,(i-2)] <- sum(!is.na(behavior[,i]))
  summary_df[2,(i-2)] <- mean(behavior[,i], na.rm = TRUE)
  summary_df[3,(i-2)] <- median(behavior[,i], na.rm = TRUE)
  summary_df[4,(i-2)] <- sd(behavior[,i], na.rm = TRUE)
  summary_df[5,(i-2)] <- min(behavior[,i], na.rm = TRUE)
  summary_df[6,(i-2)] <- max(behavior[,i], na.rm = TRUE)
}



############################## 
####### distributions ########
############################## 

### imaging

# motor/gait
bal <- ggplot(data = behavior_subset)+
  geom_histogram(aes(x=balClsMax45))+
  labs(x = 'balance') +
  ylim(0,200) +
  geom_vline(xintercept = mean(behavior_subset$balClsMax45, na.rm=TRUE))
gait <- ggplot(data = behavior_subset)+
  geom_histogram(aes(x=Velocity_avg45))+
  labs(x = 'gait')+
  ylim(0,200)+
  geom_vline(xintercept = mean(behavior_subset$Velocity_avg45, na.rm=TRUE))

# auditory
lisns <- ggplot(data = behavior_subset)+
  geom_histogram(aes(x=lisnslcsrtscp45))+
  labs(x = 'auditory interference (low cue speech threshold)')+
  ylim(0,200)+
geom_vline(xintercept = mean(behavior_subset$lisnslcsrtscp45, na.rm=TRUE))
pta <- ggplot(data = behavior_subset)+
  geom_histogram(aes(x=PTA_4freq_best45))+
  labs(x = 'hearing threshold (pure tone audiometry)')+
  ylim(0,200)+
geom_vline(xintercept = mean(behavior_subset$PTA_4freq_best45, na.rm=TRUE))

# visual
cont_sense <- ggplot(data = behavior_subset)+
  geom_histogram(aes(x=ContrastSens45))+
  labs(x = 'visual contrast sensitivity')+
geom_vline(xintercept = mean(behavior_subset$ContrastSens45, na.rm=TRUE))

# psychopathology
p <- ggplot(data = behavior_subset)+
  geom_histogram(aes(x=P_BF45))+
  labs(x = 'p factor')+
  ylim(0,100)+
geom_vline(xintercept = mean(behavior_subset$P_BF45, na.rm=TRUE))
ext <- ggplot(data = behavior_subset)+
  geom_histogram(aes(x=EXT_CF45))+
  labs(x = 'externalizing')+
  ylim(0,100)+
geom_vline(xintercept = mean(behavior_subset$EXT_CF45, na.rm=TRUE))
int <- ggplot(data = behavior_subset)+
  geom_histogram(aes(x=INT_CF45))+
  labs(x = 'internalizing')+
  ylim(0,100)+
geom_vline(xintercept = mean(behavior_subset$INT_CF45, na.rm=TRUE))
tho <- ggplot(data = behavior_subset)+
  geom_histogram(aes(x=THD_CF45))+
  labs(x = 'thought disorders')+
  ylim(0,100)+
geom_vline(xintercept = mean(behavior_subset$THD_CF45, na.rm=TRUE))

# cognition
iq <- ggplot(data = behavior_subset)+
  geom_histogram(aes(x=fsIQ45_STD))+
  labs(x = 'IQ')+
  ylim(0,120)+
geom_vline(xintercept = mean(behavior_subset$fsIQ45_STD, na.rm=TRUE))
verbal <- ggplot(data = behavior_subset)+
  geom_histogram(aes(x=vci45STD))+
  labs(x = 'verbal comprehension') +
  ylim(0,120)+
geom_vline(xintercept = mean(behavior_subset$vci45STD, na.rm=TRUE))
perceptual <- ggplot(data = behavior_subset)+
  geom_histogram(aes(x=pri45STD))+
  labs(x = 'perceptual reasoning')+
  ylim(0,120)+
geom_vline(xintercept = mean(behavior_subset$pri45STD, na.rm=TRUE))
wm <- ggplot(data = behavior_subset)+
  geom_histogram(aes(x=wmi45STD))+
  labs(x = 'working memory')+
  ylim(0,120)+
geom_vline(xintercept = mean(behavior_subset$wmi45STD, na.rm=TRUE))
psi <- ggplot(data = behavior_subset)+
  geom_histogram(aes(x=psi45STD))+
  labs(x = 'processing speed')+
  ylim(0,120)+
geom_vline(xintercept = mean(behavior_subset$psi45STD, na.rm=TRUE))
  
grid.arrange(bal, 
             gait,
             nrow = 1)
             
grid.arrange(lisns,
             pta,
             nrow = 1)

grid.arrange(cont_sense,
             nrow = 1)

grid.arrange(p,
             ext,
             int,
             tho,
             nrow = 1)

grid.arrange(iq,
             verbal,
             perceptual,
             wm,
             psi,
             nrow = 1)


# full
# motor/gait
bal <- ggplot(data = behavior)+
  geom_histogram(aes(x=balClsMax45))+
  labs(x = 'balance') +
  ylim(0,200) +
  geom_vline(xintercept = mean(behavior$balClsMax45, na.rm=TRUE))
gait <- ggplot(data = behavior)+
  geom_histogram(aes(x=Velocity_avg45))+
  labs(x = 'gait')+
  ylim(0,200)+
  geom_vline(xintercept = mean(behavior$Velocity_avg45, na.rm=TRUE))

# auditory
lisns <- ggplot(data = behavior)+
  geom_histogram(aes(x=lisnslcsrtscp45))+
  labs(x = 'auditory interference (low cue speech threshold)')+
  ylim(0,200)+
  geom_vline(xintercept = mean(behavior$lisnslcsrtscp45, na.rm=TRUE))
pta <- ggplot(data = behavior)+
  geom_histogram(aes(x=PTA_4freq_best45))+
  labs(x = 'hearing threshold (pure tone audiometry)')+
  ylim(0,200)+
  geom_vline(xintercept = mean(behavior$PTA_4freq_best45, na.rm=TRUE))

# visual
cont_sense <- ggplot(data = behavior)+
  geom_histogram(aes(x=ContrastSens45))+
  labs(x = 'visual contrast sensitivity')+
  geom_vline(xintercept = mean(behavior$ContrastSens45, na.rm=TRUE))

# psychopathology
p <- ggplot(data = behavior)+
  geom_histogram(aes(x=P_BF45))+
  labs(x = 'p factor')+
  ylim(0,100)+
  geom_vline(xintercept = mean(behavior$P_BF45, na.rm=TRUE))
ext <- ggplot(data = behavior)+
  geom_histogram(aes(x=EXT_CF45))+
  labs(x = 'externalizing')+
  ylim(0,100)+
  geom_vline(xintercept = mean(behavior$EXT_CF45, na.rm=TRUE))
int <- ggplot(data = behavior)+
  geom_histogram(aes(x=INT_CF45))+
  labs(x = 'internalizing')+
  ylim(0,100)+
  geom_vline(xintercept = mean(behavior$INT_CF45, na.rm=TRUE))
tho <- ggplot(data = behavior)+
  geom_histogram(aes(x=THD_CF45))+
  labs(x = 'thought disorders')+
  ylim(0,100)+
  geom_vline(xintercept = mean(behavior$THD_CF45, na.rm=TRUE))

# cognition
iq <- ggplot(data = behavior)+
  geom_histogram(aes(x=fsIQ45_STD))+
  labs(x = 'IQ')+
  ylim(0,120)+
  geom_vline(xintercept = mean(behavior$fsIQ45_STD, na.rm=TRUE))
verbal <- ggplot(data = behavior)+
  geom_histogram(aes(x=vci45STD))+
  labs(x = 'verbal comprehension') +
  ylim(0,120)+
  geom_vline(xintercept = mean(behavior$vci45STD, na.rm=TRUE))
perceptual <- ggplot(data = behavior)+
  geom_histogram(aes(x=pri45STD))+
  labs(x = 'perceptual reasoning')+
  ylim(0,120)+
  geom_vline(xintercept = mean(behavior$pri45STD, na.rm=TRUE))
wm <- ggplot(data = behavior)+
  geom_histogram(aes(x=wmi45STD))+
  labs(x = 'working memory')+
  ylim(0,120)+
  geom_vline(xintercept = mean(v$wmi45STD, na.rm=TRUE))
psi <- ggplot(data = behavior)+
  geom_histogram(aes(x=psi45STD))+
  labs(x = 'processing speed')+
  ylim(0,120)+
  geom_vline(xintercept = mean(behavior$psi45STD, na.rm=TRUE))

grid.arrange(bal, 
             gait,
             nrow = 1)

grid.arrange(lisns,
             pta,
             nrow = 1)

grid.arrange(cont_sense,
             nrow = 1)

grid.arrange(p,
             ext,
             int,
             tho,
             nrow = 1)

grid.arrange(iq,
             verbal,
             perceptual,
             wm,
             psi,
             nrow = 1)


############################## 
####### correlations #########
############################## 

behavior_vars <- behavior_subset[, c(3:8,12)]
behavior_vars$lisnslcsrtscp45 <- -1*behavior_vars$lisnslcsrtscp45
behavior_vars$PTA_4freq_best45 <- -1*behavior_vars$PTA_4freq_best45

behavior_vars_full <- behavior[, c(3:8,12)]
behavior_vars_full$lisnslcsrtscp45 <- -1*behavior_vars_full$lisnslcsrtscp45
behavior_vars_full$PTA_4freq_best45 <- -1*behavior_vars_full$PTA_4freq_best45



# imaging
behavior_cormat <- rcorr(as.matrix(behavior_vars))$r

superheat(behavior_cormat,
          heat.pal = c("lightblue", "white", "red"),
          heat.pal.values = (c(0,.2,1)),
          bottom.label.text.angle = 90,
          bottom.label.text.size = 2.5,
          left.label.text.size = 3,
          legend.height = 0.05,
          legend.text.size = 10,
          left.label.col = "white", bottom.label.col = "white",
          X.text = round(behavior_cormat, 2)
)

# mask by statistical significance
cormat_significance_index <- rcorr(as.matrix(behavior_vars))$P < 0.001190476

behavior_cormat_masked <- matrix(0, 7, 7)
colnames(behavior_cormat_masked) <- rownames(rcorr(as.matrix(behavior_vars))$r)
rownames(behavior_cormat_masked) <- rownames(rcorr(as.matrix(behavior_vars))$r)
for (i in 1:7){
  for (j in 1:7){
    if (cormat_significance_index[i,j] == TRUE | is.na(cormat_significance_index[i,j])){
      behavior_cormat_masked[i,j] <- behavior_cormat[i,j]
    } else if (cormat_significance_index[i,j] == FALSE){
      behavior_cormat_masked[i,j] <- 0
    }
  }
}

superheat(behavior_cormat,
          heat.pal = c("lightblue", "white", "red"),
          heat.pal.values = (c(0,.2,1)),
          bottom.label.text.angle = 90,
          bottom.label.text.size = 2.5,
          left.label.text.size = 3,
          legend.height = 0.05,
          legend.text.size = 10,
          left.label.col = "white", bottom.label.col = "white",
          X.text = round(behavior_cormat_masked, 2)
)

# full
behavior_cormat_full <- rcorr(as.matrix(behavior_vars_full))$r

superheat(behavior_cormat_full,
         heat.pal = c("lightblue", "white", "red"),
         heat.pal.values = (c(0,.25,1)),
          bottom.label.text.angle = 90,
          bottom.label.text.size = 2.5,
          left.label.text.size = 3,
         legend.height = 0.05,
         legend.text.size = 10,
          left.label.col = "white", bottom.label.col = "white",
          X.text = round(behavior_cormat_full, 2)
)


# mask by statistical significance
cormat_significance_index_full <- rcorr(as.matrix(behavior_vars_full))$P < 0.001190476

behavior_cormat_masked_full <- matrix(0, 7, 7)
colnames(behavior_cormat_masked_full) <- rownames(rcorr(as.matrix(behavior_vars_full))$r)
rownames(behavior_cormat_masked_full) <- rownames(rcorr(as.matrix(behavior_vars_full))$r)
for (i in 1:7){
  for (j in 1:7){
    if (cormat_significance_index_full[i,j] == TRUE | is.na(cormat_significance_index_full[i,j])){
      behavior_cormat_masked_full[i,j] <- behavior_cormat_full[i,j]
    } else if (cormat_significance_index_full[i,j] == FALSE){
      behavior_cormat_masked_full[i,j] <- 0
    }
  }
}

superheat(behavior_cormat_full,
          heat.pal = c("lightblue", "white", "red"),
          heat.pal.values = (c(0,.2,1)),
          bottom.label.text.angle = 90,
          bottom.label.text.size = 2.5,
          left.label.text.size = 3,
          legend.height = 0.05,
          legend.text.size = 10,
          left.label.col = "white", bottom.label.col = "white",
          X.text = round(behavior_cormat_masked_full, 2)
)

# scatterplots


# IQ
iq_p_sp <-  ggplot(data = behavior_subset, aes(x=fsIQ45_STD, y=P_BF45)) +
   geom_point() +
   geom_smooth(method = 'lm') +
  theme_classic()

iq_bal_sp <-  ggplot(data = behavior_subset, aes(x=fsIQ45_STD, y=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

iq_gait_sp <-  ggplot(data = behavior_subset, aes(x=fsIQ45_STD, y=Velocity_avg45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

iq_lisns_sp <-  ggplot(data = behavior_subset, aes(x=fsIQ45_STD, y=-(lisnslcsrtscp45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

iq_pta_sp <-  ggplot(data = behavior_subset, aes(x=fsIQ45_STD, y=-(PTA_4freq_best45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

iq_cont_sense_sp <-  ggplot(data = behavior_subset, aes(x=fsIQ45_STD, y=ContrastSens45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

iq_cont_sense_sp <-  ggplot(data = behavior_subset, aes(x=fsIQ45_STD, y=ContrastSens45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()



# p

p_iq_sp <-  ggplot(data = behavior_subset, aes(y=fsIQ45_STD, x=P_BF45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

p_bal_sp <-  ggplot(data = behavior_subset, aes(x=P_BF45, y=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

p_gait_sp <-  ggplot(data = behavior_subset, aes(x=P_BF45, y=Velocity_avg45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

p_lisns_sp <-  ggplot(data = behavior_subset, aes(x=P_BF45, y=-(lisnslcsrtscp45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

p_pta_sp <-  ggplot(data = behavior_subset, aes(x=P_BF45, y=-(PTA_4freq_best45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

p_cont_sense_sp <-  ggplot(data = behavior_subset, aes(x=P_BF45, y=ContrastSens45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

# cont_sense
cont_sense_iq_sp <-  ggplot(data = behavior_subset, aes(y=fsIQ45_STD, x=ContrastSens45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

cont_sense_p_sp <-  ggplot(data = behavior_subset, aes(y=P_BF45, x=ContrastSens45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

cont_sense_bal_sp <-  ggplot(data = behavior_subset, aes(x=ContrastSens45, y=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

cont_sense_gait_sp <-  ggplot(data = behavior_subset, aes(x=ContrastSens45, y=Velocity_avg45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

cont_sense_lisns_sp <-  ggplot(data = behavior_subset, aes(x=ContrastSens45, y=-(lisnslcsrtscp45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

cont_sense_pta_sp <-  ggplot(data = behavior_subset, aes(x=ContrastSens45, y=-(PTA_4freq_best45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

# pta
pta_iq_sp <-  ggplot(data = behavior_subset, aes(y=fsIQ45_STD, x=-(PTA_4freq_best45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

pta_p_sp <-  ggplot(data = behavior_subset, aes(y=P_BF45, x=-(PTA_4freq_best45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

pta_cont_sense_sp <-  ggplot(data = behavior_subset, aes(y=ContrastSens45, x=-(PTA_4freq_best45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

pta_bal_sp <-  ggplot(data = behavior_subset, aes(x=-(PTA_4freq_best45), y=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

pta_gait_sp <-  ggplot(data = behavior_subset, aes(x=-(PTA_4freq_best45), y=Velocity_avg45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

pta_lisns_sp <-  ggplot(data = behavior_subset, aes(x=-(PTA_4freq_best45), y=-(lisnslcsrtscp45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

# lisns

lisns_iq_sp <-  ggplot(data = behavior_subset, aes(y=fsIQ45_STD, x=-(lisnslcsrtscp45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

lisns_p_sp <-  ggplot(data = behavior_subset, aes(y=P_BF45, x=-(lisnslcsrtscp45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

lisns_cont_sense_sp <-  ggplot(data = behavior_subset, aes(y=ContrastSens45, x=-(lisnslcsrtscp45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

lisns_pta_sp <-  ggplot(data = behavior_subset, aes(y=-(PTA_4freq_best45), x=-(lisnslcsrtscp45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

lisns_bal_sp <-  ggplot(data = behavior_subset, aes(x=-(lisnslcsrtscp45), y=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

lisns_gait_sp <-  ggplot(data = behavior_subset, aes(x=-(lisnslcsrtscp45), y=Velocity_avg45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

# gait

gait_iq_sp <-  ggplot(data = behavior_subset, aes(y=fsIQ45_STD, x=Velocity_avg45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

gait_p_sp <-  ggplot(data = behavior_subset, aes(y=P_BF45, x=Velocity_avg45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

gait_cont_sense_sp <-  ggplot(data = behavior_subset, aes(y=ContrastSens45, x=Velocity_avg45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

gait_pta_sp <-  ggplot(data = behavior_subset, aes(y=-(PTA_4freq_best45), x=Velocity_avg45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

gait_lisns_sp <-  ggplot(data = behavior_subset, aes(y=-(lisnslcsrtscp45), x=Velocity_avg45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

gait_bal_sp <-  ggplot(data = behavior_subset, aes(x=Velocity_avg45, y=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

# bal

bal_gait_sp <-  ggplot(data = behavior_subset, aes(y=Velocity_avg45, x=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

bal_lisns_sp <-  ggplot(data = behavior_subset, aes(y=lisnslcsrtscp45, x=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

bal_pta_sp <-  ggplot(data = behavior_subset, aes(y=-(-(PTA_4freq_best45)), x=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

bal_cont_sense_sp <-  ggplot(data = behavior_subset, aes(y=ContrastSens45, x=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

bal_p_sp <-  ggplot(data = behavior_subset, aes(y=P_BF45, x=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

bal_iq_sp <-  ggplot(data = behavior_subset, aes(y=fsIQ45_STD, x=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

grid.arrange(iq_p_sp,
             iq_bal_sp,
             iq_gait_sp,
             iq_lisns_sp,
             iq_pta_sp,
             iq_cont_sense_sp,
             ncol = 7)

grid.arrange(p_iq_sp,
             p_bal_sp,
             p_gait_sp,
             p_lisns_sp,
             p_pta_sp,
             p_cont_sense_sp,
             ncol = 7)

grid.arrange(bal_iq_sp,
             bal_p_sp,
             bal_gait_sp,
             bal_lisns_sp,
             bal_pta_sp,
             bal_cont_sense_sp,
             ncol = 7)

grid.arrange(gait_iq_sp,
             gait_p_sp,
             gait_bal_sp,
             gait_lisns_sp,
             gait_pta_sp,
             gait_cont_sense_sp,
             ncol = 7)

grid.arrange(lisns_iq_sp,
             lisns_p_sp,
             lisns_bal_sp,
             lisns_gait_sp,
             lisns_pta_sp,
             lisns_cont_sense_sp,
             ncol = 7)

grid.arrange(pta_iq_sp,
             pta_p_sp,
             pta_bal_sp,
             pta_gait_sp,
             pta_lisns_sp,
             pta_cont_sense_sp,
             ncol = 7)

grid.arrange(cont_sense_iq_sp,
             cont_sense_p_sp,
             cont_sense_bal_sp,
             cont_sense_gait_sp,
             cont_sense_lisns_sp,
             cont_sense_pta_sp,
             ncol = 7)



# full

# IQ
iq_p_sp <-  ggplot(data = behavior, aes(x=fsIQ45_STD, y=P_BF45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

iq_bal_sp <-  ggplot(data = behavior, aes(x=fsIQ45_STD, y=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

iq_gait_sp <-  ggplot(data = behavior, aes(x=fsIQ45_STD, y=Velocity_avg45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

iq_lisns_sp <-  ggplot(data = behavior, aes(x=fsIQ45_STD, y=-(lisnslcsrtscp45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

iq_pta_sp <-  ggplot(data = behavior, aes(x=fsIQ45_STD, y=-(PTA_4freq_best45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

iq_cont_sense_sp <-  ggplot(data = behavior, aes(x=fsIQ45_STD, y=ContrastSens45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

iq_cont_sense_sp <-  ggplot(data = behavior, aes(x=fsIQ45_STD, y=ContrastSens45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()



# p

p_iq_sp <-  ggplot(data = behavior, aes(y=fsIQ45_STD, x=P_BF45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

p_bal_sp <-  ggplot(data = behavior, aes(x=P_BF45, y=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

p_gait_sp <-  ggplot(data = behavior, aes(x=P_BF45, y=Velocity_avg45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

p_lisns_sp <-  ggplot(data = behavior, aes(x=P_BF45, y=-(lisnslcsrtscp45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

p_pta_sp <-  ggplot(data = behavior, aes(x=P_BF45, y=-(PTA_4freq_best45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

p_cont_sense_sp <-  ggplot(data = behavior, aes(x=P_BF45, y=ContrastSens45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

# cont_sense
cont_sense_iq_sp <-  ggplot(data = behavior, aes(y=fsIQ45_STD, x=ContrastSens45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

cont_sense_p_sp <-  ggplot(data = behavior, aes(y=P_BF45, x=ContrastSens45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

cont_sense_bal_sp <-  ggplot(data = behavior, aes(x=ContrastSens45, y=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

cont_sense_gait_sp <-  ggplot(data = behavior, aes(x=ContrastSens45, y=Velocity_avg45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

cont_sense_lisns_sp <-  ggplot(data = behavior, aes(x=ContrastSens45, y=-(lisnslcsrtscp45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

cont_sense_pta_sp <-  ggplot(data = behavior, aes(x=ContrastSens45, y=-(PTA_4freq_best45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

# pta
pta_iq_sp <-  ggplot(data = behavior, aes(y=fsIQ45_STD, x=-(PTA_4freq_best45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

pta_p_sp <-  ggplot(data = behavior, aes(y=P_BF45, x=-(PTA_4freq_best45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

pta_cont_sense_sp <-  ggplot(data = behavior, aes(y=ContrastSens45, x=-(PTA_4freq_best45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

pta_bal_sp <-  ggplot(data = behavior, aes(x=-(PTA_4freq_best45), y=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

pta_gait_sp <-  ggplot(data = behavior, aes(x=-(PTA_4freq_best45), y=Velocity_avg45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

pta_lisns_sp <-  ggplot(data = behavior, aes(x=-(PTA_4freq_best45), y=-(lisnslcsrtscp45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

# lisns

lisns_iq_sp <-  ggplot(data = behavior, aes(y=fsIQ45_STD, x=-(lisnslcsrtscp45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

lisns_p_sp <-  ggplot(data = behavior, aes(y=P_BF45, x=-(lisnslcsrtscp45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

lisns_cont_sense_sp <-  ggplot(data = behavior, aes(y=ContrastSens45, x=-(lisnslcsrtscp45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

lisns_pta_sp <-  ggplot(data = behavior, aes(y=-(PTA_4freq_best45), x=-(lisnslcsrtscp45))) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

lisns_bal_sp <-  ggplot(data = behavior, aes(x=-(lisnslcsrtscp45), y=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

lisns_gait_sp <-  ggplot(data = behavior, aes(x=-(lisnslcsrtscp45), y=Velocity_avg45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

# gait

gait_iq_sp <-  ggplot(data = behavior, aes(y=fsIQ45_STD, x=Velocity_avg45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

gait_p_sp <-  ggplot(data = behavior, aes(y=P_BF45, x=Velocity_avg45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

gait_cont_sense_sp <-  ggplot(data = behavior, aes(y=ContrastSens45, x=Velocity_avg45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

gait_pta_sp <-  ggplot(data = behavior, aes(y=-(PTA_4freq_best45), x=Velocity_avg45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

gait_lisns_sp <-  ggplot(data = behavior, aes(y=-(lisnslcsrtscp45), x=Velocity_avg45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

gait_bal_sp <-  ggplot(data = behavior, aes(x=Velocity_avg45, y=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

# bal

bal_gait_sp <-  ggplot(data = behavior, aes(y=Velocity_avg45, x=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

bal_lisns_sp <-  ggplot(data = behavior, aes(y=lisnslcsrtscp45, x=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

bal_pta_sp <-  ggplot(data = behavior, aes(y=-(-(PTA_4freq_best45)), x=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

bal_cont_sense_sp <-  ggplot(data = behavior, aes(y=ContrastSens45, x=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

bal_p_sp <-  ggplot(data = behavior, aes(y=P_BF45, x=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

bal_iq_sp <-  ggplot(data = behavior, aes(y=fsIQ45_STD, x=balClsMax45)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

grid.arrange(iq_p_sp,
             iq_bal_sp,
             iq_gait_sp,
             iq_lisns_sp,
             iq_pta_sp,
             iq_cont_sense_sp,
             ncol = 7)

grid.arrange(p_iq_sp,
             p_bal_sp,
             p_gait_sp,
             p_lisns_sp,
             p_pta_sp,
             p_cont_sense_sp,
             ncol = 7)

grid.arrange(bal_iq_sp,
             bal_p_sp,
             bal_gait_sp,
             bal_lisns_sp,
             bal_pta_sp,
             bal_cont_sense_sp,
             ncol = 7)

grid.arrange(gait_iq_sp,
             gait_p_sp,
             gait_bal_sp,
             gait_lisns_sp,
             gait_pta_sp,
             gait_cont_sense_sp,
             ncol = 7)

grid.arrange(lisns_iq_sp,
             lisns_p_sp,
             lisns_bal_sp,
             lisns_gait_sp,
             lisns_pta_sp,
             lisns_cont_sense_sp,
             ncol = 7)

grid.arrange(pta_iq_sp,
             pta_p_sp,
             pta_bal_sp,
             pta_gait_sp,
             pta_lisns_sp,
             pta_cont_sense_sp,
             ncol = 7)

grid.arrange(cont_sense_iq_sp,
             cont_sense_p_sp,
             cont_sense_bal_sp,
             cont_sense_gait_sp,
             cont_sense_lisns_sp,
             cont_sense_pta_sp,
             ncol = 7)

