r2 <- function(obs, pred) {
  1 - (sum((obs - pred)^2)/sum((obs - mean(obs))^2))
}
trait_coordination <- function(harmonized_trait_path) {
  df_means <- traits4models::taxon_trait_summary(harmonized_trait_path, 
                                                 traits = c("Ptlp", 
                                                            "VCleaf_P50", "VCleaf_P12", "VCleaf_P88",
                                                            "VCroot_P50", "VCroot_P12", "VCroot_P88",
                                                            "VCstem_P50", "VCstem_P12", "VCstem_P88"))

  nrel = 9
  n = rep(NA, nrel)
  p = rep(NA, nrel)
  responses = rep("", nrel)
  formulae = rep("", nrel)
  param1 = rep(NA, nrel)
  param2 = rep(NA, nrel)
  param3 = rep(NA, nrel)
  r2 = rep(NA, nrel)
  r2adj = rep(NA, nrel)
  cnt <- 0
    
  ## VCstem_P12 ~ VCstem_P50
  cnt <- cnt + 1
  df_sub <- df_means |>
    dplyr::select(VCstem_P12, VCstem_P50) |>
    dplyr::filter(!is.na(VCstem_P12), !is.na(VCstem_P50))
  n[cnt] <- nrow(df_sub)
  p[cnt] <- 1
  responses[cnt] <- "VCstem_P12"
  formulae[cnt] <- "VCstem_P12 = a * VCstem_P50"
  m <- lm(VCstem_P12 ~ VCstem_P50 - 1, data = df_sub)
  param1[cnt] = coef(m)[[1]]
  r2[cnt] <- r2(df_sub$VCstem_P12, predict(m))
  r2adj[cnt] <- 1 - (1-r2[cnt])*((n[cnt]-1)/(n[cnt] - p[cnt] - 1))
  
  
  ## VCstem_P88 ~ VCstem_P50
  cnt <- cnt + 1
  df_sub <- df_means |>
    dplyr::select(VCstem_P88, VCstem_P50) |>
    dplyr::filter(!is.na(VCstem_P88), !is.na(VCstem_P50))
  n[cnt] <- nrow(df_sub)
  p[cnt] <- 1
  responses[cnt] <- "VCstem_P88"
  formulae[cnt] <- "VCstem_P88 = a * VCstem_P50"
  m <- lm(VCstem_P88 ~ VCstem_P50 - 1, data = df_sub)
  param1[cnt] = coef(m)[[1]]
  r2[cnt] <- r2(df_sub$VCstem_P88, predict(m))
  r2adj[cnt] <- 1 - (1-r2[cnt])*((n[cnt]-1)/(n[cnt] - p[cnt] - 1))
  
  ## VCroot_P50 ~ VCstem_P50
  cnt <- cnt + 1
  df_sub <- df_means |>
    dplyr::select(VCroot_P50, VCstem_P50) |>
    dplyr::filter(!is.na(VCroot_P50), !is.na(VCstem_P50))
  n[cnt] <- nrow(df_sub)
  p[cnt] <- 1
  responses[cnt] <- "VCroot_P50"
  formulae[cnt] <- "VCroot_P50 = a * VCstem_P50"
  m <- lm(VCroot_P50 ~ VCstem_P50 - 1, data = df_sub)
  param1[cnt] = coef(m)[[1]]
  r2[cnt] <- r2(df_sub$VCroot_P50, predict(m))
  r2adj[cnt] <- 1 - (1-r2[cnt])*((n[cnt]-1)/(n[cnt] - p[cnt] - 1))
  
  ## VCroot_P12 ~ VCroot_P50
  cnt <- cnt + 1
  df_sub <- df_means |>
    dplyr::select(VCroot_P12, VCroot_P50) |>
    dplyr::filter(!is.na(VCroot_P12), !is.na(VCroot_P50))
  n[cnt] <- nrow(df_sub)
  p[cnt] <- 1
  responses[cnt] <- "VCroot_P12"
  formulae[cnt] <- "VCroot_P12 = a * VCroot_P50"
  m <- lm(VCroot_P12 ~ VCroot_P50 - 1, data = df_sub)
  param1[cnt] = coef(m)[[1]]
  r2[cnt] <- r2(df_sub$VCroot_P12, predict(m))
  r2adj[cnt] <- 1 - (1-r2[cnt])*((n[cnt]-1)/(n[cnt] - p[cnt] - 1))
  
  ## VCroot_P88 ~ VCroot_P50
  cnt <- cnt + 1
  df_sub <- df_means |>
    dplyr::select(VCroot_P88, VCroot_P50) |>
    dplyr::filter(!is.na(VCroot_P88), !is.na(VCroot_P50))
  n[cnt] <- nrow(df_sub)
  p[cnt] <- 1
  responses[cnt] <- "VCroot_P88"
  formulae[cnt] <- "VCroot_P88 = a * VCroot_P50"
  m <- lm(VCroot_P88 ~ VCroot_P50 - 1, data = df_sub)
  param1[cnt] = coef(m)[[1]]
  r2[cnt] <- r2(df_sub$VCroot_P88, predict(m))
  r2adj[cnt] <- 1 - (1-r2[cnt])*((n[cnt]-1)/(n[cnt] - p[cnt] - 1))
  
  ## VCleaf_P50 ~ VCstem_P50
  cnt <- cnt + 1
  df_sub <- df_means |>
    dplyr::select(VCleaf_P50, VCstem_P50) |>
    dplyr::filter(!is.na(VCleaf_P50), !is.na(VCstem_P50))
  n[cnt] <- nrow(df_sub)
  p[cnt] <- 1
  responses[cnt] <- "VCleaf_P50"
  formulae[cnt] <- "VCleaf_P50 = a * VCstem_P50"
  m <- lm(VCleaf_P50 ~ VCstem_P50 - 1, data = df_sub)
  param1[cnt] = coef(m)[[1]]
  r2[cnt] <- r2(df_sub$VCleaf_P50, predict(m))
  r2adj[cnt] <- 1 - (1-r2[cnt])*((n[cnt]-1)/(n[cnt] - p[cnt] - 1))
  
  ## VCleaf_P50 ~ Ptlp
  cnt <- cnt + 1
  df_sub <- df_means |>
    dplyr::select(VCleaf_P50, Ptlp) |>
    dplyr::filter(!is.na(VCleaf_P50), !is.na(Ptlp))
  n[cnt] <- nrow(df_sub)
  p[cnt] <- 2
  responses[cnt] <- "VCleaf_P50"
  formulae[cnt] <- "VCleaf_P50 = a + b * Ptlp"
  m <- lm(VCleaf_P50 ~ Ptlp, data = df_sub)
  param1[cnt] = coef(m)[[1]]
  param2[cnt] = coef(m)[[2]]
  r2[cnt] <- r2(df_sub$VCleaf_P50, predict(m))
  r2adj[cnt] <- 1 - (1-r2[cnt])*((n[cnt]-1)/(n[cnt] - p[cnt] - 1))
  
  ## VCleaf_P12 ~ VCleaf_P50
  cnt <- cnt + 1
  df_sub <- df_means |>
    dplyr::select(VCleaf_P12, VCleaf_P50) |>
    dplyr::filter(!is.na(VCleaf_P12), !is.na(VCleaf_P50))
  n[cnt] <- nrow(df_sub)
  p[cnt] <- 1
  responses[cnt] <- "VCleaf_P12"
  formulae[cnt] <- "VCleaf_P12 = a * VCleaf_P50"
  m <- lm(VCleaf_P12 ~ VCleaf_P50 - 1, data = df_sub)
  param1[cnt] = coef(m)[[1]]
  r2[cnt] <- r2(df_sub$VCleaf_P12, predict(m))
  r2adj[cnt] <- 1 - (1-r2[cnt])*((n[cnt]-1)/(n[cnt] - p[cnt] - 1))
  
  ## VCleaf_P88 ~ VCleaf_P50
  cnt <- cnt + 1
  df_sub <- df_means |>
    dplyr::select(VCleaf_P88, VCleaf_P50) |>
    dplyr::filter(!is.na(VCleaf_P88), !is.na(VCleaf_P50))
  n[cnt] <- nrow(df_sub)
  p[cnt] <- 1
  responses[cnt] <- "VCleaf_P88"
  formulae[cnt] <- "VCleaf_P88 = a * VCleaf_P50"
  m <- lm(VCleaf_P88 ~ VCleaf_P50 - 1, data = df_sub)
  param1[cnt] = coef(m)[[1]]
  r2[cnt] <- r2(df_sub$VCleaf_P88, predict(m))
  r2adj[cnt] <- 1 - (1-r2[cnt])*((n[cnt]-1)/(n[cnt] - p[cnt] - 1))
  
  df <- data.frame(response = responses,
                   formula = formulae,
                   param1 = param1,
                   param2 = param2,
                   param3 = param3,
                   n = n,
                   p = p,
                   r2 = r2,
                   r2adj = r2adj)
  
  saveRDS(df, "data/trait_coordination.rds")
  return(df)
}