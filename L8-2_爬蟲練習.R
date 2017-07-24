# 爬蟲練習
install.packages("rvest")
install.packages("xml2")
library(rvest)
library(xml2)

url <- "https://www.ptt.cc/bbs/NBA/index.html"
raw_html <- read_html(url)

# 先把看得到的抓出來：推文數, 文章標題, ID
ptt_index_parser <- function(url){
  url <- url                        # 不要寫死 url
  raw_html <- read_html(url)
  
  nrec_xpath <- "//div[@class='nrec']"
  title_xpath <- "//div[@class='title']"
  id_xpath <- "//div[@class='meta']/div[@class='author']"
  
  articles <- list()
  cols <- c(nrec_xpath, title_xpath, id_xpath)
  
  for (i in 1:length(cols)) {
    content <- raw_html %>%
      html_nodes(xpath = cols[i]) %>%           # 用 xpath取出 nodes, cols裡第i個 xpath
      html_text()
    articles[[i]] <- content                    # insert到 content裡面的 list
  }
  names(articles) <- c("recs", "titles", "ids")
  articles$titles <- gsub(pattern = "\n\t+\n\t+", articles$titles, replacement = "")      # 清理標題內的雜訊
  return(articles)
}

nba_index <- ptt_index_parser("https://www.ptt.cc/bbs/NBA/index.html")     # 呼叫函數, 輸入 url
nba_index$recs
nba_index$titles
nba_index$ids


# 練習 1
article_detail <- function(url){
  raw_html <- read_html(url)
  
  author_css <- ".article-metaline:nth-child(1) .article-meta-value"
  title_css <- ".article-metaline-right+ .article-metaline .article-meta-value"
  time_css <- ".article-metaline+ .article-metaline .article-meta-value"
  main_content_css <- "#main-content"
  ip_css <- ".richcontent+ .f2"
  push_css <- ".push-tag"
  push_id_css <- ".push-userid"
  push_content_css <- ".push-content"
  push_time_css <- ".push-ipdatetime"
  
  article_detail_info <- list()
  columns <- c(author_css, title_css, time_css, main_content_css, ip_css, push_css, push_id_css, push_content_css, push_time_css)
  for (i in 1:length(columns)){
    article_content <- raw_html %>%
      html_nodes(css = columns[i]) %>%
      html_text()
    article_detail_info[[i]] <- article_content
  }
  names(article_detail_info) <- c("author", "title", "time", "main_content", "ip", "push", "push_id", "push_content", "push_time")
  
  # Cleaning contents 清理內文
  article_detail_info$main_content <- article_detail_info$main_content %>%
    gsub(pattern = "\n", ., replacement = "") %>%                            # 清理斷行符號, 不是在第一個位置要用"."代替
    gsub(pattern = "作者.+:[0-9]{2}\\s[0-9]{4}", ., replacement = "") %>%    # 去頭, 僅取出「02 2017」之後的內容
    gsub(pattern = "※ 發信站:.+", ., replacement = "")                      # 去尾, 僅取出「※ 發信站:+」之前的內容
  
  # 清理IP
  ip_start <- regexpr(pattern = "[0-9]+", article_detail_info$ip)
  article_detail_info$ip <- gsub(pattern = "\n", article_detail_info$ip, replacement = "")
  ip_end <- nchar(article_detail_info$ip)      # nchar 取出字串的長度
  article_detail_info$ip <- substr(article_detail_info$ip, start = ip_start, stop = ip_end)
  
  # 清理推文
  article_detail_info$push <- gsub(pattern = "\\s", article_detail_info$push, replacement = "")
  
  # 清理推文 ID
  article_detail_info$push_id <- gsub(pattern = "\\s", article_detail_info$push_id, replacement = "")
  
  # 清理推文內容
  article_detail_info$push_content <- article_detail_info$push_content %>%
    gsub(pattern = "\\s", ., replacement = "") %>%
    gsub(pattern = ":", ., replacement = "")
  
  # 清理推文時間
  article_detail_info$push_time <- article_detail_info$push_time %>%
    gsub(pattern = "^\\s", ., replacement = "") %>%
    gsub(pattern = "\n", ., replacement = "")
  
  return(article_detail_info)
}
article_url <- "https://www.ptt.cc/bbs/NBA/M.1500708665.A.EF4.html"
nba_article <- article_detail(article_url)
nba_article     # crawler cleanning的結果


