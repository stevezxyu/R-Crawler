# rvest() 函數
install.packages("rvest")
library(rvest)

url <- "http://www.imdb.com/title/tt3783958/"
lalaland <- read_html(url)
class(lalaland)            # 是一個 xml 檔案
mode(lalaland)             # 仍屬於list


# html_nodes() 函數
# 從 read_html() 輸出的物件中擷取特定的標籤
# 將 html_nodes() 輸出的物件去除標籤後回傳
lalaland %>% 
  html_nodes(css = "strong span") %>%
  html_text() %>%          # 僅是字串
  as.numeric()             # Ranking 轉換為數值顯示


# 將 CSS selector 換成 XPath selector
# 兩者都支援
lalaland %>% 
  html_nodes(xpath = "//strong/span") %>%
  html_text() %>%
  as.numeric()


# 練習1
# 用 CSS selector 跟 XPath selector 將演員名單擷取出來
# CSS: .itemprop .itemprop
# XPath: //td[@class='itemprop']/a/span[@class='itemprop']

# 使用CSS
cast <- lalaland %>%
  html_nodes(css = ".itemprop .itemprop") %>%
  html_text()
cast

# 使用XPath
cast <- lalaland %>%
  html_nodes(xpath = "//td[@class='itemprop']/a/span[@class='itemprop']") %>%
  html_text()
cast

