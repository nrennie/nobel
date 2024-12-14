#' Nobel laureate data

#' @param offset The number of items to skip before starting to collect the result set. Minimum 1.
#' @param limit The numbers of items to return. Minimum 1. Default 25.
#' @param sort Sort order, result is sorted alphabetically by known name. Must be one of \code{c("asc", "des")}.
#' @param ID Numeric ID of the Laureate (unique key for each Nobel Laureate).
#' @param name Laureate's name (person or organization).
#' @param gender Laureate's gender if person. Must be one of \code{c("female", "male", "other")}.
#' @param motivation Text in Laureate's motivation
#' @param affiliation Affiliation(s) for the Laureate at the time of the award
#' @param residence Laureate's place of residence at the time is awarded
#' @param birthDate Birth date of Laureate if Person. Search by year in the form of YYYY, by month -MM-, by day -DD or YYYY-MM-DD
#' @param birthDateTo Return Laureates born within a range of years between birthDate and birthDateTo. BirthDate field is required
#' @param deathDate Death date of Laureate if Person. Search by year in the form of YYYY, by month -MM-, by day -DD or YYYY-MM-DD
#' @param deathDateTo Return Laureates deceased within a range of years between deathDate and deathhDateTo. DeathDate field is required
#' @param foundedDate Founding date of Laureate if Organization. Search by year in the form of YYYY, by month -MM-, by day -DD or YYYY-MM-DD
#' @param birthCity Laureate's city of birth if person
#' @param birthCountry Laureate's country of birth if person
#' @param birthContinent Laureate's continent of birth if person. Continent as in geonames.org standard. Must be one of \code{c("Africa", "Asia", "Europe", "North America", "Oceania", "South America", "Antarctica")}.
#' @param deathCity Laureate's city of death if person
#' @param deathCountry Laureate's country of death if person
#' @param deathContinent Laureate's continent of death if person. Continent as in geonames.org standard. Must be one of \code{c("Africa", "Asia", "Europe", "North America", "Oceania", "South America", "Antarctica")}.
#' @param foundedCity City where organization was founded.
#' @param foundedCountry Country where organization was founded.
#' @param foundedContinent Continent where organization was founded. Continent as in geonames.org standard. Must be one of \code{c("Africa", "Asia", "Europe", "North America", "Oceania", "South America", "Antarctica")}.
#' @param HeadquartersCity City where organization's hearquarters are.
#' @param HeadquartersCountry Country where organization's hearquarters are.
#' @param HeadquartersContinent Continent where organization's hearquarters are. Continent as in geonames.org standard. Must be one of \code{c("Africa", "Asia", "Europe", "North America", "Oceania", "South America", "Antarctica")}.
#' @param nobelPrizeYear Year the Nobel Prize was awarded, in the form of YYYY.
#' @param yearTo Used in combination with `nobelPrizeYear` to specify a range of years to return results from.`NobelPrizeYear` is required.
#' @param nobelPrizeCategory Nobel Prize Category. Must be one of \code{c("che", "eco", "lit", "pea", "phy", "med")}.
#' @param csvLang Language of output for csv format. Must be one of \code{c("en", "se", "no")}. Default = `"en"`.
#' @return A data frame with one row for each result.
#' @export

laureates <- function(
    offset = NULL,
    limit = 25,
    sort = "asc",
    ID = NULL,
    name = NULL,
    gender = NULL,
    motivation = NULL,
    affiliation = NULL,
    residence = NULL,
    birthDate = NULL,
    birthDateTo = NULL,
    deathDate = NULL,
    deathDateTo = NULL,
    foundedDate = NULL,
    birthCity = NULL,
    birthCountry = NULL,
    birthContinent = NULL,
    deathCity = NULL,
    deathCountry = NULL,
    deathContinent = NULL,
    foundedCity = NULL,
    foundedCountry = NULL,
    foundedContinent = NULL,
    HeadquartersCity = NULL,
    HeadquartersCountry = NULL,
    HeadquartersContinent = NULL,
    nobelPrizeYear = NULL,
    yearTo = NULL,
    nobelPrizeCategory = NULL,
    csvLang = "en") {
  # Check arguments
  if (!is.null(nobelPrizeCategory)) {
    if (!(nobelPrizeCategory %in% c("che", "eco", "lit", "pea", "phy", "med"))) {
      stop('Not a valid category. Must be one of c("che", "eco", "lit", "pea", "phy", "med")')
    }
  }
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
  api_url <- "http://api.nobelprize.org/2.1/laureates"
  output <- suppressWarnings(readr::read_csv(
    glue::glue(
      "{api_url}?{query}"
    ),
    show_col_types = FALSE
  ))
  return(output)
}
