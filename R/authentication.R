#' Azure DevOps Authentication Key
#'
#' @description
#' Creation of a Azure DevOps authentication key that will be used when running any of the API calls.
#'
#' @param user username to access Azure DevOps project
#' @param pass password to access Azure DevOps project
#'
#' @return
#' An authentication key string in the form of 'Basic <Base 64 of \code{user}:\code{pass}>'
#'
#' @details
#' For more information about authentication check
#' \url{https://docs.microsoft.com/en-us/rest/api/azure/devops/?view=azure-devops-rest-6.1#create-the-request}
#'
#' To obtain a personal access token, access \url{https://dev.azure.com/projectName/_usersSettings/tokens},
#' changing the \code{projectName} with the required project.
#'
#' @examples
#' # Using credentials
#' auth_key <- vsts_auth_key("<username>", "<password>")
#'
#' # Using PAT token
#' auth_key <- vsts_auth_key(NULL, "<token>")
#'
#' @export
vsts_auth_key <- function(user, pass) paste("Basic", RCurl::base64(paste(user, pass, sep = ":")))
