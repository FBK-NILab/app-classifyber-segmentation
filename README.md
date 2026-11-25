<h1 align="center">Classifyber - segmentation</h1>

<p align="center">
  Segments white matter bundles from a whole-brain tractogram with Classifyber, a pre-trained streamline-based linear classifier, after ANTs registration to MNI152; outputs a WMC classification and per-bundle .tck files.
</p>

<p align="center">
  <a href="https://github.com/brainlife/abcd-spec"><img src="https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg" alt="ABCD Spec v1.1"></a>
  <a href="https://doi.org/10.25663/brainlife.app.265"><img src="https://img.shields.io/badge/Brainlife-brainlife.app.265-blue.svg" alt="Run on brainlife.io"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-see_LICENSE-lightgrey.svg" alt="License"></a>
</p>

## At a glance

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

> **Segments white matter bundles from a whole-brain tractogram with Classifyber, a pre-trained streamline-based linear classifier, after ANTs registration to MNI152; outputs a WMC classification and per-bundle .tck files.**

Runs only the test phase of Classifyber: the tractogram is registered to the MNI152 T1 template via an ANTs warp computed from the subject T1, then pre-trained classifiers segment the bundles selected by ID (HCP-IFOF, HCP-minor, HCP-major and clinical sets listed in the README) and the result is converted to multiple .tck files. The tractogram and T1 must be in the same space. Classifiers are tuned to tractograms of a given size (for example about 500K streamlines for HCP-minor), so results may be poor otherwise. Use brainlife.app.228 to train on your own examples. This branch runs with Python 3.

