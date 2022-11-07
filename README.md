
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Eurostat Scraper <img src="man/figures/logo.png" align="right" height="139"/>

<!-- badges: start -->

[![Lifecycle:
experimental](https://lifecycle.r-lib.org/articles/figures/lifecycle-experimental.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![deploy-cloudrun](https://github.com/data-for-good-concepts/eurostat-scraper/actions/workflows/deploy-cloudrun.yaml/badge.svg)](https://github.com/data-for-good-concepts/eurostat-scraper/actions/workflows/deploy-cloudrun.yaml)
[![build](https://github.com/data-for-good-concepts/eurostat-scraper/actions/workflows/dry-run-docker-build.yaml/badge.svg)](https://github.com/data-for-good-concepts/eurostat-scraper/actions/workflows/dry-run-docker-build.yaml)

<!-- badges: end -->

> *⚠️ Please note, that the documentation of this project is still
> **Work In Progress**. The description might be incomplete and is
> subject to constant change.*

The **Eurostat Scraper** is a working example on how to wrap a web
scraper in a web service and deploy it on the cloud using R. This
project aims to showcase different aspects when it comes to web scraping
in general, as well as different technologies when deploying your work
in production.

This example scrapes the *‘Asylum applicants by type of applicant,
citizenship, age and sex - monthly data’* from the [**Eurostat Data
Browser**](https://ec.europa.eu/eurostat/databrowser/view/MIGR_ASYAPPCTZM/default/table?lang=en).
The scraper can be triggered by a `POST` request to the API endpoint in
which the scraper is wrapped in, and it returns the scraped data as part
of the `response` object. Even though this example has been developed to
scrape one particular dataset, any other dataset that is available as
part of the **Eurostat Data Browser** can be scraped with little to no
adjustments.

Following tools and technologies will be highlighted or are heavily in
use as part of this example - `RSelenium`, `plumber`, `Docker`,
`Google Cloud Build`, `Google Cloud Run` and `GitHub Actions`.

### Usage

#### Localhost

When you are running the scraping service locally, make sure you start
web service executing following command in your R console.

``` r
source('src/server.R')
```

#### Trigger default scraping job

Start scraping job making a `POST` request to the trigger endpoint. When
you are working locally, replace `<URL>` with `localhost:8080`. When you
have the web service deployed on Google Cloud Run, use the public URL of
your Cloud Run service.

``` bash
curl --location --request POST '<URL>/api/v1/scraper/job'
```

### Deployment

### Prerequisites

Before you get started, make sure you are familiar with the following
packages and tools.

In order to run this web service on Google Cloud, please make sure you
have a [Google Cloud Account](https://cloud.google.com/) and that you
are familiar with the tools that we will use for deployment.

- [Docker](https://docker-curriculum.com/)  

- [GitHub
  Actions](https://github.blog/2022-06-03-a-beginners-guide-to-ci-cd-and-automation-on-github/)

- [gcloud CL](https://cloud.google.com/sdk/gcloud)  

- [Google Cloud Service
  Account](https://cloud.google.com/iam/docs/service-accounts)  

- [Google Cloud
  Build](https://cloud.google.com/build/docs/overview#:~:text=Cloud%20Build%20is%20a%20service,Docker%20containers%20or%20Java%20archives.)  

- [Google Cloud
  Run](https://cloud.google.com/run/docs/overview/what-is-cloud-run)

- [ ] Service account creation + permissions

- [ ] Enable APIs (Cloud Build, Cloud Run)

Replace `<REGION>` with the [Google Cloud
region](https://cloud.google.com/compute/docs/regions-zones), you want
to use for the deployment of your web service.

``` bash
gcloud builds submit --region='<REGION>'
```

------------------------------------------------------------------------

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree
to abide by its terms.
