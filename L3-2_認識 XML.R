# 認識 XML
install.packages("xml2")
library(xml2)

fs_xml <- "
<Friends>
    <cast>
        <character>Rachel Green</character>
        <star>Jennifer Aniston</star>
    </cast>
    <cast>
        <character>Monica Geller</character>
        <star>Courteney Cox</star>
    </cast>
    <cast>
        <character>Phoebe Buffay</character>
        <star>Lisa Kudrow</star>
    </cast>
    <cast>
        <character>Joey Tribbiani</character>
        <star>Matt LeBlanc</star>
    </cast>
    <cast>
        <character>Chandler Bing</character>
        <star>Matthew Perry</star>
    </cast>
    <cast>
        <character>Ross Geller</character>
        <star>David Schwimmer</star>
    </cast>
</Friends>
"

class(fs_xml)              # 是一個character
fs <- read_xml(fs_xml)     # 輸入文字做解析
class(fs)                  # xml的document

xml_name(fs)      # 每個Node標籤名稱回傳
xml_children(fs)  # 子Nodec標籤名稱回傳
xml_text(fs)      # 標籤拿掉, 僅印出內文
xml_find_all(fs, xpath = ".//star")         # 印出全部star
xml_find_all(fs, xpath = ".//character")    # 印出全部character


# 使用 %>% 加速資料解析
summary(cars)                  # 函數的輸入,呼叫函數
install.packages(magrittr)     # %>% 的使用套件
library(magrittr)
cars %>% summary               # 上一行的輸出是下一行的輸入


Sys.Date() %>%                 # 運用 %>% 簡化程式
    format("%Y") %>%
    as.integer %>%
    `-` (1955)


# 擷取star 和 character 標籤內的文字
xml_find_all(fs, xpath = ".//character")              # 印出全部character
xml_text(xml_find_all(fs, xpath = ".//character"))    # 去除外面的標籤

fs %>%
  xml_find_all(xpath = ".//character") %>%            # 輸出結果相同, 但可讀性較佳
  xml_text()


fs_characters <- fs %>%                               # 得到 character的向量
  xml_find_all(xpath = ".//character") %>%
  xml_text()

fs_stars <- fs %>%                                    # 得到 star的向量
  xml_find_all(xpath = ".//star") %>%
  xml_text()


for(i in 1:length(fs_characters)) {
  print(sprintf("%s 由 %s 飾演", fs_characters[i], fs_stars[i]))
}                                                     # 用 sprintf 輸出兩個向量, 也可用 paste


# 練習1
# 列出芝加哥公牛隊 1995-96 年先發五人的位置與球員
cb_xml <- "
<cb>
    <startfive>
        <position>SF</position>
        <player>Scottie Pippen</player>
    </startfive>
    <startfive>
        <position>PF</position>
        <player>Dennis Rodman</player>
    </startfive>
    <startfive>
        <position>C</position>
        <player>Luc Longley</player>
    </startfive>
    <startfive>
        <position>PG</position>
        <player>Ron Harper</player>
    </startfive>
    <startfive>
        <position>SG</position>
        <player>Michael Jordan</player>
    </startfive>
</cb>
"

cb <- read_xml(cb_xml)                         # 輸入文字做解析

cb_positions <- cb %>%                         # 得到 position的向量
  xml_find_all(xpath = ".//position") %>%
  xml_text
cb_positions     # 輸出確認向量元素

cb_players <- cb %>%                           # 得到 player的向量
  xml_find_all(xpath = ".//player") %>%
  xml_text
cb_players       # 輸出確認向量元素

for (i in 1:length(cb_positions)) {
  print(sprintf("%s 打的位置是：%s", cb_players[i], cb_positions[i]))
}


