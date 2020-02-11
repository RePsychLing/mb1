library(lme4)
library(tidyverse)

# This is a minimal script that contains all relevant code to replicate the main LMM of 
# The ManyBabies Consortium. (2019). "Quantifying sources of variability in infancy research using the infant-directed speech preference." In press at Advances in Methods and Practices in Psychological Science (AMPPS).

# For more information, see https://github.com/manybabies/mb1-analysis-public


# Read in data and recode method
d <- read_csv("03_data_trial_main.csv", 
              na = c("NA", "N/A")) %>%
  mutate(method = case_when(
    method == "singlescreen" ~ "Central fixation",
    method == "eyetracking" ~ "Eye tracking",
    method == "hpp" ~ "HPP",
    TRUE ~ method)) 

# Order age to ensure that they appear chronologically, this is not used in the model but kept for completeness
ordered_ages <- c("3-6 mo", "6-9 mo", "9-12 mo", "12-15 mo")
d$age_group <- fct_relevel(d$age_group, ordered_ages)

# Construct a dataset for fitting the model: 
#   exclude training trials (redundant, not in the dataset)
#   subtract mean age from participants' age in months 
#   construct an item variable 
#   and remove missing data

d_lmer <- d %>%
  filter(trial_type != "train") %>%
  mutate(log_lt = log(looking_time),
         age_mo = scale(age_mo, scale = FALSE),
         trial_num = trial_num, 
         item = paste0(stimulus_num, trial_type)) %>%
  filter(!is.na(log_lt), !is.infinite(log_lt))


# Fit the pruned model and summarize

mod_lmer <- lmer(log_lt ~ trial_type * method +
                   trial_type * trial_num +
                   age_mo * trial_num +
                   trial_type * age_mo * nae +
                   (1 | subid_unique) +
                   (1 | item) + 
                   (1 | lab), 
                 data = d_lmer)

summary(mod_lmer)

### This is the preregistered model before pruning, which throws singularity warnings
#original_mod_lmer <- lmer(log_lt ~ trial_type * method +
#                   trial_type * trial_num +
#                   age_mo * trial_num +
#                   trial_type * age_mo * nae +
#                   (trial_type * trial_num | subid_unique) +
#                   (trial_type * age_mo | lab) + 
#                   (method + age_mo * nae | item), 
#                 data = d_lmer)
