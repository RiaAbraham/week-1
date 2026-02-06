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


