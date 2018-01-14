#' @export
vsts_run_command <- function(url, verb, auth_key, body = NULL, query = NULL) {

  content_body <- if(!is.null(body)) jsonlite::toJSON(body, auto_unbox = TRUE) else NULL

  response <- httr::VERB(verb = verb, url = url, config = httr::add_headers(Authorization = auth_key),
                         httr::content_type_json(), query = query, body = content_body)

  if(httr::status_code(response) > 300) {
    cat(httr::http_condition(response, 'message', 'run custom command')$message, '\n')
    return(invisible(NULL))
  }

  content <- httr::content(response, as = 'text', encoding = 'UTF-8') %>% jsonlite::fromJSON(.)
  return(invisible(content))
}
