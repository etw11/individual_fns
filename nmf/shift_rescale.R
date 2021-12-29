# trying to load in cifti .dtseries file, shift it linearly, and then rescale it to 0 <= x <= 1
# 12/2021
# Ethan Whitman

###### initialization ######
# cluster wb_command path
library(ciftiTools)
ciftiTools.setOption("wb_path", "/cifs/hariri-long/Scripts/Tools/workbench/v1.4.2/bin_rh_linux64")

# set working directory

for (i in 1:784){

  dir_list <- read.delim("/cifs/hariri-long/Projects/ethan/nmf/directory_list_plus19.txt", header = FALSE)
  setwd(as.character(dir_list[i,]))
  setwd("MNINonLinear/Results/GFC_GSR35")
  
  # read in data
  temp <- read_cifti("GFC_GSR35_FIR_Atlas_SHORT.dtseries.nii")
  
  # step 1 - concatenate L/R cortex into one big vector
  
  # each column in temp_concat is a timepoint
  temp_concat <- rbind(temp$data$cortex_left, temp$data$cortex_right)
  
  # step 2 - shift linearly 
  
  minimum <- min(temp_concat)
  
  if (minimum <= 0){
    temp_concat_shift <- temp_concat + abs(minimum)
  } else if (minimum > 0){
    stop("minimum is positive value")
  }
  
  # step 3 - rescale
  
  range01 <- function(x){(x-min(x))/(max(x)-min(x))}
  
  temp_concat_shift_rescale <- range01(temp_concat_shift)
  
  # step 4 - write out cifti file
  
  temp$data$cortex_left <- temp_concat_shift_rescale[1:29696,]
  temp$data$cortex_right <- temp_concat_shift_rescale[29697:59412,]
  
  write_cifti(temp, cifti_fname = "GFC_GSR35_FIR_Atlas_SHORT_SCALED.dtseries.nii")
  
}


