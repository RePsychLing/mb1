library(lme4)
library(tidyverse)


d <- read_csv("https://raw.githubusercontent.com/manybabies/mb1-analysis-public/master/processed_data/03_data_trial_main.csv", 
              na = c("NA", "N/A")) %>%
  mutate(method = case_when(
    method == "singlescreen" ~ "Central fixation",
    method == "eyetracking" ~ "Eye tracking",
    method == "hpp" ~ "HPP",
    TRUE ~ method)) 


ordered_ages <- c("3-6 mo", "6-9 mo", "9-12 mo", "12-15 mo")
d$age_group <- fct_relevel(d$age_group, ordered_ages)


d_lmer <- d %>%
  filter(trial_type != "train") %>%
  mutate(log_lt = log(looking_time),
         age_mo = scale(age_mo, scale = FALSE),
         trial_num = trial_num, 
         item = paste0(stimulus_num, trial_type)) %>%
  filter(!is.na(log_lt), !is.infinite(log_lt))

mod_lmer <- lmer(log_lt ~ trial_type * method +
                   trial_type * trial_num +
                   age_mo * trial_num +
                   trial_type * age_mo * nae +
                   (1 | subid_unique) +
                   (1 | item) + 
                   (1 | lab), 
                 data = d_lmer)

summary(mod_lmer)


#original_mod_lmer <- lmer(log_lt ~ trial_type * method +
#                   trial_type * trial_num +
#                   age_mo * trial_num +
#                   trial_type * age_mo * nae +
#                   (trial_type * trial_num | subid_unique) +
#                   (trial_type * age_mo | lab) + 
#                   (method + age_mo * nae | item), 
#                 data = d_lmer)
