# ManyBabies

Re-analysis of data from the [`ManyBabies1: Infant-directed Speech Preference`](https://github.com/manybabies/mb1-analysis-public) project. 


* For more information about the ManyBabies project, see http://manybabies.stanford.edu/  
* The data and main analysis can be found at https://github.com/manybabies/mb1-analysis-public, stimuli, protocol, and further documentation is at https://osf.io/re95x/  

The repository contains:  

* `MB1_analysis.jmd` - The main script, which  

  1. Reads in ManyBabies 1 data  
  2. Shapes it as needed  
  3. Reproduces the main analysis from the paper at https://github.com/manybabies/mb1-analysis-public  
  4. Fits the preregistered maximal model  
  5. Simplifies the random effects by inspecting the output of rePCA and the variance components  
  6. Shows what can go wrong with multi-lab data (subid vs subid_unique)  
  7. Re-processes more messy data to apply different cleaning criteria to deal with censoring (which you can adjust)  
  8. Re-runs the analysis  
  
* `MB1_analysis.ipynb` - The corresponding Jupyter notebook that you can run in your browser, but which differs from the converted version of the .jmd (split code blocks to see all output, converted R code cell)  
* `MB1_minimal_lmer.R` - The R code needed to reproduce the main analysis of the paper, extracted from https://github.com/manybabies/mb1-analysis-public/blob/master/paper/mb1-paper.Rmd  
* `intendend_complex_LMM.txt` - Output for the preregistered model (which still takes some time to fit)  
* `Project.toml` and `Manifest.toml` - See https://repsychling.github.io/pkg.html  
  
For instructions how to run code in .jmd and .ipynb files, see https://repsychling.github.io/intro.html



## Acknowledgements
This work was supported by the Center for Interdisciplinary Research, Bielefeld (ZiF) Cooperation Group "Statistical models for psychological and linguistic data".
