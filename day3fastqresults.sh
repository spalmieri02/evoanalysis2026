#!/bin/bash
#SBATCH --job-name day3fastqresults   # give the job a name
#SBATCH -A evoanalysis    # specify the account
#SBATCH -t 0-04:00
#SBATCH --nodes=1                       # how many nodes?
#SBATCH --cpus-per-task=2       # 2 cores
#SBATCH --mem=1G                        # 1 GB memory
#SBATCH --mail-type=ALL         # Send emails on start, fail, completion
#SBATCH --mail-user=spalmie1@uwyo.edu   # specify your email
#SBATCH -e /cluster/medbow/project/evoanalysis/spalmie1/evoanalysis2026/challenge3/day3challengespalmie%A.err
#SBATCH -o /cluster/medbow/project/evoanalysis/spalmie1/evoanalysis2026/challenge3/day3challengespalmie%A.out           #SBATCH --array=1-38
#SBATCH --array=1-38
FASTQ_DIR="/cluster/medbow/project/evoanalysis/spalmie1/evoanalysis2026/challenge3"
OUTDIR="$FASTQ_DIR/fastq_results"

# Get list of FASTQ files
FILES=(${FASTQ_DIR}/*.fastq)

# Select file for this array task
INFILE="${FILES[$SLURM_ARRAY_TASK_ID]}"

# Extract base name without path or extension
BASENAME=$(basename "$INFILE" .fastq)

# Count reads and write output
grep -c "^@" "$INFILE" > "$OUTDIR/${BASENAME}_readcount.txt"
