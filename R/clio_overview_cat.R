#' Overview of categories or variables within a category
#'
#' This function returns a vector of categories or all variables within a certain category
#' (indicated by an argument)
#'
#' @param subargument One of the categories present on Clio-infra
#' @return With no argument, it returns a vector containing the names of all available categories
#' on clio-infra. With a category as one of its arguments, it returns the names, from, to and obs of
#' all variables within that category.
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' clio_overview_cat("finanz")
#' clio_overview_cat()
#' clio_overview_cat("institutions")

clio_overview_cat <- function(subargument = "all") {
  url <- xml2::read_html("https://clio-infra.eu/index.html")

  variables <- url %>%
    rvest::html_nodes("div.row:nth-child(6) a.list-group-item.active") %>%
    rvest::html_text() %>%
    stringr::str_trim()

  if(subargument == "all") {
    variables
  }


  else if (!is.na(stringdist::amatch(subargument, variables, maxDist = 10))) {
    match <- stringdist::amatch(subargument, variables, maxDist = 10)


    #Very important: preceding is the first a header, following the second
    #Thus, you first enter match+1, and only then match.

    subs <- url %>%
      rvest::html_nodes(xpath = paste("
    /html/body/div/div[6]//
      p[
        following::a[normalize-space(text()) =",
                               "'",
                               variables[match+1],
                               "'",
                               "] and
        preceding::a[normalize-space(text()) =",
                               "'",
                               variables[match],
                               "'", "
        ]
      ]",
                               sep = "")) %>%
      rvest::html_text()

    #Clean the dataset in the same way as in the function clio_overview, make a neat matrix
    subs <- subs %>%
      data_clean()

    #In this if, make a separate clause for the last category, Production, because it has no more a to scrape!
    #If production, scrape every p after production
    if(variables[match] == "Production"){
      subs <- url %>%
        rvest::html_nodes(xpath = "
                   /html/body/div/div[6]//
                   p[
                   preceding::a[normalize-space(text()) ='Production'
                   ]]
                   "
                     ) %>%
        rvest::html_text()

      subs <- subs %>%
        data_clean()
    }

    subs
  }

  else stop('No valid subcategory selected')
}


