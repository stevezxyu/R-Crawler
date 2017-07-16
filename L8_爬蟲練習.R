# 爬蟲練習
library(rvest)

url <- "https://www.ptt.cc/bbs/hotboards.html"

# 擷取批踢踢熱門板版名
ptt_hot_boards <- read_html(url)
hot_boards  <- ptt_hot_boards %>%
    html_nodes(css = ".board-name") %>%
    html_text()
hot_boards

# 練習1
# 擷取批踢踢各版人氣數
ptt_hot_boards <- read_html(url)
hot_boards_viewer  <- ptt_hot_boards %>%
  html_nodes(css = ".hl") %>%
  html_text() %>%
  as.integer()
hot_boards_viewer


#  for 迴圈
ptt_hot_boards_crawler <- function(){
  url <- "https://www.ptt.cc/bbs/hotboards.html"
  html_doc <- read_html(url)
  
  ptt_hot_boards <- list()
  
  boards_css <- ".board-name"
  viewers_css <- ".hl"
  class_css <- ".board-class"
  titles_css <- ".board-title"
  columns <- c(boards_css, viewers_css, class_css, titles_css)
  
  for (i in 1:length(columns)) {
    content <- html_doc %>%
      html_nodes(css = columns[i]) %>%       # 每次都從columns擷取
      html_text()
    ptt_hot_boards[[i]]  <- content
    
  }
  names(ptt_hot_boards)  <- c("boards", "viewers", "classes", "titles")
  ptt_hot_boards$viewer <- as.integer(ptt_hot_boards$viewer)
  return(ptt_hot_boards)
}

current_ptt_hotties <- ptt_hot_boards_crawler()
current_ptt_hotties$boards
View(current_ptt_hotties)


# 練習2
# 將熱門看板的連結抓出來
# 提示：css selector 改用 .board
# 改用 html_attr("href") 而非 html_text()
url <- "https://www.ptt.cc/bbs/hotboards.html"
html_doc <- read_html(url)

content <- html_doc %>%
  html_nodes(css = ".board") %>%
  html_attr("href")      # 擷取網頁的超連結

# 加上前面的網址
content <- paste("https://www.ptt.cc", content, sep = "")

# 改用href
# data.frame丟東西進去, 很麻煩
# 建議使用 list
ptt_hot_boards_crawler <- function(){
  url <- "https://www.ptt.cc/bbs/hotboards.html"
  html_doc <- read_html(url)
  
  ptt_hot_boards <- list()
  
  boards_css <- ".board-name"
  viewers_css <- ".hl"
  class_css <- ".board-class"
  titles_css <- ".board-title"
  columns <- c(boards_css, viewers_css, class_css, titles_css)
  
  for (i in 1:length(columns)) {
    content <- html_doc %>%
      html_nodes(css = columns[i]) %>%
      html_text()
    ptt_hot_boards[[i]] <- content
  }
  
  names(ptt_hot_boards) <- c("boards", "viewers", "classes", "titles")
  ptt_hot_boards$viewers <- as.integer(ptt_hot_boards$viewers)
  board_links <- html_doc %>%
    html_nodes(css = ".board") %>%
    html_attr("href")
  board_links <- paste("https://www.ptt.cc", board_links, sep = "")
  ptt_hot_boards$links <- board_links
  return(ptt_hot_boards)
}

current_ptt_hotties <- ptt_hot_boards_crawler()
current_ptt_hotties$links
View(current_ptt_hotties)

# 使用data.frame (較不建議使用)
ptt_hot_boards_crawler <- function(){
  url <- "https://www.ptt.cc/bbs/hotboards.html"
  html_doc <- read_html(url)
  
  ptt_hot_boards <- list()
  
  boards_css <- ".board-name"
  viewers_css <- ".hl"
  class_css <- ".board-class"
  titles_css <- ".board-title"
  columns <- c(boards_css, viewers_css, class_css, titles_css)
  
  for (i in 1:length(columns)) {
    content <- html_doc %>%
      html_nodes(css = columns[i]) %>%
      html_text()
    ptt_hot_boards[[i]] <- content
  }
  
  names(ptt_hot_boards) <- c("boards", "viewers", "classes", "titles")
  ptt_hot_boards$viewers <- as.integer(ptt_hot_boards$viewers)
  board_links <- html_doc %>%
    html_nodes(css = ".board") %>%
    html_attr("href")
  board_links <- paste("https://www.ptt.cc", board_links, sep = "")
  ptt_hot_boards$links <- board_links
  ptt_hot_boards_df <- data.frame(boards = ptt_hot_boards$boards, 
                                  viewers = ptt_hot_boards$viewers,
                                  classes = ptt_hot_boards$classes,
                                  titles = ptt_hot_boards$titles,
                                  links = ptt_hot_boards$links)
  return(ptt_hot_boards_df)
}

current_ptt_hotties <- ptt_hot_boards_crawler()
View(current_ptt_hotties)


