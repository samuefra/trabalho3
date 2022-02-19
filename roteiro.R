install.packages("rvest")
library("rvest")
library(dplyr)
link="https://www.imdb.com/search/title/?genres=history&sort=user_rating,desc&title_type=feature&num_votes=25000,&pf_rd_m=A2FGELUUNOQJNL&pf_rd_p=5aab685f-35eb-40f3-95f7-c53f09d542c3&pf_rd_r=50P7JT1W86967Z81XB80&pf_rd_s=right-6&pf_rd_t=15506&pf_rd_i=top&ref_=chttp_gnr_11"
page=read_html(link)

name= page %>% html_nodes(".lister-item-header a") %>% html_text()
year =  page %>% html_nodes(".text-muted.unbold") %>% html_text()
ratings = page %>% html_nodes(".ratings-imdb-rating strong") %>% html_text()
tempo= page %>% html_nodes(".runtime") %>% html_text()
diretor=page %>% html_nodes(".text-muted+ p a:nth-child(1)") %>% html_text()
votos= page %>% html_nodes(".sort-num_votes-visible span:nth-child(2)") %>% html_text()
movies = data.frame(name, year, ratings, tempo, votos, diretor , stringsAsFactors = TRUE)

ano <- movies %>%
  count(year)%>%
arrange(desc(n))%>%
  head(12)


library(ggplot2)
ggplot(ano, aes(x=year,y=n)) +
  geom_bar(stat="identity" , colour="red") +
ggtitle("Anos com mais de um filme entre os 50 melhores na categoria historia ") +
xlab("ano") +
ylab("filmes")

director<-movies%>%
  count(diretor)%>%
  arrange(desc(n))%>%
  head(4)

pie(director$n,labels = c( "Shoojit Sircar 2", "Steven Spilberg 2", "Thomas Kail 2", "Can Ulkay 2"))
save(movies, file = "movies.csv")



          

