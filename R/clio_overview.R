#' Provide an overview of all available variables on Clio-infra
#'
#' The function returns a data.frame containing all variables, and indicates availability
#' in terms of years and observations.
#'
#' @return A data.frame with the variable names, from, to and number of observations (obs)
#' @seealso [Clio::clio_overview_cat()]
#' @export
#' @examples
#' clio_overview()

clio_overview <- function() {
  variables <- read_html("https://clio-infra.eu/index.html") %>%
    html_nodes("div.row:nth-child(6) p") %>%
    html_text() %>%
    data.frame(variable_name = .) %>%
    mutate(from =  str_extract(variable_name, "[0-9]{4}"),
           to = str_extract(variable_name, "\\d{4}$"),
           obs = str_replace_all(
             str_extract(
               variable_name,
               "\\[[0-9]+\\]"),
             c("\\[" = "", "\\]" = "")),
           variable_name = str_trim(str_extract(variable_name, "[^1]+"))
    )

  variables
}








