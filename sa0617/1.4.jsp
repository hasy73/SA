<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>好好看電影</title>
<style type="text/css">
<!--
body {
	font: 100%/1.4 Verdana, Arial, Helvetica, sans-serif;
	background-color: #000;
	margin: 0;
	padding: 0;
	color: #000;
}

/* ~~ 元素/標籤選取器 ~~ */
ul, ol, dl { /* 由於瀏覽器之間的差異，最佳作法是在清單中使用零寬度的欄位間隔及邊界。為了保持一致，您可以在這裡指定所要的量，或在清單包含的清單項目 (LI、DT、DD) 上指定所要的量。請記住，除非您寫入較為特定的選取器，否則在此執行的作業將重疊顯示到 .nav 清單。 */
	padding: 0;
	margin: 0;
}
h1, h2, h3, h4, h5, h6, p {
	margin-top: 0;	 /* 移除上方邊界可以解決邊界可能從其包含的 Div 逸出的問題。剩餘的下方邊界可以保持 Div 不與接在後面的元素接觸。 */
	padding-right:20px;
	padding-left:20px; /* 將欄位間隔加入至 Div 內元素的兩側 (而不是 Div 本身)，即可不需執行任何方塊模型的計算作業。具有側邊欄位間隔的巢狀 Div 也可當做替代方法。 */
}
a img { /* 這個選取器會移除某些瀏覽器在影像由連結所圍繞時，影像周圍所顯示的預設藍色邊框 */
	border: none;
}
/* ~~ 網站連結的樣式設定必須保持此順序，包括建立滑過 (Hover) 效果的選取器群組在內。~~ */
a:link {
	color: #42413C;
	text-decoration: underline; /* 除非您要設定非常獨特的連結樣式，否則最好提供底線，以便快速看出 */
}
a:visited {
	color: #6E6C64;
	text-decoration: underline;
}
a:hover, a:active, a:focus { /* 這個選取器群組可以讓使用鍵盤導覽的使用者，也和使用滑鼠的使用者一樣擁有相同的滑過體驗。 */
	text-decoration: none;
}

/* ~~ 這個固定寬度的容器環繞著其他 Div ~~ */
.container {
	width: 960px;
	background-color: #000;
	margin: 0 auto; /* 兩側的自動值與寬度結合後，版面便會置中對齊 */
	color: #FFF;
}

/* ~~ 頁首沒有指定的寬度，而會橫跨版面的整個寬度。頁首包含影像預留位置，必須由您自己的連結商標加以取代 ~~ */
.header {
	background-color: #ADB96E;
	height:295px;
}

/* ~~ 這是版面資訊。~~ 

1) 欄位間隔只會置於 Div 的頂端或底部。此 Div 內的元素在兩側會有欄位間隔，可讓您不需進行「方塊模型計算」。請記住，如果對 Div 本身加入任何側邊的欄位間隔或邊框，在計算「總」寬度時，就會將這些加入您定義的寬度。您也可以選擇移除 Div 中元素的欄位間隔，然後在其中放置沒有寬度的第二個 Div，並依設計所需放置欄位間隔。

*/

.content {

	padding: 10px 0;
}

/* ~~ 頁尾 ~~ */
.footer {
	padding: 10px 0;
	background-color: #000;
}

/* ~~ 其他 float/clear 類別 ~~ */
.fltrt {  /* 這個類別可用來讓元素在頁面中浮動，浮動的元素必須位於頁面上相鄰的元素之前。 */
	float: right;
	margin-left: 8px;
}
.fltlft { /* 這個類別可用來讓元素在頁面左方浮動，浮動的元素必須位於頁面上相鄰的元素之前。 */
	float: left;
	margin-right: 8px;
}
.clearfloat { /* 這個類別可放置在 <br /> 或空白的 Div 上，當做接在 #container 內最後一個浮動 Div 後方的最後一個元素 (如果從 #container 移除或取出 #footer) */
	clear:both;
	height:0;
	font-size: 1px;
	line-height: 0px;
}
.myTablelogin{
	margin-right: 10px;
	color:#FFFFFF;
}
-->
</style>
<script src="SpryAssets/SpryMenuBar.js" type="text/javascript"></script>
<link href="SpryAssets/SpryMenuBarHorizontal.css" rel="stylesheet" type="text/css">
</head>

<body>

<div class="container">
  <div class="header"><a href="index.jsp"><img src="logo1.jpg" width="960" height="295"></a></div>
  <div class="content">
    <ul id="MenuBar1" style="margin-left:10px" class="MenuBarHorizontal">
      <li>
       <div align="center"><a class="MenuBarItemSubmenu">電影資訊</a>
          <ul>
            <li><a href="1.1.jsp">現正熱映</a></li>
            <li><a href="1.3.jsp">電影排行</a></li>
            <li><a href="1.2.jsp">即將上映</a></li>
            <li><a href="1.4.jsp">電影查詢</a></li>
          </ul>
        </div>
      </li>
            <li>
              <div align="center"><a href="2.1.jsp">線上訂票</a></div>
            </li>
            
      <li>
        <div align="center"><a class="MenuBarItemSubmenu">會員專區</a>
          <ul>
            <li><a class="MenuBarItemSubmenu">個人資料</a>
              <ul>
                <li><a href="3.1.1.jsp">資料修改</a></li>
                <li><a href="3.1.2.jsp">交易紀錄</a></li>
              </ul>
            </li>
            <li><a href="3.2.jsp">會員規章</a></li>
          </ul>
        </div>
      </li>
      <li>
        <div align="center"><a href="mailto:service@jascal.net">聯絡我們</a></div>
      </li>
      
      
    </ul>
    <div style="margin-right:40px">
      <div style="margin-right:65px" class="myTablelogin">
	  <div align="right">xxx,歡迎回來!　<a href="#">登出</a></div>
    </div>
    </div>
    <div style="clear:both"></div>
    <p><!-- end .content --></p>
    <form  style="margin-left:40px" name="form2" method="post" action="">
      <p>請選擇欲查詢項目:
        <label for="select"></label>
        <select name="select" id="select">
        </select>
      </p>
      <p>請輸入關鍵字:
        <label for="textfield"></label>
        <input type="text" name="textfield" id="textfield">
      </p>
      <p>
        <input type="submit" name="button4" id="button4" value="查詢">
      </p>
      <p>&nbsp;</p>
    </form>
  </div>
  <div class="footer">
    <div align="right" style="margin-right:50px">
    copyright&copy;2014
    </div>
    <!-- end .footer --></div>
  <!-- end .container --></div>
<script type="text/javascript">
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgDown:"SpryAssets/SpryMenuBarDownHover.gif", imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});
</script>
</body>
</html>