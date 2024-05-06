#!/bin/bash
###these commands give details on the scheduling requirements of the job we want to submit
#SBATCH --account="lp_edu_comparativegenomics" #the account which will be charged for the compute time.
#SBATCH --cluster="genius" #the cluster we will run our workload on, currently only wice is implemented.
#SBATCH -N 1 #the numbers of nodes used, leave this at 1 unless you specifically know how to use multiple nodes.
#SBATCH -n 8 #the number of cpu cores we would like to use one every node.
#SBATCH -t 24:00:00 #the duration our job will run for, shorter times are easier to schedule, but jobs will stop once this timer runs out.
#SBATCH -o ./output/iupred.out #a location to save the console output of our job.

## Make sure you activate the conda environment
export PATH="${VSC_DATA}/miniconda3/bin:${PATH}"
source activate ibp

cd /data/leuven/350/vsc35090/thesis

date
python IUPred_score_calc_frac.py
date

echo "The job was completed."