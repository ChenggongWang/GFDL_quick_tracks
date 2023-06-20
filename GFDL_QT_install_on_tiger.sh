#!/bin/bash 

###################################################################
#Script Name : GFDL_QT_install_on_tiger.sh 
#Description : 
#Args        : 
#Author      : Chenggong Wang 
#Email       : c.wang@princeton.edu  
###################################################################
set -e
source /etc/profile.d/modules.sh
#install everything in current directory!!!!!!!!!!!!!!!!
ROOT=$PWD


########################
#install udunits
########################
# #download
# wget https://downloads.unidata.ucar.edu/udunits/1.12.11/udunits-1.12.11.tar.gz
# tar -xf udunits-1.12.11.tar.gz
# cd udunits-1.12.11/src
# # install
# module purge
# module load intel/19.1
# export LANG=en_US.utf8
# export LC_ALL=en_US.utf8
# export CC="icc  -fPIC"
# export CPPFLAGS=-DpgiFortran
# #ignore PERL
# export PERL=""
# ./configure --prefix=$ROOT/udunits-1.12.11/
# make
# make install
# ln -s $ROOT/udunits-1.12.11 ~/local/udunits-1.12.11
###############################
#install GFDL_QT
###############################
cd $ROOT
module purge
module load intel/16.0/64/16.0.4.258
module load hdf5/intel-16.0/1.8.16
module load netcdf/intel-16.0/hdf5-1.8.16/4.4.0

mkdir -p  bin
ifort -O2 src/tracker.F90 -o bin/track.exe -I/usr/local/netcdf/intel-16.0/hdf5-1.8.16/4.4.0/include -L/usr/local/netcdf/intel-16.0/hdf5-1.8.16/4.4.0/lib64 -I$ROOT/udunits-1.12.11/include -L$ROOT/udunits-1.12.11/lib -lnetcdf -lnetcdff -lhdf5 -lhdf5_hl -lz -limf -ludunits -lm
