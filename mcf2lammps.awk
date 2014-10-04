BEGIN {
    type_decode[0]=1
    type_decode[-5]=2
    type_decode[-6]=2
    type_decode[1]=3
    type_decode[2]=4

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

