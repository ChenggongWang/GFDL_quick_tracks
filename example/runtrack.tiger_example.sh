#!/bin/bash --norc

###################################################################
#Script Name : runtrack.tiger.sh
#Description : based on runtrack.sh; configured to tigercpu
#Args        : 
#Author      : Chenggong Wang 
#Email       : c.wang@princeton.edu  
###################################################################
set -e
#set environment
source /etc/profile.d/modules.sh
module purge
module load intel/16.0/64/16.0.4.258
module load hdf5/intel-16.0/1.8.16
module load netcdf/intel-16.0/hdf5-1.8.16/4.4.0

#set directory
workdir=$PWD
#datadir=$PWD/data
if [[ -z ${runname+x} ]] #check if $runname is not set
then
    if [[ $# > 0 ]]
    then
	runname=$1
    else
	runname=example_data
    fi
fi
echo $runname
filenamepattern=${runname}.atmos_4xdaily.nc
output_dir=$workdir

Tracker=/home/cw55/tigress/local/GFDL_QT_tiger/bin/track.exe
Sorter=/home/cw55/tigress/local/GFDL_QT_tiger/python/track_sorter_z1y.py3.py


# get model data files
files=`ls --color=never -1 ${filenamepattern}`
nfiles=`echo $files | wc -w`
files=`ls --color=never -1 $files  | sed 's/^\(.*\)$/"\1"/' | tr '\n' ','`
#echo $files

#create input namelist for tracker
inputname="${workdir}/nml.${runname}-global" 
touch $inputname
cat > $inputname <<EOF
&nlist
    infile = $files
    outfile = '${output_dir}/dat.${runname}-global',
    ncontours = 1,
    warm_core_check = .true.
    cint_slp = 2.
&end
EOF
cat $inputname
# tee for debug purpose
#${Tracker} ${inputname} 2>&1| tee ${workdir}/log.runtrack-${runname}.out 
${Tracker} ${inputname} > ${workdir}/log.runtrack-${runname}.out 2>&1


module load anaconda3
conda activate tcanalysis
python -u ${Sorter} -h 29.5  ${output_dir}/dat.${runname}-global  >> ${workdir}/log.runtrack-${runname}.out

exit

