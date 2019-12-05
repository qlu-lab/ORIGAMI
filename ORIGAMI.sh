#!/bin/bash

while getopts "s:l:p:m:f:n:c:b:e:t:h:i:r:k:o:d:" ARGS
do
        case $ARGS in
                s )
                    case $OPTARG in
                        "gamete"|"extract"|"combine"|"help"|"transmission" )
                            step=$OPTARG;;
                        * )
                            echo "Step $OPTARG undefined."
                            exit;;
                        esac
                        ;;
                f )
                    file=$OPTARG;;
                l )
                    snplist=$OPTARG;;
                c )
                    cohort=$OPTARG;;
                p )
                    fatherID=$OPTARG;;
                m )
                    motherID=$OPTARG ;;
                n )
                    num_sibling=$OPTARG ;;
                b )
                    bcftool_path=$OPTARG;;
                e )
                    est_male=$OPTARG;;
                t )
                    est_female=$OPTARG;;
                h )
                    Rlibpath=$OPTARG
                    export R_LIBS="$Rlibpath";;
                i )
                    familyID=$OPTARG;;
                r )
                    reference_map=$OPTARG;;
                k )
                    plink_path=$OPTARG;;
                d )
                    directory=$OPTARG
                    cd $directory;;
                o )
                    output=$OPTARG;;
                ? )
                    echo "error"
                    exit 1;;
                esac
done


#read from files
if [[ "$step" = "extract" ]];then
echo "Start extract neccessary files...."
mkdir -p ./${cohort}
mkdir -p ./${cohort}/vcf_snp
mkdir -p ./${cohort}/vcf_uniq_snp
mkdir -p ./${cohort}/snps_new
#step 1
##make snplist for vcf/bcf files
#/z/Comp/lu_group/Software/bcftools-1.8/bin/
rm -f ./${cohort}/snps_new/snps.new.txt
echo "start processing SNP files"
for i in {1..22};do
file1=$(echo $file | sed "s/\#/$i/")
${bcftool_path}/bcftools query -f '%CHROM\t%POS\n' $file1 -o ./${cohort}/vcf_snp/ref$i.txt
sort ./${cohort}/vcf_snp/ref$i.txt | uniq -u >  ./${cohort}/vcf_uniq_snp/uniq_chr$i.txt
sort ./${cohort}/vcf_uniq_snp/uniq_chr$i.txt $snplist | uniq -d > ./${cohort}/snps_new/ID$i.txt
cat ./${cohort}/snps_new/ID$i.txt >> ./${cohort}/snps_new/snps.new.txt
echo "SNP file CHR $i done"
done
echo "SNP files done"

echo "Start extract bcf files"
mkdir -p ./${cohort}/bcf_new
for i in {1..22};do
file1=$(echo $file | sed "s/\#/$i/")
${bcftool_path}/bcftools view -T ./${cohort}/snps_new/ID$i.txt $file1 -Ob -o ./${cohort}/bcf_new/chr$i.bcf.gz
echo "CHR $i bcf file finished"
done
echo "bcf file finished"


echo "Start making est files"
mkdir -p ./${cohort}/est
for i in {1..22};do
est_male1=$(echo $est_male | sed "s/\#/$i/")
est_female1=$(echo $est_female | sed "s/\#/$i/")
Rscript -e "library(ORIGAMI);est('$cohort','$est_male1',$i,'./${cohort}/snps_new/snps.new.txt','./${cohort}/est/male_chr$i.txt')"
Rscript -e "library(ORIGAMI);est('$cohort','$est_female1',$i,'./${cohort}/snps_new/snps.new.txt','./${cohort}/est/female_chr$i.txt')"
echo -e "CHR $i finished\r"
done
echo "est files finished"

echo "Start making ref files"
mkdir -p ./${cohort}/others
for i in {1..22};do
${bcftool_path}/bcftools query -f '%CHROM %ID %POS %REF %ALT\n' ./${cohort}/bcf_new/chr$i.bcf.gz -o ./${cohort}/others/ref_chr${i}.txt
echo "ref chr $i finished"
done
echo "ref files finished"

echo "Start making map files..."
mkdir  -p ./${cohort}/map
for i in {1..22};do
Rscript -e "ORIGAMI::make_map(chr='$i',ref_file='./${cohort}/others/ref_chr${i}.txt',rs_file='${reference_map}',output_path = './${cohort}/map/ped_chr$i.map')"
echo "map CHR $i done."
done
echo "map files done."

elif [[ "$step" = "gamete" ]]
then
echo "Start gamete...."
# file indicates for path of cohort
# file, cohort est_male, est_female, fatherID, motherID
cd $file
mkdir -p ./${cohort}/father_bcf
mkdir -p ./${cohort}/mother_bcf
echo "Start extract father/mother files"

