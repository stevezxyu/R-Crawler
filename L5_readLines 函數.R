# readLines() 函數
install.packages("magrittr")
library(magrittr)

# 將網頁的 html 檔案讀成一個文字向量
fs_scripts <- readLines("http://livesinabox.com/friends/season1/101pilot.htm")

length(fs_scripts)                # 可看網頁內容的長度
head(fs_scripts, n = 20)          # 可看前20行程式的原始碼


fs_s1e1 <- readLines("http://livesinabox.com/friends/season1/101pilot.htm")
character_pattern <- "Joey:|Monica:|Ross:|Rachel:|Chandler:|Phoebe:"          # 把文字pattern聯集起來, 輸入為向量
found_character <- grepl(pattern = character_pattern, fs_s1e1)                # 轉換為 Boolean顯示
head(found_character, n = 50)
  
  
fs_s1e1[found_character]          # 文字向量用判斷篩選出有"台詞"的向量
character_script <- fs_s1e1[found_character]
length(fs_s1e1)                   # 擷取篩選後的文字向量元素
head(character_script)            # 查看內容, 發現被某些文字包圍住


# 清理前後的標籤 <p></p>、<b></b>、<strong></strong>
fs_s1e1[found_character] %>%
  gsub(pattern = "<p(>|.*)(<b>|<strong>)", replacement = "") %>%
  gsub(pattern = "(</b>|</strong>).*", replacement = "") %>%
  head()

# 清理冒號或多餘的空格
result <- fs_s1e1[found_character] %>%
  gsub(pattern = "<p(>|.*)(<b>|<strong>)", replacement = "") %>%
  gsub(pattern = "(</b>|</strong>).*", replacement = "") %>%
  gsub(pattern = "(:\\s)|:", replacement = "")
result

# 做成表格和統計圖
table(result)
barplot(table(result), horiz = T)
res_table <- sort(table(result))    # 排順序由小到大
res_table                           # 確認是由小到大排序
barplot(res_table, las = 2)         # 有排序的 barplot

# 以上可用 rvest 套件的方式擷取網路的網頁

