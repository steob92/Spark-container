# Building the Container

Both [Docker](./Dockerfile) and [Apptainer/Singularity](./spark.def) versions are available.

## Docker

To build with docker simply run:
```bash
docker build -t <USERNAME>/spark:latest .
```

Or pull directly from this repo:
```bash
docker pull ghcr.io/steob92/spark-container:v0.1.0
```

Once the build is complete, the container can be run with, for example:
```bash
docker run --rm -it --user `id -u`:`id -g`  -v /path/to/files:/local_files -v /path/to/working_dir:/working_dir -w /working_dir <USERNAME>/spark:latest python script.py /local_files/my_data.yml
```
Or if using this repo:
```bash
docker run --rm -it --user `id -u`:`id -g`  -v /path/to/files:/local_files -v /path/to/working_dir:/working_dir -w /working_dir ghcr.io/steob92/spark-container:v0.1.0 python script.py /local_files/my_data.yml
```


Note `--user \`id -u\`:\`id -g\`` enusres that the user within the docker container has the same permissions as the user. 

Or to start an intervative session:
```bash
docker run --rm -it --user `id -u`:`id -g`  -v /path/to/files:/local_files -v /path/to/working_dir:/working_dir -w /working_dir <USERNAME>/spark:latest bash
```

Using this repo:
```
docker run --rm -it --user `id -u`:`id -g`  -v /path/to/files:/local_files -v /path/to/working_dir:/working_dir -w /working_dir ghcr.io/steob92/spark-container:v0.1.0 bash
```


## Apptainer/Singularity

To build with Apptainer/Singularity simply run:
```bash
apptainer build spark.sif spark.def
```

Once the build is complete, the container can be run with, for example:
```bash
apptainer exec  --bind /path/to/files:/local_files --bind /path/to/working_dir:/working_dir -w /working_dir spark.sif python script.py /local_files/my_data.yml
```
Note many paths are bound by default with apptainer, see [here](https://apptainer.org/docs/user/main/bind_paths_and_mounts.html#system-defined-bind-paths).
If you are working on Digitial Research Alliance of Canada clusters (e.g. Narval/Beluga), the `$HOME`, `$PROJECT` and `$SCRATCH` directories are automatically bound.

Or to start an intervative session:
```bash
apptainer shell  --bind /path/to/files:/local_files --bind /path/to/working_dir:/working_dir -w /working_dir spark.sif
```


## Running Apptainer from Docker

If you have access to both Apptainer and Docker (for example on your own machine), you can create an apptainer image directly from the previously created Docker Image:

```bash
apptainer pull spark_docker.sif docker-daemon:<USERNAME>/spark:latest
```

or pulling directly from github:
```bash
apptainer pull spark_docker.sif docker://ghcr.io/steob92/spark-container:v0.1.0
```
