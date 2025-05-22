# install.packages("WorldFlora")
# version v.2023.03	Mar. 04, 2023 https://www.worldfloraonline.org/downloadData;jsessionid=2ECE7E7B998770898581486B09C1DCEB


#helpers functions


#' This functions reads rds tables of TRY and select specific variables of interest for categorical traits

#'
#'@param path provide the path where de database is located
#'@param vector_spp provide a vector with spp you want to obtain
#'@export exports the database filtered an in a tibble format
#'


read_try<- function(path){
  
  
  traitdb<-readRDS(path)|>

    dplyr::select(
      AccSpeciesName,
      OriglName,
      OrigValueStr,
      DatasetID,
      StdValue,
      UnitName,
     
      Comment)
  
  return(traitdb)
}


