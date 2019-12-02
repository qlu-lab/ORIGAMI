# ORIGAMI
`v1.0` Last update: 2019-11-8
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

#### 4. Installing of the software.
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
* s
* l
* p
* m
* f
* n
* c
* b
* e
* t
* h
* i
* r
* k
* o
* d









