#' Visual Studio Team Service Authentication Key
#'
#' @param user username to access VSTS project
#' @param pass password to access VSTS project
#'
#' @export
vsts_auth_key <- function(user, pass) paste('Basic', RCurl::base64(paste(user, pass, sep = ':')))
