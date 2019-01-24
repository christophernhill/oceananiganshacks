```Oceananigans.dockerfile``` a Docker spec for a image that sets up Jupyter lab with Julia and git clone
of Oceananigans.

```run.sh``` a bash script that holds commands to launch Docker image that can run Oceananigans in Jupyter lab.

To create Docker image

```
docker build -t oceananigans -f Oceananigans.dockerfile .
```

To launch Juypter session in container using oceananigans image.

```
 ./run.sh
```

the ```run.sh``` script opens browser window that connects to container Jupyterhub session.
