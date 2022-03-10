# testing full sample homogeneity
# 3/2022


setwd('/Users/ew198/Documents/individual_fns/full_sample/homogeneity/ind')
filenames <- list.files(".", pattern="*.mat", full.names=TRUE)
ldf <- lapply(filenames, read_mat)
homo_vec <- array(rep(0, 762*2), dim = c(762,2))
for (i in c(1:762)){
  homo_vec[i,1] <- filenames[i]
  homo_vec[i,2] <- as.numeric(ldf[[i]]$homo.with.weight[1])
}

mean_ind_homo <- mean(as.numeric(homo_vec[,2]))


# calculate for yeo17 parcellation
setwd('/Users/ew198/Documents/individual_fns/full_sample/homogeneity/yeo')
filenames <- list.files(".", pattern="*.mat", full.names=TRUE)
ldf <- lapply(filenames, read_mat)
yeo_homo_vec <- array(rep(0, 762*2), dim = c(762,2))
for (i in c(1:762)){
  yeo_homo_vec[i,1] <- filenames[i]
  yeo_homo_vec[i,2] <- as.numeric(ldf[[i]]$homo.with.weight[1])
}

mean_yeo_homo <- mean(as.numeric(yeo_homo_vec[,2]))



