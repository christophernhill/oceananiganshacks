#!/bin/bash

cnam="oceananigans-"`cat /dev/urandom | env LC_CTYPE=C tr -cd 'a-f0-9' | head -c 32 `
docker run -P -d -it --name ${cnam} --rm oceananigans
sleep 2

# echo $cnam

ctok=`docker logs ${cnam} 2>&1 | grep http | grep token | grep -v LabApp | awk -F/ '{print $4}' `
pnum=`docker ps --format "{{.Names}} {{.Ports}}" | grep ${cnam} | awk '{print $2}' | awk -F: '{print $2}' | awk -F- '{print $1}'`

open -a safari http://localhost:${pnum}/${ctok}

docker logs   $cnam

echo "###########################################################################"
echo "# To run simple test open Julia notebook and execute the following commands"
echo " "

cat <<EOFA
 using Pkg
 Pkg.activate(".")
 Pkg.instantiate()
 using Oceananigans
 Pkg.add("PyPlot")
 Pkg.add("Interact")
 Pkg.add("Plots")
 include("examples/deep_convection_3d.jl")
 deep_convection_3d()
EOFA

echo " "
echo "###########################################################################"

docker attach $cnam
