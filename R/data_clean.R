#' Auxilary function to help clean the raw data
#'
#' Not to be used seperately. Executes a few tidyverse commands
#' to quickly and efficiently clean the data for user convenience.
#'
#' @return A data.frame, but for internal use only.
#' @export
#'
#'
data_clean <- function(x) {
  x %>%
    data.frame(variable_name = .) %>%
    mutate(from =  str_extract(variable_name, "[0-9]{4}"),
           to = str_extract(variable_name, "\\d{4}$"),
           obs = str_replace_all(
             str_extract(
               variable_name,
               "\\[[0-9]+\\]"),
             c("\\[" = "", "\\]" = "")),
           variable_name = str_trim(str_extract(variable_name, "[^1]+")))
}


