#!/bin/bash

bash mcf2lammps.sh data/mcf_particles*.out

cd data
PYTHONPATH=~/Pizza.py/src  python ../dump2ensight.py lmp_dump.*.out
