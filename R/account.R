#' Visual Studio Team Services Account
#'
#' @details
#' For the majority of functions that are within this \code{vsts_account} object, you can get help about the
#' query or body parameter with \code{?vsts_<function name>}.
#'
#' @param user username for the Visual Studio account
#' @param pass password for the Visual Studio account
#' @param domain domain name for the Visual Studio account
#' @param project (optional) project name within the domain of the Visual Studio account
#' @param repo (optional) repository name with the project of the Visual Studio domain
#'
#' @docType class
#' @format An \code{\link[R6]{R6Class}} generator object
#' @keywords data
#'
#' @examples
#' \dontrun{
#' proj <- vsts_account$new(
#'   "<username>", "<password>", "<domain>",
#'   "<project>", "<repo>"
#' )
#' str(proj)
#' }
#'
#' @export
vsts_account <- R6::R6Class(
  classname = "vsts",
  public = list(
    initialize = function(user = NA, pass = NA, domain = NA, project = NULL, repo = NULL) {
      private$user <- user
      private$pass <- pass
      private$auth_key <- private$get_auth_key(user, pass)
      private$domain <- domain
      private$projects <- vsts_get_projects(private$domain, private$auth_key, quiet = TRUE)$name
      if (!is.null(project)) {
        if (!project %in% private$projects) stop(project, " is not available in selected domain.")
        private$project <- project
        private$repos <- vsts_get_repos(private$domain, private$project, private$auth_key, quiet = TRUE)$name
      }
      if (!is.null(repo)) {
        if (is.null(project)) stop("`project` needs to be specified to include repository.")
        if (!repo %in% private$repos) stop(repo, " is not available in selected project.")
        private$repo <- repo
      }
    },
    set_domain = function(dom) {
      private$domain <- dom
      proj_df <- vsts_get_projects(private$domain, private$auth_key, quiet = TRUE)
      private$projects <- proj_df$name
      invisible(TRUE)
    },
    set_project = function(proj) {
      if (is.null(private$projects)) {
        proj_df <- vsts_get_projects(private$domain, private$auth_key, quiet = TRUE)
        private$projects <- proj_df$name
      }
      if (!proj %in% private$projects) stop(proj, " not in available projects.")
      private$project <- proj

      repo_df <- vsts_get_repos(private$domain, private$project, private$auth_key, quiet = TRUE)
      private$repos <- repo_df$name
      invisible(TRUE)
    },
    set_repo = function(repo) {
      if (is.null(private$repos)) {
        repo_df <- vsts_get_repos(private$domain, private$project, private$auth_key, quiet = TRUE)
        private$repos <- repo_df$name
      }
      if (!repo %in% private$repos) stop(repo, " not in available repositories.")
      private$repo <- repo
      invisible(TRUE)
    },
    get_projects = function() vsts_get_projects(private$domain, private$auth_key),
    get_repos = function() {
      private$proj_check()
      vsts_get_repos(private$domain, private$project, private$auth_key)
    },
    create_repo = function(repo) {
      private$proj_check()
      if (repo %in% private$repos) stop(repo, " already exists in ", private$project, ".")
      content <- vsts_create_repo(private$domain, private$project, repo, private$auth_key)
      private$repos <- vsts_get_repos(private$domain, private$project, private$auth_key, quiet = TRUE)$name
      invisible(content)
    },
    delete_repo = function(repo) {
      private$proj_check()
      if (!repo %in% private$repos) stop(repo, " does not exist in ", private$project, ".")
      content <- vsts_delete_repo(private$domain, private$project, repo, private$auth_key)
      private$repos <- vsts_get_repos(private$domain, private$project, private$auth_key, quiet = TRUE)$name
      invisible(content)
    },
    get_commits = function(query = NULL) {
      private$repo_check()
      vsts_get_commits(private$domain, private$project, private$repo, private$auth_key, query = query)
    },
    get_workitems = function(query = NULL) {
      vsts_get_workitems(private$domain, private$auth_key, query = query)
    },
    get_workitem = function(id) {
      vsts_get_workitem(private$domain, private$auth_key, id = id)
    },
    create_workitem = function(item_type, ...) {
      private$proj_check()
      vsts_create_workitem(private$domain, private$project, item_type, private$auth_key, ...)
    },
    get_releases = function(query = NULL) {
      private$proj_check()
      vsts_get_releases(private$domain, private$project, private$auth_key, query = query)
    },
    get_release = function(id) {
      private$proj_check()
      vsts_get_release(private$domain, private$project, id, private$auth_key)
    },
    create_release = function(body = NULL) {
      private$proj_check()
      vsts_create_release(private$domain, private$project, private$auth_key, body = body)
    },
    deploy_release = function(release_id, env_id) {
      private$proj_check()
      vsts_deploy_release(private$domain, private$project,
        release = release_id,
        env = env_id, private$auth_key
      )
    },
    get_build_defs = function(query = NULL) {
      private$proj_check()
      vsts_get_build_defs(private$domain, private$project, private$auth_key, query = query)
    },
    get_release_defs = function() {
      private$proj_check()
      vsts_get_release_defs(private$domain, private$project, private$auth_key)
    },
    custom_command = function(url, verb, body = NULL, query = NULL) {
      vsts_run_command(url, verb, private$auth_key, body, query)
    }
  ),
  private = list(
    # Making sure these are not easily editable
    user = NULL,
    domain = NULL,
    project = NULL,
    repo = NULL,
    pass = NULL,
    auth_key = NULL,
    projects = NULL,
    repos = NULL,
    get_auth_key = function(user, pass) vsts_auth_key(user, pass),
    proj_check = function() {
      if (is.null(private$project)) stop("Project name must be added to object. Use `$set_project()`")
    },
    repo_check = function() {
      if (is.null(private$repo)) stop("Repository name must be added to object. Use `$set_repo()`")
    }
  )
)
