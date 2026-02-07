# Week 1: Initial Data Exploration ====
# Author: Ria Abraham
# Date: 2026-02-06

library(tidyverse)
library(here)
library(naniar)
library(janitor)
library(skimr)

mosquito_egg_raw <- read_csv(
  here("data", "mosquito_egg_data.csv"),
  name_repair = janitor::make_clean_names)

glimpse(mosquito_egg_raw)
summary(mosquito_egg_raw)
skim(mosquito_egg_raw)

View(mosquito_egg_raw)

mosquito_egg_raw |>
  group_by(site, treatment) |>
  summarise(n = n(), .groups = "drop")

# Observations ====
# - What biological system is this?
#   This dataset comes from an entomology study investigating mosquito reproduction.
#   Individual female mosquitoes were exposed to egg-laying traps treated with different
#   pesticide concentrations, and their reproductive output was recorded.
#
# - What's being measured?
#   The dataset includes explanatory variables such as pesticide treatment, field site,
#   collection date, collector, female age (days), and body mass (mg).
#   The main response variables are the number of eggs laid and the number of eggs hatched
#   per female.
#
# - How many observations?
#   There are 205 individual female mosquitoes (rows) and 9 measured variables.
#
# - Anything surprising?
#   Some collection dates extend to 2024-01-15, which falls outside the stated study period
#   (May 1, 2023 to August 31, 2023). This may reflect a data entry error or sampling that
#   occurred beyond the documented study window.
#
# - Any obvious problems?
#   1) Inconsistent categorical labels:
#      - The site variable contains multiple naming formats (e.g. "Site_C", "Site C",
#        "Site-A"), which artificially increases the number of site categories.
#      - The treatment variable shows inconsistent capitalisation (e.g. "High_dose",
#        "high_dose", "HIGH_DOSE"), leading to unnecessary group fragmentation.
#      - The collector variable includes likely typos or truncated names (e.g. "Garci")
#        and contains missing values (n = 13).
#   2) Missing data:
#      - body_mass_mg has 15 missing values.
#      - eggs_laid has 16 missing values.
#      - eggs_hatched has 17 missing values.
#   3) Implausible numeric values:
#      - body_mass_mg includes a minimum value of −93 mg, which is biologically impossible
#        and strongly suggests a data entry or recording error.


# FIX 1: [Issue description] ====

# Show the problem:
mosquito_egg_raw |>  
  distinct(site )


# Fix it:
mosquito_egg_data_step1 <- mosquito_egg_raw |>
    mutate(site = str_to_upper(str_extract(site, "[ABCabc]")))
  
  
  # Verify it worked:
    distinct(mosquito_egg_data_step1, site)
  
  
  # What changed and why it matters:
    # The site column contained inconsistent labels (e.g. "Site_A", "site b", "Site-C"),
    # with differences in capitalisation and separators (spaces, underscores, dashes).
    # I extracted the site letter (A, B, or C) and converted it to uppercase to
    # standardise the site categories, ensuring they can be analysed correctly.


# FIX 2: [Issue description]  ====

# Show the problem:
    mosquito_egg_raw |>
      filter(body_mass_mg < 0)

# Fix it:
mosquito_egg_data_step2 <- mosquito_egg_data_step1 |>
  mutate(
    body_mass_mg = if_else(body_mass_mg < 0, NA_real_, body_mass_mg)
  )

  
  
  # Verify it worked:
  mosquito_egg_data_step2 |>
  distinct(body_mass_mg) |>
  filter(body_mass_mg < 0)
  
# What changed and why it matters:
  # Negative values in body_mass_mg were replaced with NA, as negative body mass is
  # biologically impossible. Removing these invalid measurements ensures that analyses
  # involving body size, condition, or egg production are not biased by erroneous data.
  
    



