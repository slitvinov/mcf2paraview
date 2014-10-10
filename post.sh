#!/bin/bash

# where MCF data files are?
dname=data

# MCF to lammps
bash mcf2lammps.sh data/mcf_particles*.out

# lammps to ENSIGHT
cd "${dname}"
PYTHONPATH=~/Pizza.py/src python ../dump2ensight.py lmp_dump.*.out
