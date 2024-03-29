% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/repository.R
\name{vsts_get_repos}
\alias{vsts_get_repos}
\alias{vsts_create_repo}
\alias{vsts_delete_repo}
\title{Azure DevOps Project Repositories}
\usage{
vsts_get_repos(domain, project, auth_key, quiet = FALSE)

vsts_create_repo(domain, project, repo, auth_key, quiet = FALSE)

vsts_delete_repo(domain, project, repo, auth_key, quiet = FALSE)
}
\arguments{
\item{domain}{The name of the Azure DevOps organization}

\item{project}{Project ID or project name}

\item{auth_key}{authentication key generated by using \code{\link{vsts_auth_key}}}

\item{quiet}{logical whether want general running information from printing. Any issue with the API call will
still show up if set to \code{TRUE}}

\item{repo}{the name of the repository in \code{project} to look at. Leave as \code{""} to get all repositories
within all projects of the domain}
}
\description{
These functions will allow you to scrape project information from Azure DevOps.
}
\details{
For more information about repository API calls check
\url{https://docs.microsoft.com/en-us/rest/api/azure/devops/git}.
}
\examples{
\dontrun{
# Add in own details to get a non-NULL output
auth_key <- vsts_auth_key("<username>", "<password>")

# Get repo list
vsts_get_repos("domain", "project", auth_key)

# Create new repo
vsts_create_repo("domain", "project", "repo", auth_key)

# Delete existing repo
vsts_delete_repo("domain", "project", "repo", auth_key)
}

}
