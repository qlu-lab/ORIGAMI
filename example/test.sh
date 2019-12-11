
./ORIGAMI.sh -c ASD \
-f /z/Comp/lu_group/Members/jiawen/software/test/bcf/chr#.test.bcf.gz \
-b /z/Comp/lu_group/Software/bcftools-1.8/bin \
-l ./test/snplist.txt \
-h /z/Comp/lu_group/Software/Rlibs -e /z/Comp/lu_group/Resource/GeneticMap/Refined_EUR_genetic_map_b37/male_chr#.txt \
-t /z/Comp/lu_group/Resource/GeneticMap/Refined_EUR_genetic_map_b37/female_chr#.txt \
-s extract -r /z/Comp/lu_group/Members/jiawen/ASD/ASD_base.txt

# Do parallel on this step. parallel the fatherID and motherID
./ORIGAMI.sh -c ASD -s gamete \
-f /z/Comp/lu_group/Members/jiawen/software \
-b /z/Comp/lu_group/Software/bcftools-1.8/bin \
-l ./test/snplist.txt -p 11002_4262850670_A -m 11002_4262850624_A \
-h /z/Comp/lu_group/Software/Rlibs -e /z/Comp/lu_group/Resource/GeneticMap/Refined_EUR_genetic_map_b37/male_chr#.txt \
-t /z/Comp/lu_group/Resource/GeneticMap/Refined_EUR_genetic_map_b37/female_chr#.txt \
-i 11002 -n 5


./ORIGAMI.sh -c ASD -s gamete \
-d /z/Comp/lu_group/Members/jiawen/software \
-b /z/Comp/lu_group/Software/bcftools-1.8/bin \
-l ./test/snplist.txt -p 11006_4265073076_A -m 11006_4265073431_A \
-h /z/Comp/lu_group/Software/Rlibs -e /z/Comp/lu_group/Resource/GeneticMap/Refined_EUR_genetic_map_b37/male_chr#.txt \
-t /z/Comp/lu_group/Resource/GeneticMap/Refined_EUR_genetic_map_b37/female_chr#.txt \
-i 11006 -n 5

./ORIGAMI.sh -c ASD -s gamete \
-d /z/Comp/lu_group/Members/jiawen/software \
-b /z/Comp/lu_group/Software/bcftools-1.8/bin \
-l ./test/snplist.txt -p 11008_4265073045_A -m 11008_4262850503_A \
-h /z/Comp/lu_group/Software/Rlibs -e /z/Comp/lu_group/Resource/GeneticMap/Refined_EUR_genetic_map_b37/male_chr#.txt \
-t /z/Comp/lu_group/Resource/GeneticMap/Refined_EUR_genetic_map_b37/female_chr#.txt \
-i 11008 -n 5


./ORIGAMI.sh -c ASD -s combine \
-d /z/Comp/lu_group/Members/jiawen/software \
-b /z/Comp/lu_group/Software/bcftools-1.8/bin \
-h /z/Comp/lu_group/Software/Rlibs \
-i /z/Comp/lu_group/Members/jiawen/software/test/famList_test.txt \
-r /z/Comp/lu_group/Members/jiawen/ASD/ASD_base.txt -n 5 \
-k /z/Comp/lu_group/Software/plink/plink_1.9_linux_x86_64 \
-o test_bfile
