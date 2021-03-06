#' meiosis
#'
#' This function is for generate ped files for pseudo babies in the format familyID familyID_i
#' @param ind_data Your cohort name.
#' @param cohort The number of pseudo sibling you gamete
#' @param est_ori_file The path of original est file
#' @param est_new_file The path of processed est file
#' @param num_sibling Number of sibling you gamete
#' @keywords mei
#' @export
#'
#' 
#' 
meiosis <- function(ind_data,cohort,est_ori_file,est_new_file,num_sibling,output_path,
                    interference_number=3){
  ########change here
  data = data.table::fread(ind_data,sep = "\t")
  ##########
  data = tidyr::separate(data = data, col = V2, into = c("V2", "V3"), sep = "\\|")

  map = data.table::fread(est_ori_file,header = T)
  map2 = data.table::fread(est_new_file,header = F)

  meiosis2 <- function(){


    #simulate crossover locations based on all snps
    pos <- simcross::sim_crossovers(map$cM[nrow(map)],m=interference_number)

    #change to physcial distance
    if(length(pos) != 0){
      for (i in 1:length(pos)){
        if(pos[i] >= map2$V3[nrow(map2)]){
          pos[i] = NA
        }else if(pos[i] < map2$V3[1]){
          pos[i] = NA
        }else{
          x = which.max(map2$V3 > pos[i])
          pos[i] = map2$V2[x]

        }
      }
    }
    pos <- pos[!is.na(pos)]
    #print(length(pos))
    #add begin and end pos
    pos <- c(data$V1[1],pos,(data$V1[nrow(data)]+1))


    #decide starting haplotype
    curhap = sample(0:1,1)
    curpos = 1

    #declare gamete vector
    gamete = vector("list",(length(pos)-1))

    #copy alles accordingly
    for (i in 2:length(pos)){
      if(curhap == 0){
        gamete[[i-1]]<- as.list(data[(data$V1 >= pos[i-1])&(data$V1 < pos[i]),2])
      }else{
        gamete[[i-1]]<- as.list(data[(data$V1 >= pos[i-1])&(data$V1 < pos[i]),3])
      }

      curhap = 1- curhap
    }
    g <- unlist(gamete, recursive = T)
    return(g)
  }
  #### 20 simulated children
  G = replicate(num_sibling,meiosis2(),simplify = FALSE)
  ########change here
  data.table::fwrite(G,output_path,sep = "\t",row.names=FALSE,col.names=FALSE,quote =F)
  ################
}

