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
.myDiv{
	margin-left: 20px;
	margin-right: 20px;
	margin-top: 20px;
	margin-bottom: 20px;
}
.myDiv2{
	margin-left: 200px;
	margin-top: 20px;
	margin-bottom: 20px;
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
        <div align="right"><a href="mailto:service@jascal.net">聯絡我們</a>        </div>
      </li>
      
      
    </ul>
    <div style="margin-right:65px" class="myTablelogin">
	  <div align="right">xxx,歡迎回來!　<a href="#">登出</a></div>
     
  </div>
  </form>
  </div>
  <div style="clear:both">
    <p>符合關鍵字&quot;里約&quot;的結果! </p>
  </div>
  <h1>里約大冒險2 RIO 2     </h1>
    <form name="form2" method="post" action="">
     <table width="917" height="77" border="1" class="myDiv">
       <tr>
          <td width="449"><div align="center"><img src="1.jpg" width="200" height="297"></div></td>
          <td width="452"><p>上映日期：2014-04-03<br>
類　　型：喜劇、動畫<br>
片　　長：1時41分<br>
導　　演：卡洛斯薩爾達尼亞<br>
演　　員：(配音)安海瑟薇、傑西艾森伯格、黑眼豆豆團長威爾、傑米福克斯、安迪賈西亞、<br>
布魯諾、克莉絲汀肯諾維斯、麗塔莫倫諾
          </p>
          <h2 align="right">訂票</h2></td>
       </tr>
      </table>
      <h1>劇情簡介</h1>
      <table width="916" height="127" border="1" class="myDiv">
        <tr>
          <td width="898">還記得飛不起來而且還宅的要命的阿藍嘛？他與美麗勇敢的珠兒的戀愛故事轟轟烈烈，在第一集終於修成正果，抱得美人歸！ <br>
            《里約大冒險2》中阿藍、珠兒與他們的三隻新生幼鳥，原本過著安靜平凡的日子，但珠兒決定孩子們應該要回到叢林學習如何去體<br>
            驗身為一隻鳥應有的生活，堅持全家冒險進入亞馬遜流域；儘管阿藍努力學著適應新環境，但遇上難搞的岳父大人以及不時要防<br>
            範耐久的報復，這接踵而來的挑戰阿藍一家人將如何面對！？<br>
            <br>
          《里約大冒險2》不僅網羅第一集的超人氣角色，卡司陣容上又再更壯大，特別加入了重量級「新血」包含安迪賈西亞、葛萊<br>
          美獎最佳男歌手「火星人」布魯諾、東尼獎得主克莉絲汀肯諾維斯、奧斯卡/艾美獎/東尼獎三冠天后麗塔莫倫諾等，音樂部份<br>
          更延攬巴西歌手加奈兒夢奈與「The Wondaland Arts Society」樂團共襄盛舉。</td>
        </tr>
      </table>
      <h1>預告搶先看</h1>
      <table width="566" height="127" border="1" class="myDiv2">
        <tr>
          <td width="556" ><iframe width="560" height="315" src="//www.youtube.com/embed/34bKK7-1lgg" frameborder="0" allowfullscreen></iframe></td>
        </tr>
      </table>
      <div align="center"></div>
      <p><br>
    </p>

      <!-- end .content -->
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