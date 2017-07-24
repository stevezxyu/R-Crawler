# 爬蟲練習 2
url <- "http://ecshweb.pchome.com.tw/search/v3.3/?q=macbook%20pro"
pchome_test <- readLines(url)
pchome_test      # 看不到商品資訊, 儲存在背後的資料庫, json再回傳出來

# 使用 Chrome外掛 Quick Javascript Switcher
# 若和 Json有關的data, 會放在XHR, JS
# 若放在html的data, 會放在Doc, WS
# XHR -> result... -> Request URL複製起來

install.packages("jsonlite")
library(jsonlite)

# 使用 JSON 從 data.frame 擷取資料
url <- "http://ecshweb.pchome.com.tw/search/v3.3/all/results?q=macbook%20pro&page=1&sort=rnk/dc"
mbp_info<- fromJSON(url)
names(mbp_info)            # 印出每個欄位

mbp_info$totalPage         # 可查看total page
mbp_info$totalRows         # 可查看total row
head(mbp_info$prods)
View(mbp_info$prods)       # prods 是一個data.frame

mbp_info$prods$price       # 從 data.frame 印出產品價格
mbp_info$prods$describe    # 從 data.frame 印出產品描述

# 利用 for迴圈, 從page 1到5 擷取
prod_descrs <- c()
prod_prices <- c()

for(i in 1:5) {
  url <- paste("http://ecshweb.pchome.com.tw/search/v3.3/all/results?q=macbook%20pro&page=", i,"&sort=rnk/dc", sep = "")
  json_lst <- fromJSON(url)
  prod_descrs <- c(prod_descrs, json_lst$prods$describe)     # 從 data.frame 擷取放進向量
  prod_prices <- c(prod_prices, json_lst$prods$price)
  Sys.sleep(sample(2:5, size = 1))                           # 每次間格睡一次, 共睡四次
}
mbp_df <- data.frame(descr = prod_descrs, price = prod_prices)
View(mbp_df)
mbp_info$prods$describe


# Rselenium 應用於網站測試, 此軟體用來模擬瀏覽器可做的動作
# 可使用程式模擬從網站到data 找出來之前的行為

