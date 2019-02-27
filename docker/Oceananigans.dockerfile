# Build with: docker build -t oceananigans -f Oceananigans.dockerfile .
# Run with:   docker run -P -it --rm oceananigans
# Find port with: docker ps --format "{{.Image}}: {{.Ports}}" | grep oceananigans | awk '{print $2}' | sed s/'[^:]*\:\([0-9]*\)-.*/\1/'

# FROM julia@sha256:c13bc0b99ab003de993078fdf70481bc0fd500ebf1d38968d89d32db6905a446
FROM julia:latest

RUN apt-get update && apt-get install -y gfortran mpich libmpich-dev less vim wget bzip2 procps git net-tools screen ffmpeg hdf5-tools
RUN mkdir -p /home/jlab
RUN ( cd /home/jlab; wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh )
RUN ( cd /home/jlab; chmod +x  ./Miniconda3-latest-Linux-x86_64.sh; ./Miniconda3-latest-Linux-x86_64.sh -b -p `pwd`/miniconda3 )
RUN ( cd /home/jlab; export PATH="`pwd`/miniconda3/bin:$PATH"; conda create -y -n myconda -c conda-forge python=3.6 dask distributed xarray jupyterlab mpi4py matplotlib basemap pillow )
RUN ( cd /home/jlab; export PATH="`pwd`/miniconda3/bin:$PATH"; /bin/bash -c "source activate myconda; julia -e 'using Pkg;Pkg.add(\"IJulia\");using IJulia'" )

EXPOSE 8888

ENV JROOT=/home/jlab
ENV CGIT=https://github.com/climate-machine/Oceananigans.jl
CMD ( cd ${JROOT} ; git clone ${CGIT}; export PATH="`pwd`/miniconda3/bin:$PATH"; /bin/bash -c "source activate myconda; cd Oceananigans.jl; jupyter lab --ip `hostname -I` --allow-root" )
