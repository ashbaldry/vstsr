AZURE_HOME_URL <- "https://dev.azure.com"
AZURE_VSRM_URL <- "https://vsrm.dev.azure.com"

send_failure_message <- function(response, message = NULL) {
  cat(httr::http_condition(response, "message", message)$message, "\n")

  content <- httr::content(response)
  if (!is.null(content[["message"]])) {
    cat(content$message, "\n")
  }

  invisible(NULL)
}
