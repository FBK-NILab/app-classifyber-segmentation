[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-bl.app.265-blue.svg)](https://doi.org/10.25663/brainlife.app.265)

# app-classifyber-segmentation
Code to run Classifyber as a pre-trained bundle segmentation method. Classifyber is a supervised streamline-based method that performs automatic bundle segmentation by learning from example bundles already segmented, and that is robust to a multitude of diverse settings, i.e. that can deal with different bundle sizes, tracking algorithms, and dMRI data qualities. Classifyber is based on binary linear classification, which simultaneously combines information from bundle geometries, connectivity patterns and atlases. 

![](graphical_abstract_classifyber.png)

### Authors
- Giulia Bertò (giulia.berto.4@gmail.com)

### Contributors
- Emanuele Olivetti (olivetti@fbk.eu)

### Funding 
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-1636893](https://img.shields.io/badge/NSF_BCS-1636893-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-AOC-1916518](https://img.shields.io/badge/NSF_AOC-1916518-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1916518)

### Reference
"Classifyber, a robust streamline-based linear classifier for white matter bundle segmentation", Bertò, G., Bullock, D., Astolfi, P., Hayashi, S., Zigiotto, L., Annicchiarico, L., Corsini, F., De
Benedictis, A., Sarubbo, S., Pestilli, F., Avesani, P., Olivetti, E. https://www.biorxiv.org/content/10.1101/2020.02.10.942714v1

## Running the app
### On [BrainLife.io](http://brainlife.io/) 
You can submit this App online at https://doi.org/10.25663/brainlife.app.265 via the “Execute” tab.

Inputs: \
You only need to provide the tractogram of the (target) subject you want to extract the bundle(s) from and the anatomical T1 of the (target) subject. WARNING: the tractogram needs to be already co-registered in the MNI152 T1 space.  

Output: \
You will get the wmc segmentation of the bundle(s) of interest in the target subject. You can convert it in muliple .tck files with the app https://doi.org/10.25663/brainlife.app.251.

Branch 1.0: \
You can choose the bundle(s) to be segmented by providing the id(s) related to the traiining results you want to use as follows: 

HCP-IFOF: \
32 - Left IFOF \
33 - Right IFOF

HCP-minor: \
38 - Left pArc \
39 - Right pArc \
40 - Left TP-SPL \
41 - Right TP-SPL \
42 - Left MdLF-SPL \
43 - Right MdLF-SPL \
44 - Left MdLF-Ang \
45 - Right MdLF-Ang 

### Running locally
1. git clone this repo.
2. Inside the cloned directory, create `config.json` with something like the following content with paths to your input files:
```
{
  "tractogram_static": "./track.tck",
  "t1_static": "./t1.nii.gz"
}
```
3. Launch the App by executing `main`.
```
./main
```

#### Dependencies
This App requires [singularity](https://sylabs.io/singularity/) to run. If you don’t have singularity, you will need to install following dependencies. It also requires [jq](https://stedolan.github.io/jq/).
