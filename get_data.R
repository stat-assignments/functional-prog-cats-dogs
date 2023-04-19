# Source key and secret from petfinder-api-key.R
# Get your own key at https://www.petfinder.com/developers/signup/
key <- "# Your key here"
secret <- "# Your secret here"
source("homework-repos/10-functional-prog/petfinder-api-key.R")

library(rvest)
library(xml2)

endpoint <- 'oauth2/token'
url <- "https://api.petfinder.com/v2/"
req <- httr::POST(paste0(url, endpoint),
                  body = list("grant_type"="client_credentials",
                              "client_id" = key,
                              "client_secret" = secret),
                  encode="json"
)

token <- httr::content(req)$access_token

dogs <- httr::GET(
  paste0(url, "animals?type=dog&good_with_children=true&location=68503"),
  httr::add_headers(Authorization = paste0('Bearer ', token, sep = ''))
)

library(jsonlite)
dogstr <- fromJSON(httr::content(dogs, as = "text", encoding = "UTF8"))
write_json(dogstr, "homework-repos/10-functional-prog/dogs.json")



cats <- httr::GET(
  paste0(url, "animals?type=cat&good_with_children=true&location=68503"),
  httr::add_headers(Authorization = paste0('Bearer ', token, sep = ''))
)

library(jsonlite)
catstr <- fromJSON(httr::content(cats, as = "text", encoding = "UTF8"))
write_json(catstr, "homework-repos/10-functional-prog/cats.json")

