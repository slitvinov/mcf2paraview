BEGIN {
    # decode MCF types to lammps types (0->1, -5->2, [...])
    type_decode[0]=1
    type_decode[-5]=2
    type_decode[-6]=2
    type_decode[1]=3
    type_decode[2]=4

    # dummy variable for ENSIGHT
    minx=0
    maxx=1

    miny=0
    maxy=1

    minz=0
    maxz=1
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
    printf "%i\n", time_var
    printf "ITEM: NUMBER OF ATOMS\n"
    printf "%i\n", natom
    printf "ITEM: BOX BOUNDS pp pp pp\n"
    printf "%-1.16e %-1.16e\n", minx, maxx
    printf "%-1.16e %-1.16e\n", miny, maxy
    printf "%-1.16e %-1.16e\n", minz, maxz
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