# 十八禁看板
url <- "https://www.ptt.cc/bbs/Gossiping/index.html"
gossiping <- readLines(url)

# 使用 httr 套件所提供的 GET() 函數幫忙設定 cookie
install.packages("httr")
library(httr)
url <- "https://www.ptt.cc/bbs/Gossiping/index.html"
ptt_gossiping <- GET(url, set_cookies(over18 = 1))        # cookie value = 1 表示已瀏覽過, 下次可以 skip頁面
gossiping <- ptt_gossiping %>%
  read_html() %>%
  html_nodes(css = ".tltle a") %>%    # 首頁有 title
  html_text()

# 練習2
library(rvest)
library(httr)

article_detail <- function(url){
  url <- GET(url, set_cookies(over18 = 1))                # cookie value = 1 表示已瀏覽過, 帶有 cookie over18 = 1
  raw_html <- read_html(url)
  
  author_css <- ".article-metaline:nth-child(1) .article-meta-value"
  title_css <- ".article-metaline-right+ .article-metaline .article-meta-value"
  time_css <- ".article-metaline+ .article-metaline .article-meta-value"
  main_content_css <- "#main-content"
  ip_css <- ".richcontent+ .f2"
  push_css <- ".push-tag"
  push_id_css <- ".push-userid"
  push_content_css <- ".push-content"
  push_time_css <- ".push-ipdatetime"
  
  article_detail_info <- list()
  columns <- c(author_css, title_css, time_css, main_content_css, ip_css, push_css, push_id_css, push_content_css, push_time_css)
  for (i in 1:length(columns)){
    article_content <- raw_html %>%
      html_nodes(css = columns[i]) %>%
      html_text()
    article_detail_info[[i]] <- article_content
  }
  names(article_detail_info) <- c("author", "title", "time", "main_content", "ip", "push", "push_id", "push_content", "push_time")
  # Cleaning contents
  article_detail_info$main_content <- article_detail_info$main_content %>%
    gsub(pattern = "\n", ., replacement = "") %>%
    gsub(pattern = "作者.+:[0-9]{2}\\s[0-9]{4}", ., replacement = "") %>%
    gsub(pattern = "※ 發信站:.+", ., replacement = "")
  
  ip_start <- regexpr(pattern = "[0-9]+", article_detail_info$ip)
  article_detail_info$ip <- gsub(pattern = "\n", article_detail_info$ip, replacement = "")
  ip_end <- nchar(article_detail_info$ip)
  article_detail_info$ip <- substr(article_detail_info$ip, start = ip_start, stop = ip_end)
  
  article_detail_info$push <- gsub(pattern = "\\s", article_detail_info$push, replacement = "")
  article_detail_info$push_id <- gsub(pattern = "\\s", article_detail_info$push_id, replacement = "")
  article_detail_info$push_content <- article_detail_info$push_content %>%
    gsub(pattern = "\\s", ., replacement = "") %>%
    gsub(pattern = ":", ., replacement = "")
  article_detail_info$push_time <- article_detail_info$push_time %>%
    gsub(pattern = "^\\s", ., replacement = "") %>%
    gsub(pattern = "\n", ., replacement = "")
  
  return(article_detail_info)
}
article_url <- "https://www.ptt.cc/bbs/Gossiping/M.1500713671.A.516.html"
gossiping_article <- article_detail(article_url)
gossiping_article

