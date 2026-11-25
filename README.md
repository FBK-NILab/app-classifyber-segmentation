[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-bl.app.265-blue.svg)](https://doi.org/10.25663/brainlife.app.265)

# app-classifyber-segmentation

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

> **Segments white matter bundles from a whole-brain tractogram with Classifyber, a pre-trained streamline-based linear classifier, after ANTs registration to MNI152; outputs a WMC classification and per-bundle .tck files.**

Runs only the test phase of Classifyber: the tractogram is registered to the MNI152 T1 template via an ANTs warp computed from the subject T1, then pre-trained classifiers segment the bundles selected by ID (HCP-IFOF, HCP-minor, HCP-major and clinical sets listed in the README) and the result is converted to multiple .tck files. The tractogram and T1 must be in the same space. Classifiers are tuned to tractograms of a given size (for example about 500K streamlines for HCP-minor), so results may be poor otherwise. Use brainlife.app.228 to train on your own examples. This branch runs with Python 3.

| | |
|---|---|
| 📥 **Inputs** | `neuro/track/tck` · `neuro/anat/t1w` |
| 📤 **Outputs** | `neuro/wmc` · `neuro/tcks` |
| 🐳 **Container** | `giuliaberto/ants2-mrtrix3-fsl6:1.1` |
| ⚙️ **Resources** | 16 CPUs · 50 GB memory · 8 h walltime |
| 🔗 **Run it** | [doi.org/10.25663/brainlife.app.265](https://doi.org/10.25663/brainlife.app.265) |

#### 📥 Inputs

| Input | Datatype | Required | Description |
|---|---|---|---|
| `0` | `neuro/track/tck` | yes | Tractogram of static (target) subject |
| `1` | `neuro/anat/t1w` | yes | T1 of static (target) subject |

#### 📤 Outputs

| Output | Datatype | Description |
|---|---|---|
| `output_wmc` | `neuro/wmc` | Segmented bundles in wmc format |
| `output` | `neuro/tcks` | segmented bundles in tck format |

<details>
<summary><b>⚙️ Parameters</b> (1)</summary>

| Parameter | Type | Default | Description |
|---|---|---|---|
| `tractID_list` | string |  | ID list of the bundles of interest, separated by commas, e.g. 32, 40, 45 (refer to the README.md for the mapping) |

</details>

📚 **References used by this App:**
- Berto G et al. Classifyber, a robust streamline-based linear classifier for white matter bundle segmentation. NeuroImage (2020). [doi:10.1016/j.neuroimage.2020.117402](https://doi.org/10.1016/j.neuroimage.2020.117402)
- Avesani P et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. Sci Data 6:69 (2019). [doi:10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)

<!-- brainlife-app:end -->

This App implements only the TEST PHASE of Classifyber, i.e. it runs Classifyber as a pre-trained bundle segmentation method. Classifyber is a supervised streamline-based method that performs automatic bundle segmentation based on binary linear classification, which simultaneously combines information from bundle geometries, connectivity patterns, and atlases. In addition, it is robust to a multitude of diverse settings, i.e. it can deal with different bundle sizes, tracking algorithms, and dMRI data qualities.

![](graphical_abstract_classifyber.png)

If you want to run both the TRAINING and TEST PHASES, please refer to the App https://doi.org/10.25663/brainlife.app.228.

### Authors
- Giulia Bertò (giulia.berto.4@gmail.com)

### Contributors
- Emanuele Olivetti (olivetti@fbk.eu)

### Funding Acknowledgement
We kindly ask that you acknowledge the funding below in your publications and code reusing this code. \
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-1636893](https://img.shields.io/badge/NSF_BCS-1636893-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-AOC-1916518](https://img.shields.io/badge/NSF_AOC-1916518-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1916518)

### Citation
We kindly ask that you cite the following article when publishing papers and code using this code: \
["Classifyber, a robust streamline-based linear classifier for white matter bundle segmentation"](https://doi.org/10.1016/j.neuroimage.2020.117402), Bertò, G., Bullock, D., Astolfi, P., Hayashi, S., Zigiotto, L., Annicchiarico, L., Corsini, F., De Benedictis, A., Sarubbo, S., Pestilli, F., Avesani, P., Olivetti, E. NeuroImage (2020).

## Running the app
### On [Brainlife.io](http://brainlife.io/) 
You can submit this App online at https://doi.org/10.25663/brainlife.app.265 via the “Execute” tab.

#### Branch 1.0:
Inputs: \
You only need to provide the tractogram of the (target) subject you want to extract the bundle(s) from and the anatomical T1 of the (target) subject. WARNING: the tractogram needs to be already co-registered in the MNI152 T1 space (you can use the App https://doi.org/10.25663/brainlife.app.202 to warp your .tck file to the correct anatomical space).

Output: \
You will get the wmc segmentation of the bundle(s) of interest in the target subject. You can convert it in multiple .tck files with the App https://doi.org/10.25663/brainlife.app.251.

You can choose the bundle(s) to be segmented by providing the id(s) related to the training results you want to use as follows: 

HCP-IFOF (WARNING: it might be uneffective if the input tractogram has not ~500K streamlines): \
32 - Left IFOF \
33 - Right IFOF

HCP-minor (WARNING: it might be uneffective if the input tractogram has not ~500K streamlines): \
38 - Left pArc \
39 - Right pArc \
40 - Left TP-SPL \
41 - Right TP-SPL \
42 - Left MdLF-SPL \
43 - Right MdLF-SPL \
44 - Left MdLF-Ang \
45 - Right MdLF-Ang 

#### Branch 1.1:
Inputs: \
You only need to provide the tractogram of the (target) subject you want to extract the bundle(s) from and the anatomical T1 of the (target) subject (the two inputs should be in the same anatomical space). The tractogram will be then internally co-registered to the MNI152 T1 space.

Additional options with respect to branch 1.0:
- initial non-linear registration of the tractogram in the proper MNI152 T1 space
- the output segmented bundles are given also in tck format
- possibility to segment also bundles conforming those of the HCP-major and Clinical datasets as follows:

HCP-major (WARNING: it might be uneffective if the input tractogram has <5M streamlines): \
21 - Left CST \
22 - Right CST \
23 - Left IFOF \
24 - Right IFOF \
25 - Left ILF \
26 - Right ILF \
27 - Left UF \
28 - Right UF \
29 - Left AF \
30 - Right AF

Clinical: (WARNING: it might be uneffective if the input tractogram has >300K streamlines) \
35 - Left IFOF \
36 - Left AF 

#### Branch 1.2:
As branch 1.1 with some small enhancements.

#### Branch 1.3:
As branch 1.2, but running with python3.

### Running locally
1. git clone this repo.
2. Inside the cloned directory, create `config.json` with something like the following content with paths to your input files:
```
{
  "tractogram_static": "./track.tck",
  "t1_static": "./t1.nii.gz",
  "tractID_list": "32, 33, 40, 45"
}
```
3. Launch the App by executing `main`.
```
./main
```

#### Dependencies
This App only requires [singularity](https://sylabs.io/singularity/) to run.

#### MIT Copyright (c) 2020 Bruno Kessler Foundation (FBK)
