#!/bin/bash

for mcf_file in $*; do
    lmp_file=${mcf_file/mcf_particles/lmp_dump.}
    awk -f mcf2lammps.awk pass=1 ${mcf_file} pass=2 ${mcf_file} > ${lmp_file}
    printf "file: %s was created\n" ${lmp_file} > "/dev/stderr"
done

