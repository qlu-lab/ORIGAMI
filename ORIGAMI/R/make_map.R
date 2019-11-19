### map BP and rsid together
make_map = function(cohort,chr,ref_file,rs_file,output_path){
    data = fread(rs_file,header=T)
    ref = fread(ref_file,header= F)

    #select targeted col for MAP format
    data = data[,c("CHR","SNP","SNP","BP")]

    #select chr
    data = data[which(data$CHR==chr)]

    #correct the order
    data = data[match(ref$V3,data$BP)]

    fwrite(data,output_path,sep = "\t",row.names=FALSE,col.names=FALSE,quote =F)
}
