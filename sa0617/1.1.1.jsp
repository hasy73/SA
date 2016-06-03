<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="Connections/sa.jsp" %>
<%
String Recordset1__MMColParam = "1";
if (request.getParameter("m") !=null) {Recordset1__MMColParam = (String)request.getParameter("m");}
%>
<%
Driver DriverRecordset1 = (Driver)Class.forName(MM_sa_DRIVER).newInstance();
Connection ConnRecordset1 = DriverManager.getConnection(MM_sa_STRING,MM_sa_USERNAME,MM_sa_PASSWORD);
PreparedStatement StatementRecordset1 = ConnRecordset1.prepareStatement("SELECT * FROM sa.movie WHERE `電影編號` = ?");
StatementRecordset1.setObject(1, Recordset1__MMColParam);
ResultSet Recordset1 = StatementRecordset1.executeQuery();
boolean Recordset1_isEmpty = !Recordset1.next();
boolean Recordset1_hasData = !Recordset1_isEmpty;
Object Recordset1_data;
int Recordset1_numRows = 0;
%>
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
        <div align="center"><a href="mailto:service@jascal.net">聯絡我們</a></div>
      </li>
      
      
    </ul>
    <div style="margin-right:40px">
      <div style="margin-right:65px" class="myTablelogin">
	  <div align="right">xxx,歡迎回來!　<a href="index.jsp">登出</a></div>
    </div>
    </div>
    <div style="clear:both"></div>
    <h1><%=(((Recordset1_data = Recordset1.getObject("電影名稱"))==null || Recordset1.wasNull())?"":Recordset1_data)%></h1>
    <form name="form2" method="post" action="">
      <table width="917" height="77" border="1" class="myDiv">
        <tr>
          <td width="449"><div align="center"><img src="<%=(((Recordset1_data = Recordset1.getObject("pic"))==null || Recordset1.wasNull())?"":Recordset1_data)%>" width="200" height="297"></div></td>
          <td width="452"><p>上映日期：<%=(((Recordset1_data = Recordset1.getObject("上映日期"))==null || Recordset1.wasNull())?"":Recordset1_data)%><br>
            級　　別：<%=(((Recordset1_data = Recordset1.getObject("級別"))==null || Recordset1.wasNull())?"":Recordset1_data)%><br>
          導 　 演:<%=(((Recordset1_data = Recordset1.getObject("導演"))==null || Recordset1.wasNull())?"":Recordset1_data)%><br>
          演　　員：<%=(((Recordset1_data = Recordset1.getObject("演員"))==null || Recordset1.wasNull())?"":Recordset1_data)%></p>
          <p>&nbsp;</p></td>
        </tr>
      </table>
      <h1>劇情簡介</h1>
      <table width="916" height="127" border="1" class="myDiv">
        <tr>
          <td width="898">艾倫戴爾王國有著兩位個性截然不同的公主-艾莎與安娜，姊姊艾莎冷若冰霜，舉止優雅合宜，安娜生性活潑衝動，熱愛冒險。<br>
            但看似冷冰冰的艾莎事實上擁有魔法能點人成冰，所以一直不敢接近人群，尤其是不敢靠近安娜怕傷害到親愛的妹妹。有一天，<br>
            艾莎必須接下統領王國的重任，但是兩姊妹的一場爭吵讓艾莎壓抑的情緒爆發，憤而離家，但一時使出的魔法卻讓整個王國變成<br>
            冰封的雪國。安娜為了解除魔法，只得冒著風雪尋找姊姊，在路上碰上喜愛冒險的登山人阿克與他如忠犬般個性的馴鹿以及天真<br>
            搞笑的雪人雪寶，四人一同攜手踏上偉大的旅程，它們必須挑戰冷峻的雪山以及一路上種種險境才能拯救面臨滅亡的王國…<br>
            <br>
          《冰雪奇緣》是迪士尼影業繼《魔髮奇緣》與《無敵破壞王》再度製作的冒險喜劇3D動畫，由曾製作過《無敵破壞王》、<br>
          《泰山》的珍妮佛李與克里斯巴克共同執導，將會看到經典與創新的完美結合。《冰雪奇緣》將再度顛覆傳統，帶來一部結合<br>
          冒險、幽默的動畫喜劇。          </td>
        </tr>
      </table>
      <h1>預告搶先看</h1>
      <table width="566" height="127" border="1" class="myDiv2">
        <tr>
          <td width="556" ><iframe width="560" height="315" src="//www.youtube.com/embed/djMVDyxrQJ4" frameborder="0" allowfullscreen ></iframe></td>
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
<%
Recordset1.close();
StatementRecordset1.close();
ConnRecordset1.close();
%>
