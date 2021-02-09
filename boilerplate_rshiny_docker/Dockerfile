FROM rocker/shiny-verse:4.0.3

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y \
  curl \
  iputils-ping \
  gnupg2 \
  libcurl4-gnutls-dev \
  libssl-dev \
  libgsl0-dev \
  libxml2-dev \
  libgdal-dev \
  libproj-dev \
  libudunits2-dev \
  openjdk-11-jre \
  r-cran-tcltk2 \
  unixodbc \
  apt-utils

# Clean up
RUN rm -r /srv/shiny-server; 

# Add Microsoft repo for buster
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update -y
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17
RUN apt-get update -y && apt-get upgrade -y
RUN apt clean

# Change driver name to match naming used in R (-> keep one name in secrets.json)
RUN sed -i 's/ODBC Driver 17 for SQL Server/SQL Server/' /etc/odbcinst.ini

# Install R packages
RUN R -e "install.packages('RODBC', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages(c('shiny', 'rJava', 'shinydashboard', 'shinybusy', 'import', 'tidyverse', 'jsonlite', 'odbc', 'dbplyr', 'DBI', 'AzureStor', 'leaflet', 'sf', 'lubridate', 'glue', 'DT', 'xlsx', 'RPostgreSQL', 'gsubfn', 'rgdal'))"

# Copy application and secrets
# COPY /app /srv/shiny-server/
COPY app.R /srv/shiny-server/app.R
COPY shiny-server.conf /etc/shiny-server/shiny-server.conf
COPY shiny-server.sh /usr/bin/shiny-server.sh

RUN chmod -R +rx /srv/shiny-server/

COPY secrets/secrets.json /srv/shiny-server/secrets/secrets.json

USER shiny 
EXPOSE 3838
CMD ["/usr/bin/shiny-server.sh"]
