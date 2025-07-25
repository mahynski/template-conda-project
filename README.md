# Using this Template

## Initial Setup

<img src="logo.png" align="right" width=200 />

1. Use this repo as a template to create a new repo on GitHub. Name the repo with a 4 digit year-of-initiation prefix, e.g., "2022-". Convention is to use hyphens between words and all lower case. You can also "copy" the repo by cloning, creating a new origin, then pushing to it. This can be used to, e.g., migrate to a GitLab server.

   ~~~bash
   $ git clone git@github.com:mahynski/template-conda-project.git ./2022-my-new-project
   $ git remote -v # Check origin
   $ git remote set-url origin git@gitlab.mycompany.com:user.name/2022-my-new-project # Update to new origin
   $ git remote -v # Confirm new origin
   $ git push -u origin main # Push to new endpoint
   ~~~

2. It is recommended that you open this in [VS Code](https://code.visualstudio.com/) and make use of [devcontainers](https://code.visualstudio.com/docs/devcontainers/containers) to create a containerized environment. While not necessary, the tools below are configured for this and work best under this setting.

3. If you do not want to work in a devcontainer the instructions below will simply create a conda environment on your local machine. You will need to [install conda](https://www.anaconda.com/) before proceeding, though. Otherwise, from the Command Palette, select ["Reopen in Container"](https://code.visualstudio.com/docs/devcontainers/containers#_quick-start-open-an-existing-folder-in-a-container) to build your containerized environment with miniconda included. When build, a default conda environment is created from `conda-env.yml`, but you can create more in the future. Here are some details to take care of first:

   * Install the "Dev Containers" Extension in VS Code.
   * Change the `UID` and `GID` in `.devcontainer/Dockerfile` if needed.
   * Optional: If you want to connect to other containers, e.g., running ollama for code assitance in [Continue](https://docs.continue.dev/), you might need to consider [Docker networking](https://docs.docker.com/engine/network/tutorials/standalone/). You can skip this in which case ollama will bind to your localhost at your chosen port on the default "bridge" network, which is acceptable on personal devices. Moreover, the default `devcontainer.json` file specifies `"--network=host"` in `runArgs` which uses the host networking when the container is running, which should enable this automatically.
   * Add [additional arguments](https://containers.dev/implementors/json_reference/) as needed, e.g., "runArgs": ["--gpus", "all"] to [access host gpus](https://stackoverflow.com/questions/25185405/using-gpu-from-a-docker-container). This is helpful if you are doing deep learning in the container/project. You may have to install the appropriate drivers first.
   * Optionally, modify `conda-env.yml` to include the relevant repositories and dependencies needed.
   * Optionally, change the name of the conda environment (default="project-env") in the `conda-env.yml` and files in .devcontainer/.

4. Virtual environments are managed with [conda](https://www.anaconda.com/). By default, a "base" environment created in the root directory that contains Jupyter and MLFlow if you are using a devcontainer. The idea is that these can be executed as independent servers to which other code/process/environments can connect. This base environment in installed automatically when the container is built. You can create other projects with other conda environments as needed; it recommended that you do this in the `projects/` directory.
     
5. If you are using a devcontainer, you can start the Jupyter and MLFlow servers without having to activate any environment (since they are in the base conda environment). The commands below work fine for local installations, but watch for conflicts on the default ports if you are running multiple instances simultaneously. You can change these as needed in the respective `.devcontainer/start_*` files. Do the following from different terminals:

   ~~~bash
   $ bash .devcontainer/start_jupyter.sh # Default is to https://127.0.0.1:1234
   $ bash .devcontainer/start_mlflow.sh # Default is to https://127.0.0.1:1235
   ~~~

## Local Installation

You can easily set up the conda environment for this project on your local (non virtual) machine if you do not want to use a devcontainer. You will need to install the environment in your Jupyter kernel to use it (third command below); this is handled automatically in the devcontainer approach. Change the name of the conda environment (default="project-env") in the `conda-env.yml` if you wish.

~~~bash
$ conda env create -f conda-env.yml
$ conda activate project-env
$ python -m ipykernel install --user --name=project-env
~~~

## Using Conda

### General Philosophy of Projects

["Projects"](https://docs.astral.sh/uv/concepts/projects/) are intended to be sequestered bodies of work organized inside a single root directory. Each has its own virtual environment to manage their dependencies separately from others so you can create different projects as needed, e.g., inside some master `projects/` directory. To create a new project:

~~~bash
$ mkdir projects/new_project
$ cd projects/new_project
$ touch conda-env.yml # Fill this out as desired
$ conda env create -f conda-env.yml
~~~

### Jupyter Kernels

It is recommended that you create independent kernels in Jupyter for each project. This way there is a single installation of Jupyter only single server running.

~~~bash
$ cd projects/new_project
$ conda activate new_project_env # Ensure 'ipykernel' is included in this environment
$ python -m ipykernel install --user --name=project-env
~~~

Anything you install in the notebook will be installed in the environment but will not be reflected in the `conda-env.yml` file.  Anything you install "normally" in this environment, e.g., via `pip install`, will be avilable in Jupyter notebooks running this kernel.

## Setup SSH Keys

If you are using this inside a devcontainer you will need to add an ssh key to push changes directly back to your Git account. Follow the instructions below inside your container, OR commit/push changes from a terminal outside of your container.

~~~bash
$ ssh-keygen -t ed25519 # Create a key - press enter each time you are prompted
$ cat ~/.ssh/id_ed25519.pub # Copy the contents of this file 
~~~

Go to `User settings > SSH Keys` on your GitLab account or `User > Settings > SSH and GPG Keys` on GitHub. Click `Add new key` and copy the contents above into the `Key` area.  Give it a title and expiration date, then click `Add key`.

## Locking the Environment

At the end of a project it is good practice to export the entire conda environment for posterity, especially if not working in a development container.

```code
$ conda env export > environment.yml
```

This environment can be recreated later; the `conda-env.yml` file can also be exchanged for this, but I prefer to keep both as a record.
```code
$ conda env create -f environment.yml
```

This works for many cases, but if you need an *exactly reproducible* environment use [conda-lock](https://github.com/conda/conda-lock) instead.

## Accessing Endpoints

You may need to add a `.cert` file to access certain resources on a local network to avoid a "self-signed certificate" error.  [One solution](https://gist.github.com/anhldbk/8ef2d465152dd4b31429725f4534603f) is to:

~~~bash
$ export SSL_CERT_FILE=/path/to/file.crt
~~~

This `.crt` file can be stored in the `.ignore/` folder if necessary.

## Contributors

Update the CITATION.cff file to enable appropriate citations.  

The logo for this repository (logo.png) was generated using Google Gemini 2.0 Flash (Imagen 3) on Feb. 19, 2025 with the prompt "Create a logo of a robotic bird being designed and templated by a robot in a factory."
