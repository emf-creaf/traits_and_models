# Convert from one of several options to mmol m-2 s-1.
# Assume mol m-3 = 41 (T 20C, Patm=101).
convert_gmin_units <- function(x, units, areabase, species){
  
  x * 
    switch(units,
           `10^5 ms-1` = 41 * 10^-5 * 10^3,
           `mmol m-2 s-1` = 1,
           `cm s-1` = 10^-2 * 41 * 10^3,
           `mm s-1` = 41  
    ) *
    switch(tolower(areabase),
           allsided = conv_allsided(species),
           projected = 1)
  
  
}


conv_allsided <- function(species){
  
  # lambda1 = projected area / half-total surface area.
  
  # Mean of lambda1 in Barclay & Goodman (2000, Table 3), non-pine.
  nonpine_lambda1 <- mean(c(0.873, 0.92, 0.879, 0.864, 0.839))
  
  # pine, Barclay & Goodman (2000, Table 3)
  pine_lambda1 <- 0.778
  
  if(grepl("pinus", species, ignore.case = TRUE)){
    return(1 / (pine_lambda1/2))
  }
  con_gen <- c("abies","picea","pseudotsuga","cupressus","larix",
               "juniperus","metasequoia","thuja","tsuga")
  grp <- paste(con_gen, collapse="|")
  if(grepl(grp, species, ignore.case=TRUE)){
    return(1 / (nonpine_lambda1/2))
  }
  
  return(2)
}

