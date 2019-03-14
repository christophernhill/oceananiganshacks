echo "Downloading and extracting Julia..."
cd ~
wget https://julialang-s3.julialang.org/bin/linux/x64/1.1/julia-1.1.0-linux-x86_64.tar.gz
tar xvf julia-1.1.0-linux-x86_64.tar.gz
mv julia-1.1.0 julia
export PATH=$PATH:~/julia/bin

echo "Cloning and instantiating Oceananigans.jl..."
git clone https://github.com/climate-machine/Oceananigans.jl.git
cd Oceananigans.jl/
julia --project -e "using Pkg; Pkg.instantiate();"

