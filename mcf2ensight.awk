BEGIN {
    fbase = "lmp_dump.00000000.out"

    type_decode[0]=1
    type_decode[-5]=2
    type_decode[-6]=2
    type_decode[1]=3
    type_decode[2]=4

    var_string = "id type x y z vx vy vz rho_peratom"
    var_n      = split(var_string, var_array, " ")
}

pass==1 && NF {
    natom++
}

pass==1 {
    next
}

pass==2 && !flag {
    flag = 1

    printf "ITEM: TIMESTEP\n"
    printf "0\n"
    printf "ITEM: NUMBER OF ATOMS\n"
    printf "%i\n", natom
    printf "ITEM: BOX BOUNDS pp pp pp\n"
    printf "0 10.75\n"
    printf "0 10.75\n"
    printf "-10.0 10.0\n"
    printf "ITEM: ATOMS id type x y z vx vy vz c_rho_peratom\n"
}

pass==2 && flag && NF {
#    printf "%i 1 0.0000000000000000e+00 0.0000000000000000e+00 1.0000000000000000e+00 %-1.16e %-1.16e 0.0000000000000000e+00 0 0 0\n", ++n, $1, $2
    x =  $1;  y = $2;  z = $3
    vx = $4; vy = $5; vz = $6
    c_rho_peratom = $7
    c_mass        = $8
    id            = int($9)
    mcf_type      = int($10)
    type          = type_decode[mcf_type]
    printf "%i %i %g %g %g %g %g %g %g\n", id, type, x, y, z, vx, vy, vz, c_rho_peratom
    # print int($9)
}

function generate_case(                i) {
    printf "# Ensight case file\n" > fbase ".case"
    printf "\n"  >> fbase ".case"
    printf "FORMAT\n" >> fbase ".case"
    printf "type: ensight gold\n" >> fbase ".case"
    printf "\n"  >> fbase ".case"
    printf "GEOMETRY\n" >> fbase ".case"
    printf "model: 1 1 lmp_dump.00000000.out.xyz\n" >> fbase ".case"
    printf "\n"  >> fbase ".case"
    printf "VARIABLE\n" >> fbase ".case"
    for (i=1; i<=var_n; i++) {
	printf "scalar per node: 1 1 %s lmp_dump.00000000.out.%s\n", var_array[i], var_array[i] >> fbase ".case"
    }
    printf "\n"  >> fbase ".case"
    printf "TIME\n" >> fbase ".case"
    printf "time set: 1\n" >> fbase ".case"
    printf "number of steps: 2\n" >> fbase ".case"
    printf "filename start number: 0\n" >> fbase ".case"
    printf "filename increment: 1\n" >> fbase ".case"
    printf "time values:\n" >> fbase ".case"
    printf "0 1\n" >> fbase ".case"
    printf "\n"  >> fbase ".case"
    printf "FILE\n" >> fbase ".case"
    printf "file set: 1\n" >> fbase ".case"
    printf "number of steps: 2\n" >> fbase ".case"
}

END {
    generate_case()
}

