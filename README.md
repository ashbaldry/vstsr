# vstsr
Visual Studio Team Services and R

Trying out writing APIs connecting R and Visual Studio Team Services using R6 objects.

## Initialisation
```
install_github('ashbaldry/vstsr')
vsts_info <- vsts_account$new(user = '<USER NAME>', pass= '<PASSWORD>', domain = '<VS DOMAIN>', project = '<VS PROJECT>')
```
