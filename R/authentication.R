#' Visual Studio Team Service Authentication Key
#'
#' @description
#' Creation of a VSTS authentication key that will be used when running any of the API calls.
#'
#' @param user username to access VSTS project
#' @param pass password to access VSTS project
#'
#' @return
#' An authentication key string in the form of 'Basic <Base 64 of user:pass>'
#'
#' @examples
#' auth_key <- vsts_auth_key('<username>', '<password>')
#'
#' @export
vsts_auth_key <- function(user, pass) paste('Basic', RCurl::base64(paste(user, pass, sep = ':')))
