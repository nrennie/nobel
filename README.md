# nobel

> This package is currently a work-in-progress.

The {nobel} R package allows you to access Nobel Prize data via API.

The Nobel Prize API endpoint can be accessed directly at [https://api.nobelprize.org/2.1/laureates](https://api.nobelprize.org/2.1/laureates), with some instructions and guidance about how to use it available on the [nobelprize.org](https://www.nobelprize.org/) website at [www.nobelprize.org/organization/developer-zone-2](https://www.nobelprize.org/organization/developer-zone-2/), which also links to the [Terms of Use](https://www.nobelprize.org/organization/terms-of-use-for-api-nobelprize-org-and-data-nobelprize-org/).

## Installation

Install development version from GitHub using:

```r
remotes::install_github("nrennie/nobel")
```

## Examples

First 5 results on laureates:

```r
laureates(limit = 5)
```

First 5 results on prizes:

```r
nobelPrizes(limit = 5)
```
