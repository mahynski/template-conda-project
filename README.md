Project Name
---
1. Insert description here.
2. Rename repo with a 4 digit year-of-completion prefix, e.g., "2022-"; this can be updated later. Convention is to use hyphens between words and all lower case.
3. Create a [conda](https://www.anaconda.com/) environment for this project.  First modify `conda-env.yml` to include the relevant repositories and dependencies needed; also give the environment a good name (e.g., similar or same as this repo). Then create the environment (see below).

Installation
---
Set up the conda environment for this project.
```code
$ conda env create -f conda-env.yml
```

Contributors
---
Update the CITATION.cff file to enable appropriate citations.  

Versioning
---
Create a "published" branch to correspond to the repo when the associated paper is published.  Subsequent branches, such as "revision-YYYY-MM-DD" can be created later.  Also use [zenodo](https://zenodo.org/) to facilitate easy citation, if desired, and point it to the "published" branch.  This leaves the main branch as the latest version which can be updated as needed.

Associated Publications
---
[LINK TO MANUSCIPT]()
