#' Auxilary function to help clean the raw data
#'
#' Not to be used seperately. Executes a few tidyverse commands
#' to quickly and efficiently clean the data for user convenience.
#'
#' @return A data.frame, but for internal use only.
#' @importFrom magrittr "%>%"
#' @export
#'
#'
data_clean <- function(x) {
  x %>%
    data.frame(variable_name = .) %>%
    dplyr::mutate(from =  stringr::str_extract(variable_name, "[0-9]{4}"),
           to = stringr::str_extract(variable_name, "\\d{4}$"),
           obs = stringr::str_replace_all(
             stringr::str_extract(
               variable_name,
               "\\[[0-9]+\\]"),
             c("\\[" = "", "\\]" = "")),
           variable_name = stringr::str_trim(stringr::str_extract(variable_name, "[^1]+")))
}


