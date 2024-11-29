How To Use
---
1. Insert description here.
2. Rename repo with a 4 digit year-of-initiation prefix, e.g., "2022-". Convention is to use hyphens between words and all lower case.
3. Create a [conda](https://www.anaconda.com/) environment for this project.  First modify `conda-env.yml` to include the relevant repositories and dependencies needed; also give the environment a good name (e.g., similar or same as this repo) - the default is "project-env". Then create the environment (see below).
4. If you do not want to work in a development container, skip to "Local Installation" to use a conda environment on your local machine.
5. Otherwise, a Docker [dev container](https://code.visualstudio.com/docs/devcontainers/containers) template for [VS Code](https://code.visualstudio.com/) is provided in the `.devcontainer/` folder.  This creates a [miniconda](https://docs.anaconda.com/miniconda/) container and installs the environment specified in `conda-env.yml` into the default IPython kernel in the container. To use:
   * Change the `UID` and `GID` in `.devcontainer/Dockerfile` if needed.
   * Change the name of the conda environment (default="project-env") in the `conda-env.yml` and files in .devcontainer/.
   * Install the "Dev Containers" Extension in VS Code.
   * First `git clone` this repo, then [open the folder in the container](https://code.visualstudio.com/docs/devcontainers/containers#_quick-start-open-an-existing-folder-in-a-container) by selecting "Dev Containers: Open Folder in Container" from the Command Palette.
   * From a terminal in VS Code, run `$ bash .devcontainer/start_jupyter.sh` to launch a Jupyter server (forwarded on port 1234 by default) from the head of the repo.  The default kernel contains the `conda-env.yml` packages but is not renamed.

Local Installation
---
Set up the conda environment for this project. You will need to install the environment in your Jupyter to use it (third command below). Change the name of the conda environment (default="project-env") in the `conda-env.yml` if you wish.
```code
$ conda env create -f conda-env.yml
$ conda activate project-env
$ python -m ipykernel install --user --name=project-env
```

It is also useful to export the entire conda environment for posterity, especially if not working in a development container.
```code
$ conda env export > environment.yml
```

Contributors
---
Update the CITATION.cff file to enable appropriate citations.  

The logo for this repository (logo.png) was generated using Google Gemini on Nov. 28, 2024 with the prompt "Create a logo for a GitHub repository that is a coding template."

Versioning
---
* Use the [public-template](https://github.com/mahynski/public-template) to create a fresh repo to release the code and details after a manuscript is published, tag the release, then use zenodo to capture changes to future changes/releases made to that repo. This serves as the primary **public facing** repo.
* In addition, create a "published" branch on this repo to correspond to when the associated paper is published. This is retained as the primary **private** repo where future work can be tested. Subsequent branches, such as "revision-YYYY-MM-DD" can be created later and similarly reflected in the public-template version if revisions are necessary. 

Associated Publications
---
[LINK TO MANUSCIPT]()
