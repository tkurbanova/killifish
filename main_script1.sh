#make directory 01_qc, in it inputs, outputs, scripts

mkdir 01_qc
cd 01_qc
ln -s ../00_data inputs
mkdir outputs
mkdir scripts

#batch script - qc_script.sh

# request resources from metacentrum - PBS Pro

qsub scripts/qc_script.sh
#or
#qsub ­-l walltime=4:0:0 ­q- default ­l- select=1:ncpus=6:mem=4gb:scratch_local=100gb qc_script.sh



