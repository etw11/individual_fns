# testing homogeneity from a variety of MRF and group average weights + HCP priors
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


###############################
######### HCP PRIORS ##########
###############################

setwd('/Users/ew198/Documents/individual_fns/test_as_val/homogeneity/time1')
ar_homo <- array(rep(0, 13*10*18), dim = c(13, 10, 18))

for (i in 1:18){
  setwd(as.character(get("i")))
  x <- 1
  for (w in c(80, 90, 100, 110, 120, 130, 140, 160, 180, 200, 210, 220, 230)){
    setwd(as.character(get("w")))
    y <- 1
    for (c in c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)){
      setwd(as.character(get("c")))
    
      filenames <- list.files(".", pattern="*.mat", full.names=TRUE)
      ldf <- lapply(filenames, read_mat)
      ar_homo[x, y, i] <- ldf[[1]]$homo.with.weight[1]
    
      y <- y + 1
    
    setwd("..")
    }
    x <- x + 1
    setwd("..")
  }
  setwd("..")
}

homo_avg <- as.matrix(apply(ar_homo, c(1,2), mean))

colnames(homo_avg) <- c("c10", "c20", "c30", "c40", "c50", "c60", "c70", "c80", "c90", "c100")
rownames(homo_avg) <- c("w80", "w90", "w100", "w110", "w120", "w130", "w140", "w160", "w180", "w200", "w210", "w220", "w230")
  
superheat(homo_avg, 
          membership.rows = c(80, 90, 100, 110, 120, 130, 140, 160, 180, 200, 210, 220, 230),
          membership.cols = c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100),
          left.label.size = .2, bottom.label.size = .25,
          left.label.col = "white", bottom.label.col = "white",
          title = "homogeneity grid search")

# reading HCP40 params final

params_final <- read_mat('/Users/ew198/Documents/CBIG-master/stable_projects/brain_parcellation/Kong2019_MSHBM/lib/group_priors/HCP_40/Params_Final.mat')

dbis_avg <- read_mat('/Users/ew198/Documents/individual_fns/dbis_avg_profile/fs_LR_32k_roifs_LR_900_avg_profile.mat')





###############################
######### DBIS PRIORS #########
###############################

### twosess time 1

setwd('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/homogeneity/time1')
ar_homo_t1 <- array(rep(0, 4*4*19), dim = c(4, 4, 19))

for (i in 1:19){
  setwd(as.character(get("i")))
  x <- 1
  for (w in c(140, 160, 180, 200)){
    setwd(as.character(get("w")))
    y <- 1
    for (c in c(20, 30, 40, 50)){
      setwd(as.character(get("c")))
      
      filenames <- list.files(".", pattern="*.mat", full.names=TRUE)
      ldf <- lapply(filenames, read_mat)
      ar_homo_t1[x, y, i] <- ldf[[1]]$homo.with.weight[1]
      
      y <- y + 1
      
      setwd("..")
    }
    x <- x + 1
    setwd("..")
  }
  setwd("..")
}

homo_avg_t1 <- apply(ar_homo_t1, c(1,2), mean)

superheat(homo_avg_t1, 
          membership.rows = c(140, 160, 180, 200),
          membership.cols = c(20, 30, 40, 50),
          left.label.size = .2, bottom.label.size = .25,
          left.label.col = "white", bottom.label.col = "white",
          title = "homogeneity grid search - time 1")


### twosess time 2


setwd('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/homogeneity/time2')
ar_homo_t2 <- array(rep(0, 4*4*19), dim = c(4, 4, 19))

for (i in 1:19){
  setwd(as.character(get("i")))
  x <- 1
  for (w in c(140, 160, 180, 200)){
    setwd(as.character(get("w")))
    y <- 1
    for (c in c(20, 30, 40, 50)){
      setwd(as.character(get("c")))
      
      filenames <- list.files(".", pattern="*.mat", full.names=TRUE)
      ldf <- lapply(filenames, read_mat)
      ar_homo_t2[x, y, i] <- ldf[[1]]$homo.with.weight[1]
      
      y <- y + 1
      
      setwd("..")
    }
    x <- x + 1
    setwd("..")
  }
  setwd("..")
}

