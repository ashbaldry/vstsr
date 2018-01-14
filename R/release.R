#' Visual Studio Project Release Information
#'
#' APIs ARE NOT WORKING YET FOR THIS SET OF FUNCTIONALITY
# vsts_get_releases <- function(domain, auth_key, quiet = FALSE) {
#   uri <- paste0('https://', domain, '.visualstudio.com/', project, '/_apis/release/definitions?api-version=4-0-preview')
#
#   response <- httr::GET(uri, httr::add_headers(Authorization = auth_key))
#   if(response$status_code != 200) {
#     cat('Unable to perform request, status code:', response$status_code, '\n')
#     return(invisible(NULL))
#   }
#
#   content <- httr::content(response, as = 'text', encoding = 'UTF-8') %>% jsonlite::fromJSON(.) %>% .$value
#   if(!quiet) cat('Available projects:', paste(content$name, collapse = ', '), '\n')
#   return(invisible(content))
# }
