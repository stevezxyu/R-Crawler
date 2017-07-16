# CSS 與 Xpath 選擇
install.packages("rvest")
library(rvest)

# 使用CSS
# crawler: rating
url <- "http://www.imdb.com/title/tt3783958/"
lalaland <- read_html(url)
rating <- lalaland %>%
  html_nodes(css = "strong span") %>%
  html_text() %>%      # 僅擷取段落的文字
  as.numeric()
rating

# crawler: cast
url <- "http://www.imdb.com/title/tt3783958/"
lalaland <- read_html(url)
cast <- lalaland %>%
  html_nodes(css = ".itemprop .itemprop") %>%
  html_text()
cast


# 練習1
# 使用 CSS 選擇將 https://tw.stock.yahoo.com/d/i/rank.php?t=pri&e=tse 的股票代號/名稱與成交價抓出來

# 擷取名稱id
yahoo_stock_url <- "https://tw.stock.yahoo.com/d/i/rank.php?t=pri&e=tse"
price_rank <- read_html(yahoo_stock_url)

stock_name_idx <- price_rank %>%
  html_nodes(css = ".name a") %>%
  html_text()
stock_name_idx

# 將空白與文字切隔開
name_split <- strsplit(stock_name_idx, split = "\\s")
stock_idx <- c()
stock_name <- c()
for (i in 1:length(name_split)) {
  stock_idx[i] <- name_split[[i]][1]
  stock_name[i] <- name_split[[i]][2]
}
stock_idx
stock_name

# 擷取股價
stock_price <- price_rank %>%
  html_nodes(css = ".name+ td") %>%
  html_text() %>%
  as.numeric()
stock_price

stock_df <- data.frame(ticker = stock_idx, name = stock_name, 
                       price = stock_price)
View(stock_df)


# 使用Xpath
# crawler: rating
url <- "http://www.imdb.com/title/tt3783958/"
lalaland <- read_html(url)
rating <- lalaland %>%
  html_nodes(xpath = "//strong/span") %>%
  html_text() %>%      # 僅擷取段落的文字
  as.numeric()
rating

# crawler: cast
url <- "http://www.imdb.com/title/tt3783958/"
lalaland <- read_html(url)
cast <- lalaland %>%
  html_nodes(xpath = "//td[@class='itemprop']/a/span[@class='itemprop']") %>%
  html_text()
cast


# 練習2
# 使用 Xpath 選擇將 https://tw.stock.yahoo.com/d/i/rank.php?t=pri&e=tse 的股票代號/名稱與成交價抓出來

# 擷取名稱id
yahoo_stock_url <- "https://tw.stock.yahoo.com/d/i/rank.php?t=pri&e=tse"
price_rank <- read_html(yahoo_stock_url)

stock_name_idx <- price_rank %>%
  html_nodes(xpath = "//td[@class='name']/a") %>%
  html_text()
stock_name_idx

# 將空白與文字切隔開
name_split <- strsplit(stock_name_idx, split = "\\s")
stock_idx <- c()
stock_name <- c()
for (i in 1:length(name_split)) {
  stock_idx[i] <- name_split[[i]][1]
  stock_name[i] <- name_split[[i]][2]
}
stock_idx
stock_name

# 擷取股價
stock_price <- price_rank %>%
  html_nodes(xpath = "//table[2]/tbody/tr/td[3]") %>%
  html_text() %>%
  as.numeric()
stock_price

stock_df <- data.frame(ticker = stock_idx, name = stock_name, 
                       price = stock_price)
View(stock_df)

