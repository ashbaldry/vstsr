#' Visual Studio Team Services Account
#'
#' @description
#' In order to call any of the APIs to VSTS, credentials to access the server are needed. Once these have been set-up they won't
#' need to be used in a session.
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
                              }

                            ),

                            private = list(
                              pass = NULL,
                              auth_key = NULL,

                              get_auth_key = function(user, pass) vsts_auth_key(user, pass),
                              proj_check = function() if(is.null(self$project)) stop('Project name must be included in \'project\'')
                            ))