| | |
|---|---|
| **Inputs** | `neuro/track/tck` · `neuro/anat/t1w` |
| **Outputs** | `neuro/wmc` · `neuro/tcks` |
| **Container** | `giuliaberto/ants2-mrtrix3-fsl6:1.1` |
| **Resources** | 16 CPUs · 50 GB memory · 8 h walltime |
| **Run it** | [doi.org/10.25663/brainlife.app.265](https://doi.org/10.25663/brainlife.app.265) |

#### Inputs

| Input | Datatype | Required | Description |
|---|---|---|---|
| `0` | `neuro/track/tck` | yes | Tractogram of static (target) subject |
| `1` | `neuro/anat/t1w` | yes | T1 of static (target) subject |

#### Outputs

| Output | Datatype | Description |
|---|---|---|
| `output_wmc` | `neuro/wmc` | Segmented bundles in wmc format |
| `output` | `neuro/tcks` | segmented bundles in tck format |

<details>
<summary><b>Parameters</b> (1)</summary>

| Parameter | Type | Default | Description |
|---|---|---|---|
| `tractID_list` | string |  | ID list of the bundles of interest, separated by commas, e.g. 32, 40, 45 (refer to the README.md for the mapping) |

</details>

<!-- brainlife-app:end -->

## Running the App

### On brainlife.io

Open the App at [doi.org/10.25663/brainlife.app.265](https://doi.org/10.25663/brainlife.app.265), choose `neuro/track/tck`, `neuro/anat/t1w` from your project, set the parameters and press **Execute**. The results are saved to your project as `neuro/wmc`, `neuro/tcks`.

### Locally

You need [Singularity/Apptainer](https://apptainer.org/) (the App runs in `giuliaberto/ants2-mrtrix3-fsl6:1.1`), [`jq`](https://jqlang.github.io/jq/).

1. Clone this repository.
2. Create `config.json` with the paths to your inputs and the parameters:

   ```json
   {
       "tractogram_static": "/path/to/0/tractogram_static",
       "t1_static": "/path/to/1/t1_static",
       "tractID_list": ""
   }
   ```

3. Run `./main`.

## Troubleshooting

- **Conversion to tcks failed.**: Check that the selected tract IDs produced streamlines.

## On [Brainlife.io](http://brainlife.io/)

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

## Citing

If you use this App, please cite it, the software it builds on and brainlife.io:

- Classifyber - segmentation. brainlife.io App. [doi:10.25663/brainlife.app.265](https://doi.org/10.25663/brainlife.app.265)
- Berto G et al. Classifyber, a robust streamline-based linear classifier for white matter bundle segmentation. NeuroImage (2020). [doi:10.1016/j.neuroimage.2020.117402](https://doi.org/10.1016/j.neuroimage.2020.117402)
- Jenkinson et al. FSL. *NeuroImage* 62:782-790 (2012). [doi:10.1016/j.neuroimage.2011.09.015](https://doi.org/10.1016/j.neuroimage.2011.09.015)
- Tournier et al. MRtrix3: A fast, flexible and open software framework for medical image processing and visualisation. *NeuroImage* 202:116137 (2019). [doi:10.1016/j.neuroimage.2019.116137](https://doi.org/10.1016/j.neuroimage.2019.116137)
- Garyfallidis et al. Dipy, a library for the analysis of diffusion MRI data. *Frontiers in Neuroinformatics* 8 (2014). [doi:10.3389/fninf.2014.00008](https://doi.org/10.3389/fninf.2014.00008)
- Avants et al. A reproducible evaluation of ANTs similarity metric performance in brain image registration. *NeuroImage* 54:2033-2044 (2011). [doi:10.1016/j.neuroimage.2010.09.025](https://doi.org/10.1016/j.neuroimage.2010.09.025)
- Hayashi S, Caron BA, Heinsfeld AS, et al. brainlife.io: a decentralized and open-source cloud platform to support neuroscience research. *Nature Methods* 21:809–813 (2024). [doi:10.1038/s41592-024-02237-2](https://doi.org/10.1038/s41592-024-02237-2)
- Avesani P, McPherson B, Hayashi S, et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. *Scientific Data* 6:69 (2019). [doi:10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)

## Authors

- Giulia Bertò

**Contributors**

- Emanuele Olivetti

## Funding

[![Wellcome-226486/Z/22/Z](https://img.shields.io/badge/Wellcome-226486%2FZ%2F22%2FZ-purple.svg)](https://wellcome.org/)
[![NIH-NINDS-U24NS140384](https://img.shields.io/badge/NIH_NINDS-U24NS140384-green.svg)](https://reporter.nih.gov/project-details/11261037)
[![NIH-NINDS-UM1NS132207](https://img.shields.io/badge/NIH_NINDS-UM1NS132207-green.svg)](https://reporter.nih.gov/project-details/11411328)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://reporter.nih.gov/project-details/10262925)
[![NIH-NIBIB-R01EB030896](https://img.shields.io/badge/NIH_NIBIB-R01EB030896-green.svg)](https://reporter.nih.gov/project-details/10428625)
[![NIH-NIMH-R01MH126699](https://img.shields.io/badge/NIH_NIMH-R01MH126699-green.svg)](https://reporter.nih.gov/project-details/10460628)
[![NIH-NIDCD-R01DC020088](https://img.shields.io/badge/NIH_NIDCD-R01DC020088-green.svg)](https://reporter.nih.gov/project-details/11140284)
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-2203524](https://img.shields.io/badge/NSF_BCS-2203524-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2203524)
[![NSF-IIS-1636893](https://img.shields.io/badge/NSF_IIS-1636893-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-OAC-2148729](https://img.shields.io/badge/NSF_OAC-2148729-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148729)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NSF-IIS-2148700](https://img.shields.io/badge/NSF_IIS-2148700-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148700)
[![NSF-OAC-1916518](https://img.shields.io/badge/NSF_OAC-1916518-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1916518)

<sub>brainlife.io, which runs this App, is publicly funded by Wellcome, the U.S. National Institutes of Health and the U.S. National Science Foundation; acknowledging that support helps keep it running.</sub>

## License

See [LICENSE](LICENSE).
