ID =fread("/z/Comp/lu_group/Members/jiawen/simulation/wtccc_100/script/spark_ID.txt",header=F)
fam = ID[,1]
pro_family = c()
for(i in 1:nrow(ID)){
  if(sum(file.exists(paste0("/z/Comp/lu_group/Members/jiawen/simulation/wtccc_100/combine/",ID$V1[i],"_",1:22,".txt")))!=22
     | sum(file.size(paste0("/z/Comp/lu_group/Members/jiawen/simulation/wtccc_100/combine/",ID$V1[i],"_",1:22,".txt"))
           ==file.size(paste0("/z/Comp/lu_group/Members/jiawen/simulation/wtccc_100/combine/",ID$V1[1],"_",1:22,".txt"))) !=22)
    pro_family = c(pro_family,ID$V1[i])
  if(i %% 100==0){
    print(i)
  }
}
which(ID$V1 == "SF0127645")
fwrite(fam,"/z/Comp/lu_group/Members/jiawen/simulation/wtccc_100/script/spark_fam.txt",
       sep="\t",col.names = F,row.names = F,quote = F)

file.size(paste0("/z/Comp/lu_group/Members/jiawen/simulation/wtccc_100/combine/",ID$V1[20],"_",1:22,".txt"))
