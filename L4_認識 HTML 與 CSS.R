# HTML(負責網頁的內容)
# 使用者和網站、網站和後端資料庫的互動
# HTML 標籤具有 style 屬性

'''
<!DOCTYPE html>
  <html>
  <head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <title>Basic HTML Page</title>
  </head>
  <body>
  <p style = "color: red;">Hello HTML</p>       # 直接在 html更改文字顏色為紅色
  </body>
  </html>
  
===========================================================
# 範例1

  <!DOCTYPE html>
  <html>
  <head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <title>JS Bin</title>
  </head>
  <body>
  <p class='p1'>Hello HTML</p>                 # 用class (CSSS搭配.p)或 id (CSS搭配#p)做分類
  <p class='p2'>Hello R</p>
  </body>
  </html>
  
# p1和p2分別用class，區別要用的變數

===========================================================
# 範例2

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width">
<title>JS Bin</title>
<link href="https://fonts.googleapis.com/css?family=Indie+Flower" rel="stylesheet">
</head>
<body>
<h2 id='p1'>Hello HTML</h2>
<p id='p2'>Hello R</p>
</body>
</html>

# 運用Google Fonts 加入 <link href="">插入更改

==========================================================
  
# 實務作法會將 style 的部分獨立出來
# 用 CSS（Cascading Style Sheets）設定外觀
# 最佳的作法是將 CSS 檔案獨立

# 認識 CSS（6）
# 可以引入外部的 CSS，像是 Google Fonts
  
===========================================================
# 範例1

.p1 {
  color:red;
}

.p2 {
  color: green;
}

# html用class (CSSS搭配.p)或 id (CSS搭配#p)做分類

===========================================================
# 範例2

#p1 {
  font-family: 'Indie Flower', cursive;
  color:red;
}

#p2 {
  color: green;
}

# 運用Google Fonts 加入 font-family改變字形

===========================================================
/*style.css*/
  #html {
  color: red;
font-size: 2em;
}
#css {
color: blue;
font-size: 3em;
font-family: 'Indie Flower', cursive;
}
<!DOCTYPE html>
  <html>
  <head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <link href="https://fonts.googleapis.com/css?family=Indie+Flower" rel="stylesheet">
  <link rel="stylesheet" href="style.css">
  <title>Basic HTML Page</title>
  </head>
  <body>
  <p id="html">Hello HTML</p>
  <p id="css">Hello CSS</p>
  </body>
  </html>
'''

