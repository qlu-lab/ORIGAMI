# ORIGAMI
`v1.0` Last update: 2020-10-27
## Introduction
ORIGAMI is a framework to simulate pseudo siblings from parental genotype.

## Dependency
This software is developed both in Linux environments. The statistical computing software [R](https://www.r-project.org/) (>=3.5.1) and the following R packages are required for association tests:
* [data.table](https://cran.r-project.org/web/packages/data.table/index.html) (>=1.11.8)
* [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html) (>=0.8.3)
* [tidyverse](https://cran.r-project.org/web/packages/tidyverse/index.html) (>=1.2.1)
* [simcross](https://github.com/kbroman/simcross)

Some tools are also needed.
* [plink](http://zzz.bwh.harvard.edu/plink/)
* [bcftools](http://samtools.github.io/bcftools/bcftools.html)

## Getting started
### File preparation
#### 1. vcf/bcf files
We extract parent genotype from vcf/bcf files. Please seperate your vcf/bcf file by chrormosome.

#### 2. snp list files
We use the snp list file you provided to extract SNPs from vcf/bcf files. The columns are CHR\tBP. Please make sure the build of rsid and BP is same with your vcf/bcf files.
  
Example:
```
1	766007
1	777232
1	901559
1	914852
```

#### 3. sex-specific genetic map files
https://github.com/cbherer/Bherer_etal_SexualDimorphismRecombination
This genetic map is used in our paper.

#### 4. Reference map file.
This file should be a file with header containing SNP, CHR, BP information used to map the BP to rsid. The header must be "SNP", "CHR", "BP". GWAS file is a good option.

#### 5. Installing of the software.
Please install all the softwares in the dependency section. Besides those, you need to download the ORIGAMI.sh and install the ORIGAMI R package.
```
library(devtools)
install_github("qlu-lab/ORIGAMI/ORIGAMI")
```
Also make sure you make the ORIGAMI.sh executable.
```
chmod u+x ORIGAMI.sh
```

### Usage of ORIGAMI
After you finished file and software preparation, you can start to simulate pseudo siblings. There are three steps in the gameting. First, we need to extract the SNP you need from vcf/bcf files. Second, we extract parental genotype and simulate pseudo siblings. Finally, we combine the pseudo sibling genotype and convert them into ped and bfiles.

#### ORIGAMI flags
* -s: step. Must be included.  There are five options you may specify: "gamete", "extract", "combine", "help", "transmission".
* -l: The file name of your SNP list file.
* -p: father ID.
* -m: mother ID.
* -f: The file name of bcf/vcf files. CHR specific. Use # to replace the number of CHR in the file name. 
* -n: number of sibling you want to gamete.
* -c: cohort name. ORIGAMI uses cohort name to create new directory.
* -b: The path of bcftools. This should be `bcftools_path`/bcftools. It should not include "/" at the end.
* -e: The file path of genetic map files of male. CHR specific. Use # to replace the number of CHR in the file name. 
* -t: The file path of genetic map files of male. CHR specific. Use # to replace the number of CHR in the file name. 
* -h: R library path. Optional.
* -i: In step "gamete", i is family ID for one family. In step "combine", i is family ID list.
* -r: File name of reference map file.
* -k: plink software path.
* -o: output file name. The fincal bfiles names you want to specify. Must be included.
* -d: Directory you want to make the new directory containing all the files generated by ORIGAMI.

## 6. Start gameting
### Step 1: Extracting bcf/vcf file
```
./ORIGAMI.sh -c <Your trait name> -s extract \
-f <Your bcf or vcf file name> \
-b <Your bcf tool path> \
-l <SNP list file name> \
-h <R library (optional)> \
-e <male genetic map file>\
-t <female genetic map file> \
-r <Your reference file>
```
### Step 2: Gamete pseudo siblings
```
./ORIGAMI.sh -c ASD -s gamete \
-d <Directory contains your 'cohort' folder (optional)>
-b <Your bcf tool path> \
-l <SNP list file name> \
-p <father ID> -m <mother ID> \
-h <R library (optional)> \
-e <male genetic map file> \ 
-t <female genetic map file> \
-i <family ID> -n <number of pseudo siblings>
```
If you want to gamete pseudo siblings for many couples, please do parallel in this step to save time.

### Step 3: Combine and make bfiles
```
./ORIGAMI.sh -c ASD -s combine \
-d <Directory contains your 'cohort' folder (optional)>
-b <Your bcf tool path> \
-h <R library (optional)> \
-i <family list file>\
-r <Your reference file> \
-k <your plink path> \
-o <your bfile name>
```


## Examples
A brief example is in example/test.sh. Please download the whole example folder and fill the bcftools,R,plink path.

## Citation
Chen J., You J., Zhao Z., Ni Z, Huang K., Wu Y., Fletcher J., Lu Q. (2020). [Gamete simulation improves polygenic transmission disequilibrium analysis.](https://www.biorxiv.org/content/10.1101/2020.10.26.355602v1?rss=1) bioRxiv doi:10.1101/2020.10.26.355602




