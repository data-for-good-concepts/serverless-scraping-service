# Install base package
FROM rocker/r-ver

# User privileges
USER root

# Set environment variables
ENV RENV_VERSION 0.16.0
ENV RENV_PATHS_LIBRARY renv/library

# Install `renv` in order install package dependencies
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

# Set working directory
WORKDIR /usr/scraper

# Install required dependencies
RUN apt-get update -qq \
    && apt-get -y --no-install-recommends install \
       libxml2-dev \
       default-jdk \
       firefox \
    && apt-get install -y libcurl4-openssl-dev \
    && apt-get install wget \
    && wget https://github.com/mozilla/geckodriver/releases/download/v0.32.0/geckodriver-v0.32.0-linux64.tar.gz \
    && tar -xvzf geckodriver* \
    && chmod +x geckodriver

# Prevent issues installing `httpuv`
RUN apk add --no-cache --update-cache --repository http://nl.alpinelinux.org/alpine/v3.8/main alsa-lib-dev=1.1.6-r0

COPY . .

# Install package dependencies
RUN R -e "renv::restore()"

EXPOSE 8080

ENTRYPOINT ["Rscript"]
CMD ["server.R"]
