![alt text](banner.png)


This master thesis was conducted at the Switch lab under the supervision of Joost Schymkowitz at the Switch Lab. 

# Description of R files

This is the file with all of the pre-proccessing:

`pre_processing.qmd`

This is where all of the descriptive statistics are.

`description.qmd` 

`localisation.qmd`

This is where all of the stability scores are. 

`half-lives.qmd`

`meltingTemp.qmd`

`iupred.qmd`

Subsets of proteins:

`Bcells.qmd`

Then ageing proteins

And chaperones???


# Extra Data files

`20240321-allPTMs-Human-separateProjects` - the main dataset.

## Normalisation

**Raw files**

`Num_files_per_PXD.csv` - the number of raw files per project

**Protein abundances** 

Protein abundances were downloaded from PaxDb (https://pax-db.org/). The data was downloaded from the following dataset: H.sapiens - Whole organism, SC (Gpm,aug,2014). The file was given the name `protein_abundances.tsv`. The protein names used in PaxDb needed to be mapped to UniProt IDs: `paxdb_mapping.tsv`

**Protein lengths**

Protein lengths (in amino acids) were downloaded from UniProt (https://www.uniprot.org/) and can be found in `protein_lengths_human.tsv`.

## Half-lives

**Half-lives of short-lived proteins:**

Source: 
Rolfs, Zach, et al. ‘An Atlas of Protein Turnover Rates in Mouse Tissues’. Nature Communications, vol. 12, no. 1, Nov. 2021, p. 6778. www.nature.com, https://doi.org/10.1038/s41467-021-26842-3.

The cell line HEK293T was used. 

The file was named `short_lived_proteins_hl.xlsx`

**Half-lives for long-lived proteins:**

Source:
Mathieson, Toby, et al. ‘Systematic Analysis of Protein Turnover in Primary Cells’. Nature Communications, vol. 9, no. 1, Feb. 2018, p. 689. www.nature.com, https://doi.org/10.1038/s41467-018-03106-1.

(The file with protein half-lives from all cell types.)

The file was named `long_proteins_hl_grouped.tsv`

## Melting temperatures

Source: 
Leuenberger, Pascal, et al. ‘Cell-Wide Analysis of Protein Thermal Unfolding Reveals Determinants of Thermostability’. Science, vol. 355, no. 6327, Feb. 2017, p. eaai7825. DOI.org (Crossref), https://doi.org/10.1126/science.aai7825.

(download file: aai7825_leuenberger_table-s3.xlsx)

Melting temperatures for HeLa cells were used. 

The file was renamed to `MeltingTemperatures.xlsx`

## IUPred

In order to get IUPred3 scores that were used in this thesis, the file `IUPred_score_calc_frac.py` needs to be run. The corresponding slurm script can be found here: `iupred.slurm`. The generation of IUPred3 scores requires the file `uniprot_ids_proteins.tsv` as input (this contains the UniProt IDs of the proteins, which scores are to be calculated).

## Localisation

The GO terms for localisations can be found in `localisation_raw.tsv`. the UniProt IDs used to obtain this data can be found in `uniprot_ids_proteins.tsv`.

## Modifications

UniMod IDs of oxPTMs can be found here: `oxPTMs_unimod.txt`. 

The list of oxPTMs was obtained from the study conducted by Devrees, detailed in ‘Elucidating The Protein Oxidation Landscape With Comprehensive Modification Searching’ [38]. The list was originally adapted from ‘Redox proteomics: Chemical principles, methodological approaches and biological/biomedical promises’ conducted by Bachi et al. 

## Generation of additional files

Some additional files are generated in `pre_processing.qmd` in order to decrease the time it takes to process and load datafiles. 

## Analysis