homo_avg_t2 <- apply(ar_homo_t2, c(1,2), mean)

superheat(homo_avg_t2, 
          membership.rows = c(140, 160, 180, 200),
          membership.cols = c(20, 30, 40, 50),
          left.label.size = .2, bottom.label.size = .25,
          left.label.col = "white", bottom.label.col = "white",
          title = "homogeneity grid search - time 2")



### twosess both


setwd('/Users/ew198/Documents/individual_fns/test_as_val_dibsp/homogeneity/twosess')
ar_homo_twosess <- array(rep(0, 4*4*19), dim = c(4, 4, 19))

for (i in 1:19){
  setwd(as.character(get("i")))
  x <- 1
  for (w in c(140, 160, 180, 200)){
    setwd(as.character(get("w")))
    y <- 1
    for (c in c(20, 30, 40, 50)){
      setwd(as.character(get("c")))
      
      filenames <- list.files(".", pattern="*.mat", full.names=TRUE)
      ldf <- lapply(filenames, read_mat)
      ar_homo_twosess[x, y, i] <- ldf[[1]]$homo.with.weight[1]
      
      y <- y + 1
      
      setwd("..")
    }
    x <- x + 1
    setwd("..")
  }
  setwd("..")
}

homo_avg_twosess <- apply(ar_homo_twosess, c(1,2), mean)

superheat(homo_avg_t2, 
          membership.rows = c(140, 160, 180, 200),
          membership.cols = c(20, 30, 40, 50),
          left.label.size = .2, bottom.label.size = .25,
          left.label.col = "white", bottom.label.col = "white",
          title = "homogeneity grid search - time 2")




#### HALF

setwd('/Users/ew198/Documents/individual_fns/half/homogeneity/time1')
ar_homo_half <- array(rep(0, 4*4*9), dim = c(4, 4, 9))

for (i in c(1, 3, 4, 5, 6, 7, 8, 9)){
  setwd(as.character(get("i")))
  x <- 1
  for (w in c(140, 160, 180, 200)){
    setwd(as.character(get("w")))
    y <- 1
    for (c in c(20, 30, 40, 50)){
      setwd(as.character(get("c")))
      
      filenames <- list.files(".", pattern="*.mat", full.names=TRUE)
      ldf <- lapply(filenames, read_mat)
      ar_homo_half[x, y, i] <- ldf[[1]]$homo.with.weight[1]
      
      y <- y + 1
      
      setwd("..")
    }
    x <- x + 1
    setwd("..")
  }
  setwd("..")
}

homo_avg_half <- apply(ar_homo_half, c(1,2), mean)

superheat(homo_avg_t2, 
          membership.rows = c(140, 160, 180, 200),
          membership.cols = c(20, 30, 40, 50),
          left.label.size = .2, bottom.label.size = .25,
          left.label.col = "white", bottom.label.col = "white",
          title = "homogeneity grid search - time 2")


#### ALL PRIORS 100

setwd('/Users/ew198/Documents/individual_fns/all_priors/hundred/homogeneity/time1')

filenames <- list.files(".", pattern="*.mat", full.names=TRUE)
ldf <- lapply(filenames, read_mat)
homo_vec_t1 <- c(rep(0, 19))
for (i in c(1:19)){
homo_vec_t1[i] <- ldf[[i]]$homo.with.weight[1]
}


setwd('/Users/ew198/Documents/individual_fns/all_priors/hundred/homogeneity/time2')

filenames <- list.files(".", pattern="*.mat", full.names=TRUE)
ldf <- lapply(filenames, read_mat)
homo_vec_t2 <- c(rep(0, 19))
for (i in c(1:19)){
  homo_vec_t2[i] <- ldf[[i]]$homo.with.weight[1]
}


### ALL PRIORS 200  

setwd('/Users/ew198/Documents/individual_fns/all_priors/twohundred/homogeneity/time1')

filenames <- list.files(".", pattern="*.mat", full.names=TRUE)
ldf <- lapply(filenames, read_mat)
homo_vec_t1 <- c(rep(0, 19))
for (i in c(1:19)){
  homo_vec_t1[i] <- ldf[[i]]$homo.with.weight[1]
}
