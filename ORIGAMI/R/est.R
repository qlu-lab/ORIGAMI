est<-function(cohort,estfile,chr,snp_path){
  snps=data.table::fread(snp_path,header = F)
  map2=data.table::fread(estfile)
  map2_po = map2$pos[which(map2$pos>=min(snps$V2[which(snps$V1==chr)]) & map2$pos<=max(snps$V2[which(snps$V1==chr)]))]
  map2_cm = map2$cM[which(map2$pos>=min(snps$V2[which(snps$V1==chr)]) & map2$pos<=max(snps$V2[which(snps$V1==chr)]))]
  chr_li = rep(chr,length(map2_po))
  map2_newd = data.frame(chr = chr_li,po=map2_po,cm = map2_cm)
  data.table::fwrite(map2_newd,
                     paste("/z/Comp/lu_group/Members/jiawen/ASD/est/",cohort,"_",sex,"_chr",chr,".txt",sep=""),quote = F, row.names = F,col.names=F,sep="\t")
}
