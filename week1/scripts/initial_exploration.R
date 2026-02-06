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
  name_repair = janitor::make_clean_names
)

glimpse(mosquito_egg_raw)
summary(mosquito_egg_raw)
skim(mosquito_egg_raw)

View(mosquito_egg_raw)

mosquito_egg_raw |>
  group_by(site, treatment) |>
  summarise(n = n(), .groups = "drop")

# Observations ====
# - What biological system is this?
#   This dataset is from an entomology experiment on mosquito reproduction, where individual female mosquitoes
#   are exposed to pesticide-treated egg-laying traps and outcomes are measured.
#
# - What's being measured?
#   Explanatory variables include treatment dose, site, collection date, collector, age (days), and body mass (mg).
#   Outcomes include eggs_laid and eggs_hatched per female.
#
# - How many observations?
#   There are 205 rows (females) and 9 variables.
#
# - Anything surprising?
#   The dataset includes a collection_date as late as 2024-01-15, which is outside the stated study period
#   (May 1, 2023 to Aug 31, 2023). This suggests either data entry error or additional sampling outside the described window.
#
# - Any obvious problems?
#   1) Inconsistent categorical labels:
#      - site has many variants (e.g., "Site_C", "Site C", "Site B", "Site A", "Site-A"), which creates artificial groups.
#      - treatment has case/format variants (e.g., "High_dose", "high_dose", "HIGH_DOSE"), inflating the number of groups.
#      - collector includes likely typos/incomplete names (e.g., "Garci") and has missing values (n = 13).
#   2) Missing data:
#      - body_mass_mg has 15 missing values.
#      - eggs_laid has 16 missing values.
#      - eggs_hatched has 17 missing values.
#   3) Numeric value:
#      - body_mass_mg has a minimum of -93 mg, which is biologically impossible, suggesting a data entry error.
#   




