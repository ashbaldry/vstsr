#' Visual Studio Projects
#'
#' @rdname vsts_repo
#'
#' @export
vsts_get_repos <- function(domain, project, auth_key, quiet = FALSE) {
  uri <- paste0('https://', domain, '.visualstudio.com/DefaultCollection/', project, '/_apis/git/repositories?api-version=1.0')

  response <- httr::GET(uri, httr::add_headers(Authorization = auth_key))
  if(response$status_code != 200) {
    cat('Unable to perform request, status code:', response$status_code, '\n')
    return(invisible(NULL))
  }

  content <- httr::content(response, as = 'text', encoding = 'UTF-8') %>% jsonlite::fromJSON(.) %>% .$value
  if(!quiet) cat('Available repositories:', paste(content$name, collapse = ', '), '\n')
  return(invisible(content))
}

#' @rdname vsts_repo
#' @export
vsts_create_repos <- function(domain, project, repo, auth_key, quiet = FALSE) {
  uri <- paste0('https://', domain, '.visualstudio.com/DefaultCollection/_apis/git/repositories?api-version=1.0')
  proj_id <- vsts_get_projects(domain, auth_key, quiet = TRUE) %>% .[.$name == project, 'id']
  if(is.null(proj_id)) return(invisible(NULL))
  if(length(proj_id) == 0) {
    cat('Unable to find', project, 'in', domain, '\n')
    return(invisible(NULL))
  }

  content_body <- jsonlite::toJSON(list(name = repo, project = list(id = proj_id)), auto_unbox = TRUE)

  response <- httr::POST(uri, httr::add_headers(Authorization = auth_key), httr::content_type_json(), body = content_body)
  if(response$status_code != 201) {
    if(response$status_code == 409) {
      cat('Unable to perform request,', repo, 'already exists in', project, '\n')
    } else {
      cat('Unable to perform request, status code:', response$status_code, '\n')
    }
    return(invisible(NULL))
  }

  if(!quiet) cat(repo, 'repository has been created in', project, '\n')
  content <- data.frame(httr::content(response, as = 'text', encoding = 'UTF-8') %>% jsonlite::fromJSON(.))
  return(invisible(content))
}

#' @rdname vsts_repo
#' @export
vsts_delete_repos <- function(domain, project, repo, auth_key, quiet = FALSE) {
  repo_id <- vsts_get_repos(domain, project, auth_key, quiet = TRUE) %>% .[.$name == repo, 'id']
  if(length(repo_id) == 0) {
    cat('Unable to find', repo, 'in', project, '\n')
    return(invisible(NULL))
  }
  uri <- paste0('https://', domain, '.visualstudio.com/DefaultCollection/', project, '/_apis/git/repositories/', repo_id, '?api-version=1.0')

  response <- httr::DELETE(uri, httr::add_headers(Authorization = auth_key))
  if(response$status_code != 204) {
    cat('Unable to perform request, status code:', response$status_code, '\n')
    return(invisible(NULL))
  }

  if(!quiet) cat(repo, 'repository has been deleted from', project, '\n')
  return(invisible(TRUE))
}
