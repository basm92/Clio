#' Provide an overview of all available variables on Clio-infra
#'
#' The function returns a data.frame containing all variables, and indicates availability
#' in terms of years and observations.
#'
#' @return A data.frame with the variable names, from, to and number of observations (obs)
#' @seealso [Clio::clio_overview_cat()]
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' clio_overview()

clio_overview <- function() {
  variables <- xml2::read_html("https://clio-infra.eu/index.html") %>%
    rvest::html_nodes("div.row:nth-child(6) p") %>%
    rvest::html_text() %>%
    data.frame(variable_name = .) %>%
    dplyr::mutate(from =  stringr::str_extract(variable_name, "[0-9]{4}"),
           to = stringr::str_extract(variable_name, "\\d{4}$"),
           obs = stringr::str_replace_all(
             stringr::str_extract(
               variable_name,
               "\\[[0-9]+\\]"),
             c("\\[" = "", "\\]" = "")),
           variable_name = stringr::str_trim(stringr::str_extract(variable_name, "[^1]+"))
    )

  variables
}








