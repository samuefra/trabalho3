FROM rocker/tidyverse:4.0.0
RUN R -e "install.packages('rvest')"
COPY /roteiro.R /roteiro.R
CMD Rscript /roteiro.R