for i in {1..22}
do
${bcftool_path}/bcftools view -s $fatherID ./${cohort}/bcf_new/chr$i.bcf.gz | ${bcftool_path}/bcftools query -f '[%POS\t%GT\n]' \
-o ./${cohort}/father_bcf/${fatherID}_${i}.txt
${bcftool_path}/bcftools view -s $motherID ./${cohort}/bcf_new/chr$i.bcf.gz | ${bcftool_path}/bcftools query -f '[%POS\t%GT\n]'  \
-o ./${cohort}/mother_bcf/${motherID}_${i}.txt
echo -e "CHR $i finished\r"
done
echo "father/mother files finished"

echo "start gamete..."
mkdir -p ./${cohort}/gamete
mkdir -p ./${cohort}/gamete/father
mkdir -p ./${cohort}/gamete/mother

for i in {1..22};do
est_male1=$(echo $est_male | sed "s/\#/$i/")
est_female1=$(echo $est_female | sed "s/\#/$i/")
Rscript -e "library(ORIGAMI);meiosis(ind_data='./${cohort}/father_bcf/${fatherID}_${i}.txt',cohort = '$cohort',est_ori_file='$est_male1',est_new_file='./${cohort}/est/male_chr$i.txt',num_sibling=$num_sibling,output_path='./${cohort}/gamete/father/${fatherID}_gamete_${i}.txt')"
Rscript -e "library(ORIGAMI);meiosis(ind_data='./${cohort}/mother_bcf/${motherID}_${i}.txt',cohort = '$cohort',est_ori_file='$est_female1',est_new_file='./${cohort}/est/female_chr$i.txt',num_sibling=$num_sibling,output_path='./${cohort}/gamete/mother/${motherID}_gamete_${i}.txt')"
echo -e "gamete chr $i finished\r"
done
echo -e "gamete finished\r"

mkdir -p ./${cohort}/combine
echo "Start combine..."
for i in {1..22}
do
rm -f ./${cohort}/combine/${familyID}_$i.txt
Rscript -e "library(ORIGAMI);Combine_gametes(cohort='$cohort',father_path='./${cohort}/gamete/father/${fatherID}_gamete_${i}.txt',mother_path='./${cohort}/gamete/mother/${motherID}_gamete_${i}.txt',ref_path='./${cohort}/others/ref_chr${i}.txt',out_path='./${cohort}/combine/${familyID}_$i.txt')"
echo "combine chr $i done"
done
echo "combine files done"

elif [[ "$step" = "combine" ]]
then
echo "Start combine...."
# family ID is here a list of familys not a single family
# file indicates for path of cohort
# file, cohort est_male, est_female, fatherID, motherID
cd $file

mkdir -p ./${cohort}/combine_new
echo "start combine gamete files..."
for i in {1..22};do
rm -f ./${cohort}/combine_new/$i.txt
while read ind; do
cat ./${cohort}/combine/$ind'_'$i.txt >> ./${cohort}/combine_new/$i.txt
done < $familyID
echo "CHR $i done"
done

echo "Start making ped files..."
mkdir  -p ./${cohort}/ped
Rscript -e "library(ORIGAMI);gen_ped(familyID='$familyID',output_path='./${cohort}/ped/ped_chr1.txt',num_sibling=$num_sibling)"

for i in {1..22};do
paste ./${cohort}/ped/ped_chr1.txt ./${cohort}/combine_new/$i.txt > ./${cohort}/ped/${cohort}_chr${i}.ped
done

echo "ped files done."

echo "Convert to bfiles...."
mkdir ./${cohort}/bfile_chr
for i in {1..22};do
$plink_path/plink --no-sex --no-parents --no-pheno --ped  ./${cohort}/ped/${cohort}_chr${i}.ped --map ./${cohort}/map/ped_chr$i.map --make-bed --out ./${cohort}/bfile_chr/${cohort}_${i}
echo "CHR $i finished"
done

rm -f ./${cohort}/others/merge_list.txt
for i in {2..22};do
echo -e "./${cohort}/bfile_chr/${cohort}_${i}.bed\t./${cohort}/bfile_chr/${cohort}_${i}.bim\t./${cohort}/bfile_chr/${cohort}_${i}.fam" >> ./${cohort}/others/merge_list.txt
done

echo "Start merge bfiles..."
mkdir -p ./${cohort}/bfile
$plink_path/plink --bfile ./${cohort}/bfile_chr/${cohort}_1 --merge-list ./${cohort}/others/merge_list.txt  --make-bed --out ./$output

echo "Bfiles done. Path:./${cohort}/bfile/$cohort"

fi
