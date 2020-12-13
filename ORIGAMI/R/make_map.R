#' make_map
#'
#' This function is to generate map files to map BP and rsid together
#' @param chr chromosome number
#' @param ref_file Ref file of your vcf data
#' @param rs_file Reference file contains SNP and BP information
#' @param output_path output file path
#' @keywords map
#' @export
#'
#' 
#' 
make_map = function(chr,ref_file,rs_file,output_path){
  options(stringsAsFactors = F)
    data0 = data.table::fread(rs_file,header=T)
    ref = data.table::fread(ref_file,header= F)

    #select targeted col for MAP format
    data0 =as.data.frame(data0)
    ref = as.data.frame(ref)
    data0 = data0[,c("CHR","SNP","SNP","BP")]

    #select chr
    data0 = data0[which(data0[,c("CHR")]==as.numeric(chr)|
                        data0[,c("CHR")]==paste0("chr",as.numeric(chr))),]
    data0[,c("CHR")]=as.numeric(chr)

    #correct the order
    data0 = data0[match(ref$V3,data0$BP),]
    data.table::fwrite(data0,file=output_path,sep = "\t",row.names=FALSE,col.names=FALSE,quote =F)
}
