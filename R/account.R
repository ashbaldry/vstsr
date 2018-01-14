#' Visual Studio Team Services Account
#'
#' @field user username for the Visual Studio account
#' @field pass password for the Visual Studio account
#' @field domain domain name for the Visual Studio account
#' @field project (optional) project name within the domain of the Visual Studio account
#'
#' @docType class
#' @format An \code{\link{R6Class}} generator object
#' @keywords data
#'
#' @examples
#' proj <- vsts_account$new('<username>', '<password>', '<domain name>', '<project name>')
#' str(proj)
#'
#' @export
vsts_account <- R6::R6Class(classname = 'vsts',
                            public = list(
                              user = NULL,
                              domain = NULL,
                              project = NULL,

                              initialize = function(user = NA, pass = NA, domain = NA, project = NULL) {
                                self$user <- user
                                self$domain <- domain
                                self$project <- project
                                private$pass <- pass
                                private$auth_key <- private$get_auth_key(user, pass)
                              },

                              get_projects = function() vsts_get_projects(self$domain, private$auth_key),

                              get_repos = function() {
                                private$proj_check()
                                vsts_get_repos(self$domain, self$project, private$auth_key)
                              },
                              create_repo = function(repo) {
                                private$proj_check()
                                vsts_create_repo(self$domain, self$project, repo, private$auth_key)
                              },
                              delete_repo = function(repo) {
                                private$proj_check()
                                vsts_delete_repo(self$domain, self$project, repo, private$auth_key)
                              },

                              get_commits = function(repo, query = NULL) {
                                vsts_get_commits(self$domain, self$project, repo, private$auth_key, query = query)
                              },

                              get_workitems = function(query = NULL) {
                                vsts_get_workitems(self$domain, private$auth_key, query = query)
                              },
                              get_workitem = function(id) {
                                vsts_get_workitem(self$domain, private$auth_key, id = id)
                              },
                              create_workitem = function(item_type, ...) {
                                vsts_create_workitem(self$domain, self$project, item_type, private$auth_key, ...)
                              },

                              custom_command = function(url, verb, body = NULL, query = NULL) {
                                vsts_run_command(url, verb, private$auth_key, body, query)
                              }

                            ),

                            private = list(
                              pass = NULL,
                              auth_key = NULL,

                              get_auth_key = function(user, pass) vsts_auth_key(user, pass),
                              proj_check = function() if(is.null(self$project)) stop('Project name must be included in \'project\'')
                            ))
