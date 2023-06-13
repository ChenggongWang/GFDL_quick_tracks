#!/bin/bash 

###################################################################
#Script Name : GFDL_QT_install_on_tiger.sh 
#Description : 
#Args        : 
#Author      : Chenggong Wang 
#Email       : c.wang@princeton.edu  
###################################################################

source /etc/profile.d/modules.sh
module purge
module load intel/16.0/64/16.0.4.258
module load hdf5/intel-16.0/1.8.16
module load netcdf/intel-16.0/hdf5-1.8.16/4.4.0
cd GFDL_quick_tracks
mkdir bin
ifort -O2 src/tracker.F90 -o bin/track.exe -I/usr/local/netcdf/intel-16.0/hdf5-1.8.16/4.4.0/include -L/usr/local/netcdf/intel-16.0/hdf5-1.8.16/4.4.0/lib64 -I/tigress/cw55/local/udunits_tiger/udunits-1.12.11/include -L/tigress/cw55/local/udunits_tiger/udunits-1.12.11/lib -lnetcdf -lnetcdff -lhdf5 -lhdf5_hl -lz -limf -ludunits -lm
