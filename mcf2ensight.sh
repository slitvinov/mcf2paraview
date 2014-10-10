#!/bin/bash

# where is type in MCF file?
mcf_type_position=10

for mcf_file in $*; do
    # sort MCF file with respect to particle type
    sort -k ${mcf_type_position} -g "${mcf_file}" > "${mcf_file}.sorted"
    printf "file: %s was created\n" "${mcf_file}.sorted" > "/dev/stderr"

    lmp_file=${mcf_file/mcf_particles/lmp_dump.}
    awk -f mcf2lammps.awk pass=1 "${mcf_file}.sorted" pass=2 "${mcf_file}.sorted" > ${lmp_file}
    printf "file: %s was created\n" ${lmp_file} > "/dev/stderr"

done

