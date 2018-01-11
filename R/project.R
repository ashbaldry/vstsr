#' Visual Studio Projects
#'
#' @rdname vsts_project
#'
#' @export
vsts_get_projects <- function(domain, auth_key, quiet = FALSE) {
  uri <- paste0('https://', domain, '.visualstudio.com/DefaultCollection/_apis/projects?api-version=1.0')

  response <- httr::GET(uri, httr::add_headers(Authorization = auth_key))
  if(response$status_code != 200) {
    cat('Unable to perform request, status code:', response$status_code, '\n')
    return(invisible(NULL))
  }

  content <- httr::content(response, as = 'text', encoding = 'UTF-8') %>% jsonlite::fromJSON(.) %>% .$value
  if(!quiet) cat('Available projects:', paste(content$name, collapse = ', '), '\n')
  return(invisible(content))
}
