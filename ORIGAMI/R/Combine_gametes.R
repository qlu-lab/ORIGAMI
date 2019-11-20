#' Combine_gametes
#'
#' This function is for combine father gamete and mother gamete
#' @param cohort Your cohort name.
#' @param father_path The path of your father gamete file
#' @param mother_path The path of your mother gamete file
#' @param ref_path The path of your reference file which contains information about A1, A2, SNP and BP
#' @param out_path The path of output file
#' @keywords combine
#' @export
#'
#' 
Combine_gametes<-function(cohort,father_path,mother_path,ref_path,out_path){
  #gemete files
  f_gamete = data.table::fread(father_path,header = F)
  m_gamete = data.table::fread(mother_path,header = F)

  #no need to change path
  allele = data.table::fread(ref_path,header = F)
  ref = unlist(allele$V4)
  alt = unlist(allele$V5)

  for(i in 1:ncol(f_gamete)){
    #replace allele
    f_gamete[[i]][f_gamete[[i]]==0] = ref[f_gamete[[i]]==0]
    f_gamete[[i]][f_gamete[[i]]==1] = alt[f_gamete[[i]]==1]
    m_gamete[[i]][m_gamete[[i]]==0] = ref[m_gamete[[i]]==0]
    m_gamete[[i]][m_gamete[[i]]==1] = alt[m_gamete[[i]]==1]

    #combine allele
    temp = paste(f_gamete[[i]],m_gamete[[i]])

    #### have to change substr number
    write(temp,file=out_path,sep = "\t",append=T,ncolumns = length(temp))
  }
}
