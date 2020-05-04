#' Execute a data query to clio-infra
#'
#' This function is used to execute a query to clio-infra,
#' and returns a data.frame containing the required variables,
#' countries and years specified by the user.
#'
#' @return a data.frame containing the required variables,
#'    countries and years specified by the user.
#' @param variables The variables you want to obtain (provided to you by [Clio::clio_overview()])
#' @param countries If left empty, all countries.
#' @param from Start year
#' @param to End year
#' @param list Defaults to FALSE. If TRUE, returns a list of each variable
#' @param mergetype Defaults to full_join. Can be set to inner_join, outer_join, left_join, etc.
#'
#' @importFrom magrittr "%>%"
#' @import dplyr
#' @seealso [Clio::clio_get_cat()] if you want to extract data by categories instead of by variables.
#' @export
#' @examples
#' clio_get(c("infant mortality", "zinc production"))
#'
#' clio_get(c("biodiversity - naturalness", "xecutive Constraints  (XCONST)"),
#' from = 1850, to = 1900,
#' countries = c("Armenia", "Azerbaijan"))
#'
#' clio_get(c("Zinc production", "Gold production"),
#' from = 1800, to = 1920,
#' countries = c("Botswana", "Zimbabwe",
#'              mergetype = inner_join))

clio_get <- function(variables,
                     countries,
                     from,
                     to,
                     list = FALSE,
                     mergetype = full_join) {

  if(missing(variables)) {
    stop("No valid variables selected")
  }

  matches <- stringdist::amatch(variables, clio_overview()[,1],
                    maxDist = 5)

  if(is.element(NA, matches)) {
    stop("No valid variables selected. Have you made a typo?")
  }

  query <- clio_overview()[matches,1]

  #Make it robust to a few badly-named datasets:
  query <- gsub("Armed Conflicts \\(Internal\\)",
                "Armed conflicts \\(Internal\\)",
                query)

  query <- gsub("Female Life Expectancy",
                "Female life Expectancy",
                query)

  #Initialize the loop
  data <- list()

  for(i in 1:length(query)) {
    download.file(
          url = paste("https://clio-infra.eu/data/",
                      stringr::str_replace_all(query[i], " ", ""),
                      "_Compact.xlsx",
                      sep = ""),
              destfile = "tmp",
              mode="wb",
          quiet = TRUE)

    step1 <- readxl::read_xlsx("tmp", sheet = 2)
    colnames(step1)[4] <- query[i]

    data[[i]] <- step1
  }

# Here is the filter with three if statements (from, to and country)
  if(!missing(from)) {
      data <- data %>%
        lapply(filter, year >= from)
  }

  if(!missing(to)){
      data <- data %>%
        lapply(filter, year <= to)
  }

  if(!missing(countries)) {
      data <- data %>%
        lapply(filter, is.element(country.name, countries))
  }

#This if-else covers what the data looks like, list or merged dataframe
  if (list == TRUE) {
    data
  }

else data %>%
    purrr::reduce(mergetype)
}


