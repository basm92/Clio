#' Executive a query of categories to clio-infra
#'
#' This function allows you to enter (one or more of the available) category
#' names as an arguments.
#'
#' @param category A vector of categories.
#' @param ... All other arguments are passed on to [Clio::clio_get()]
#' @return A data.frame (or list) consisting of all the variables within a certain category
#' @seealso [Clio::clio_get()] Arguments other than category are passed to this function.
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#'
#' clio_get_cat("finanz", list = F, from = 1800, to = 1900)
#'
#' clio_get_cat(c("agriculture", "environment"),
#' countries = "Netherlands",
#' mergetype = inner_join, from = 1850, to = 1900)

#' clio_get_cat("Produzioni", from = 1700, list = F, mergetype = inner_join)
#'
#' clio_get(c("Tin Production", "income inequality"), from = 1800, countries = c("Netherlands", "Russia"))
#'
#' clio_get_cat("labor relation")

clio_get_cat <- function(category, ...) {

  if(missing(category)) {
    stop('No category selected')
  }

  matches <- stringdist::amatch(category, clio_overview_cat(),
                    maxDist = 5)

  if(is.element(NA,matches)) {
    stop('No matches. Have you made a typo?')
  }

  lapply(clio_overview_cat()[matches], clio_overview_cat) %>%
    purrr::reduce(rbind) %>%
    .[,1] -> query

  clio_get(query, ...)
}

