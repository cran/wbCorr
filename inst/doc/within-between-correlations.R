## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 6,
  fig.height = 6
)

## ----simulate-data------------------------------------------------------------
set.seed(2026)

n_people <- 60
n_occasions <- 10
person <- rep(seq_len(n_people), each = n_occasions)

person_x <- rnorm(n_people, sd = 2)
person_y <- 0.8 * person_x + rnorm(n_people, sd = 0.5)
occasion_x <- rnorm(n_people * n_occasions)
occasion_y <- -0.7 * occasion_x + rnorm(n_people * n_occasions, sd = 0.6)

dat <- data.frame(
  person = person,
  x = rep(person_x, each = n_occasions) + occasion_x,
  y = rep(person_y, each = n_occasions) + occasion_y
)

round(cor(dat$x, dat$y), 2)

## ----fit----------------------------------------------------------------------
library(wbCorr)

fit <- wbCorr(
  data = dat,
  cluster = "person",
  inference = "none"
)

## ----summarize-levels---------------------------------------------------------
summary(fit, "w")
summary(fit, "b")

## ----summarize-merged---------------------------------------------------------
summary(fit, "wb")

## ----within-plot, fig.cap = "Within-person association after subtracting each person's variable means."----
plot(fit, "within")

## ----between-plot, fig.cap = "Between-person association among person-level variable means."----
plot(fit, "between")

## ----extract-results----------------------------------------------------------
tables <- get_table(fit)
within_table <- tables$within

within_matrix <- get_matrix(fit, "w", numeric = TRUE)$within
merged_matrix <- get_matrix(fit, "wb", numeric = TRUE)$merged_wb

## ----bootstrap, eval = FALSE--------------------------------------------------
# set.seed(2026)
# 
# fit_boot <- wbCorr(
#   data = dat,
#   cluster = "person",
#   inference = "cluster_bootstrap",
#   nboot = 1000
# )

