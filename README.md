How To Use
---

<img src="logo.png" align="right" width=200 />

1. Use this repo as a template to create a new repo on GitHub. Name the repo with a 4 digit year-of-initiation prefix, e.g., "2022-". Convention is to use hyphens between words and all lower case. You can also "copy" the repo by cloning, creating a new origin, then pushing to it. This can be used to, e.g., migrate to a GitLab server.
   ~~~bash
   $ git clone git@github.com:mahynski/template-conda-project.git ./2022-my-new-project
   $ git remote -v # Check origin
   $ git remote set-url origin git@gitlab.mycompany.com:user.name/2022-my-new-project # Update to new origin
   $ git remote -v # Confirm new origin
   $ git push -u origin main # Push to new endpoint
   ~~~
3. Insert description here.
4. Clone your new repo locally to get started. Create a [conda](https://www.anaconda.com/) environment for this project.  First modify `conda-env.yml` to include the relevant repositories and dependencies needed; also give the environment a good name (e.g., similar or same as this repo) - the default is "project-env". Then create the environment (see below).
5. If you do not want to work in a development container, skip to "Local Installation" to use a conda environment on your local machine.
6. Otherwise, a Docker [dev container](https://code.visualstudio.com/docs/devcontainers/containers) template for [VS Code](https://code.visualstudio.com/) is provided in the `.devcontainer/` folder.  This creates a [miniconda](https://docs.anaconda.com/miniconda/) container and installs the environment specified in `conda-env.yml` into the default IPython kernel in the container. To use:
   * Change the `UID` and `GID` in `.devcontainer/Dockerfile` if needed.
   * Optional: If you want to connect to other containers, e.g., running ollama for code assitance in [Continue](https://docs.continue.dev/), you might need to consider [Docker networking](https://docs.docker.com/engine/network/tutorials/standalone/). You can skip this in which case ollama will bind to your localhost at your chosen port on the default "bridge" network, which is acceptable on personal devices. Moreover, the default `devcontainer.json` file specifies `"--network=host"` in `runArgs` which uses the host networking when the container is running, which sould enable this automatically.
   * Add [additional arguments](https://containers.dev/implementors/json_reference/) as needed, e.g., "runArgs": ["--gpus", "all"] to [access host gpus](https://stackoverflow.com/questions/25185405/using-gpu-from-a-docker-container). This is helpful if you are doing deep learning in the container/project. You may have to install the appropriate drivers first.
   * Change the name of the conda environment (default="project-env") in the `conda-env.yml` and files in .devcontainer/.
   * Install the "Dev Containers" Extension in VS Code.
   * First `git clone` this repo, then [open the folder in the container](https://code.visualstudio.com/docs/devcontainers/containers#_quick-start-open-an-existing-folder-in-a-container) by selecting "Dev Containers: Open Folder in Container" from the Command Palette.
   * From a terminal in VS Code, (1) navigate to your desired starting point (`data/analysis` is recommended), then (2) run `$ bash /path/to/.devcontainer/start_jupyter.sh` to launch a Jupyter server (forwarded on port 1234 by default) from the head of the repo.  The default kernel contains the `conda-env.yml` packages but is not renamed.
   * MLFlow: From a terminal in VS Code run `$ bash /path/to/.devcontainer/start_mlflow.sh` (uri is 127.0.0.1:1235 by default). The logs are stored in an sqlite database in `.devcontainer/mlflow/mlruns.db`. 

### Setup SSH Keys

If you are using this inside a devcontainer you will need to add an ssh key to push changes directly back to your Git account. Follow the instructions below inside your container, OR commit/push changes from a terminal outside of your container.

~~~bash
$ ssh-keygen -t ed25519 # Create a key - press enter each time you are prompted
$ cat ~/.ssh/id_ed25519.pub # Copy the contents of this file 
~~~

Go to `User settings > SSH Keys` on your GitLab account or `User > Settings > SSH and GPG Keys` on GitHub. Click `Add new key` and copy the contents above into the `Key` area.  Give it a title and expiration date, then click `Add key`.

Local Installation
---

You can easily set up the conda environment for this project on your local (non virtual) machine if you do not want to use a devcontainer. You will need to install the environment in your Jupyter kernel to use it (third command below); this is handled automatically in the devcontainer approach. Change the name of the conda environment (default="project-env") in the `conda-env.yml` if you wish.

```code
$ conda env create -f conda-env.yml
$ conda activate project-env
$ python -m ipykernel install --user --name=project-env
```

Locking the Environment
---

At the end of a project it is good practice to export the entire conda environment for posterity, especially if not working in a development container.

```code
$ conda env export > environment.yml
```

This environment can be recreated later; the `conda-env.yml` file can also be exchanged for this, but I prefer to keep both as a record.
```code
$ conda env create -f environment.yml
```

This works for many cases, but if you need an *exactly reproducible* environment use [conda-lock](https://github.com/conda/conda-lock) instead.

Accessing Endpoints
---
You may need to add a `.cert` file to access certain resources on a local network to avoid a "self-signed certificate" error.  [One solution](https://gist.github.com/anhldbk/8ef2d465152dd4b31429725f4534603f) is to:

~~~bash
$ export SSL_CERT_FILE=/path/to/file.crt
~~~

This `.crt` file can be stored in the `.ignore/` folder if necessary.

Contributors
---

Update the CITATION.cff file to enable appropriate citations.  

The logo for this repository (logo.png) was generated using Google Gemini 2.0 Flash (Imagen 3) on Feb. 19, 2025 with the prompt "Create a logo of a robotic bird being designed and templated by a robot in a factory."

Versioning
---

* Use the [public-template](https://github.com/mahynski/public-template) to create a fresh repo to release the code and details after a project is finished, tag the release, then use zenodo to capture changes to future changes/releases made to that repo, if a public record is desired. That serves as the primary **public** repo which is shared with external parties.
* In addition, create a "published" branch on this repo to correspond to when the associated results/paper/report was first published or shared. This repo is retained as the primary **private** version where future work can be performed. Subsequent branches, such as "revision-YYYY-MM-DD" can be created later and similarly reflected in the public-template version if revisions are necessary. 
