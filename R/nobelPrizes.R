#' Nobel prize data
#' Obtain information about all Nobel Prizes or search for a specific
#' set of Nobel Prizes. Note that not all information about the Laureates
#' are provided in the output, as a request of making this endpoints response
#' lighter. Call the laureates endpoint for full information.
#'
#' @param offset The number of items to skip before starting to collect the result set. Minimum 1.
#' @param limit The numbers of items to return. Minimum 1. Default 25.
#' @param sort Sort order, result is sorted by year. Must be one of \code{c("asc", "des")}.
#' @param nobelPrizeYear Year the Nobel Prize was awarded, in the form of YYYY.
#' @param yearTo Used in combination with `nobelPrizeYear` to specify a range of years to return results from.`NobelPrizeYear` is required.
#' @param nobelPrizeCategory Nobel Prize Category. Must be one of \code{c("che", "eco", "lit", "pea", "phy", "med")}.
#' @param csvLang Language of output for CSV format. Must be one of \code{c("en", "se", "no")}. Default = `"en"`.
#' @return A data frame with one row for each result.
#' @export

nobelPrizes <- function(
    offset = NULL,
    limit = 25,
    sort = "asc",
    nobelPrizeYear = NULL,
    yearTo = NULL,
    nobelPrizeCategory = NULL,
    csvLang = "en") {
  # Check arguments
  params_vals <- as.list(environment(NULL))
  query <- params_vals |>
    tibble::enframe() |>
    dplyr::mutate(value = as.character(.data$value)) |>
    dplyr::filter(.data$value != "NULL") |>
    tibble::add_row(
      name = "format",
      value = "csv"
    ) |>
    dplyr::mutate(
      query = glue::glue("{name}={value}")
    ) |>
    dplyr::pull(query) |>
    stringr::str_flatten(collapse = "&")
  # Call API
  api_url <- "http://api.nobelprize.org/2.1/nobelPrizes"
  output <- readr::read_csv(
    glue::glue(
      "{api_url}?{query}"
    )
  )
  return(output)
}
