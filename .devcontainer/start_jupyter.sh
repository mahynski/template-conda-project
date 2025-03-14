#!/bin/bash
source /opt/conda/etc/profile.d/conda.sh; # Start a Jupyter Notebook server with no password so we can easily access it
conda activate project-env;
python -m ipykernel install --user --name=project-env; # Can be re-run multiple times
jupyter notebook --port 1234 --ip='*' --NotebookApp.token='' --NotebookApp.password='';
