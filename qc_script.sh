#!/bin/bash
#PBS -l select=1:ncpus=6:mem=4gb:scratch_local=100gb
#PBS -l walltime=4:00:00 
#PBS -m ae

# define a INPUT_DIR and OUTPUT_DIR variable

INPUT_DIR=/storage/brno2/home/tkurbanova/killifish/01_qc/inputs # substitute username and path to to your real username and path

OUTPUT_DIR=/storage/brno2/home/username/tkurbanova/killifish/01_qc/outputs

# move into scratch directory
cd $SCRATCHDIR/

# Add Fastqc module
module add fastQC-0.11.5

# make directory where you will save the output
mkdir $SCRATCHDIR/fastqc

# launch Fastqc on your files 

fastqc --­­threads $PBS_NUM_PPN ­­--outdir $SCRATCHDIR/fastqc $SCRATCHDIR/*$.fastq.gz  || { echo >&2 "Error while Fastqc launching !!"; exit 1; }

# summarize the Fastqc outputs using Multiqc 

module add python27-­modules­-gcc 
multiqc --­­outdir $SCRATCHDIR/fastqc $SCRATCHDIR/fastqc/  || { echo >&2 "Error while summarize the Fastqc outputs using Multiqc !!"; exit 2; }

# move the output to user's OUTPUT_DIR or exit in case of failure
mkdir $OUTPUT_DIR

cp ­-r $SCRATCHDIR/fastqc $OUTPUT_DIR/ || { echo >&2 "Result file(s) copying failed (with a code $?) !!"; exit 3; }

rm ­-r $SCRATCHDIR/*
