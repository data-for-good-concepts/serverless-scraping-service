# Install base package
FROM rocker/r-ver:4.1.1

# User privileges
USER root

# Set environment variables
ENV RENV_VERSION 0.16.0
ENV RENV_PATHS_LIBRARY renv/library

# Install `renv` in order install package dependencies
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org')); \
          remotes::install_github('rstudio/renv@${RENV_VERSION}');"

# Set working directory
WORKDIR /usr/scraper

# Install required linux dependencies
RUN apt-get update --quiet \
 && apt-get install --no-install-recommends --assume-yes \
            libxml2-dev \
            libssl-dev \
            libcurl4-openssl-dev \
            libsodium-dev \
            libz-dev \
            default-jdk \
            firefox \
            wget \
    \
 # Install geckodriver for Firefox
 && wget https://github.com/mozilla/geckodriver/releases/download/v0.32.0/geckodriver-v0.32.0-linux64.tar.gz \
 && tar -xvzf geckodriver* \
 && chmod +x geckodriver

# Install pre-compiled R package dependencies
COPY renv.lock renv.lock
RUN R -e "renv::restore(repos = c(RSPM = 'https://packagemanager.rstudio.com/cran/latest'))"

# Remove unused files
RUN rm geckodriver-v0.32.0-linux64.tar.gz

COPY src/ ./

EXPOSE 8080

ENTRYPOINT ["Rscript"]
CMD ["server.R"]
