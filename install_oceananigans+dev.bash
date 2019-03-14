echo "Installing Julia..."
cd ~
wget https://julialang-s3.julialang.org/bin/linux/x64/1.1/julia-1.1.0-linux-x86_64.tar.gz
tar xvf julia-1.1.0-linux-x86_64.tar.gz
mv julia-1.1.0 julia
export PATH=$PATH:~/julia/bin

echo "Cloning Oceananigans.jl..."
cd ~
git clone https://github.com/climate-machine/Oceananigans.jl.git
cd Oceananigans.jl/
julia --project -e "using Pkg; Pkg.instantiate();"

echo "Installing awesome vimrc..."
cd ~
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

echo "Installing julia-vim..."
cd ~
git clone git://github.com/JuliaEditorSupport/julia-vim.git
cd julia-vim
mkdir -p ~/.vim
cp -R * ~/.vim

echo "Installing ffmpeg..."
cd ~
wget https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz
tar xvf ffmpeg-git-amd64-static.tar.xz
mv ffmpeg-git-*-amd64-static/ ffmpeg/
export PATH=$PATH:~/ffmpeg

read -p "Set up git? [y/n] " setup_git
if [ $setup_git == "y" ]; then
    read -p "Git username: " git_username
    git config --global user.name $git_username
    read -p "Git email: " git_email
    git config --global user.email $git_email
    git config --global core.editor vim
fi
