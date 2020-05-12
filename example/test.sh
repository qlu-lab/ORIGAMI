
./ORIGAMI.sh -c ASD \
-f bcf/chr#.test.bcf.gz \
-b <your bcftool path> \
-l snplist.txt \
-h <Your R library> \
-e <male genetic map file> \ 
-t <female genetic map file> \
-s extract -r test_ref.txt

# Do parallel on this step. parallel the fatherID and motherID
./ORIGAMI.sh -c ASD -s gamete \
-d <Directory contains your 'cohort' folder (optional)>
-b <Your bcf tool path> \
-h <R library (optional)>  \
-l snplist.txt -p 11002_4262850670_A -m 11002_4262850624_A \
-e <male genetic map file> \ 
-t <female genetic map file> \
-i 11002 -n 5


./ORIGAMI.sh -c ASD -s gamete \
-d <Directory contains your 'cohort' folder (optional)>
-b <Your bcf tool path> \
-h <R library (optional)>  \
-l snplist.txt -p 11002_4262850670_A -m 11002_4262850624_A \
-e <male genetic map file> \ 
-t <female genetic map file> \
-i 11006 -n 5

./ORIGAMI.sh -c ASD -s gamete \
-d <Directory contains your 'cohort' folder (optional)>
-b <Your bcf tool path> \
-h <R library (optional)> \ 
-l snplist.txt -p 11002_4262850670_A -m 11002_4262850624_A \
-e <male genetic map file> \ 
-t <female genetic map file> \
-i 11008 -n 5


./ORIGAMI.sh -c ASD -s combine \
-d <Directory contains your 'cohort' folder (optional)>
-b <Your bcf tool path> \
-h <R library (optional)> \ 
-i famList_test.txt \
-r test_ref.txt -n 5 \
-k <plink path> \
-o test_bfile
