# vstsr

[![Build Status](https://travis-ci.org/ashbaldry/vstsr.svg?branch=master)](https://travis-ci.org/ashbaldry/vstsr)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/ashbaldry/vstsr?branch=master&svg=true)](https://ci.appveyor.com/project/ashbaldry/vstsr)

The aim of `vstsr` is to make it easier to connect between R and Azure DevOps.

Commands will include getting repository information, git services and work item information.

## Installation

```
install_github('ashbaldry/vstsr')
library(vstsr)
```

## Initialisation

There are two ways to use the `vstsr` package:
1. Creating an R6 object using `vsts_account` that contains simple methods to do all of the functions that are available in the package.
2. Create an authorisation key using `vsts_auth_key` and then using that to run each of the functions within the package. 

#### Method 1:
```
proj <- vsts_account$new(user = '<USER NAME>', pass= '<PASSWORD>', 
                         domain = '<VS DOMAIN>', project = '<VS PROJECT>')
```

#### Method 2:
```
auth_key <- vsts_auth_key(user = '<USER NAME>', pass= '<PASSWORD>')
```
