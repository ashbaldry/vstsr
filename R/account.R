#' Visual Studio Team Services Account
#'
#' @docType class
#' @format An \code{\link{R6Class}} generator object
#' @keywords data
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
                                vsts_create_repos(self$domain, self$project, repo, private$auth_key)
                              },
                              delete_repo = function(repo) {
                                private$proj_check()
                                vsts_delete_repos(self$domain, self$project, repo, private$auth_key)
                              },

                              get_commits = function(repo, query = NULL) {
                                vsts_get_commits(self$domain, self$project, repo, private$auth_key, query = query)
                              }

                            ),

                            private = list(
                              pass = NULL,
                              auth_key = NULL,

                              get_auth_key = function(user, pass) vsts_auth_key(user, pass),
                              proj_check = function() if(is.null(self$project)) stop('Project name must be included in \'project\'')
                            ))
