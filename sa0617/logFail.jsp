<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="Connections/sa.jsp" %>
<%
// *** Validate request to log in to this site.
String MM_LoginAction = request.getRequestURI();
if (request.getQueryString() != null && request.getQueryString().length() > 0) {
  String queryString = request.getQueryString();
  String tempStr = "";
  for (int i=0; i < queryString.length(); i++) {
    if (queryString.charAt(i) == '<') tempStr = tempStr + "&lt;";
    else if (queryString.charAt(i) == '>') tempStr = tempStr + "&gt;";
    else if (queryString.charAt(i) == '"') tempStr = tempStr +  "&quot;";
    else tempStr = tempStr + queryString.charAt(i);
  }
  MM_LoginAction += "?" + tempStr;
}
String MM_valUsername=request.getParameter("id2");
if (MM_valUsername != null) {
  String MM_fldUserAuthorization="";
  String MM_redirectLoginSuccess="hot_log.jsp";
  String MM_redirectLoginFailed="loginfail.jsp";
  String MM_redirectLogin=MM_redirectLoginFailed;
  Driver MM_driverUser = (Driver)Class.forName(MM_sa_DRIVER).newInstance();
  Connection MM_connUser = DriverManager.getConnection(MM_sa_STRING,MM_sa_USERNAME,MM_sa_PASSWORD);
  String MM_pSQL = "SELECT id, pw";
  if (!MM_fldUserAuthorization.equals("")) MM_pSQL += "," + MM_fldUserAuthorization;
  MM_pSQL += " FROM sa.member WHERE id=? AND pw=?";
  PreparedStatement MM_statementUser = MM_connUser.prepareStatement(MM_pSQL);
  MM_statementUser.setObject(1, MM_valUsername);
  MM_statementUser.setObject(2, request.getParameter("password2"));
  ResultSet MM_rsUser = MM_statementUser.executeQuery();
  boolean MM_rsUser_isNotEmpty = MM_rsUser.next();
  if (MM_rsUser_isNotEmpty) {
    // username and password match - this is a valid user
    session.putValue("MM_Username", MM_valUsername);
    if (!MM_fldUserAuthorization.equals("")) {
      session.putValue("MM_UserAuthorization", MM_rsUser.getString(MM_fldUserAuthorization).trim());
    } else {
      session.putValue("MM_UserAuthorization", "");
    }
    if ((request.getParameter("accessdenied") != null) && false) {
      MM_redirectLoginSuccess = request.getParameter("accessdenied");
    }
    MM_redirectLogin=MM_redirectLoginSuccess;
  }
  MM_rsUser.close();
  MM_connUser.close();
  response.sendRedirect(response.encodeRedirectURL(MM_redirectLogin));
  return;
}
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
	margin: auto;
	margin-bottom:auto;
	margin-top:100px;
}

/* ~~ 這是版面資訊。~~ 

1) 欄位間隔只會置於 Div 的頂端或底部。此 Div 內的元素在兩側會有欄位間隔，可讓您不需進行「方塊模型計算」。請記住，如果對 Div 本身加入任何側邊的欄位間隔或邊框，在計算「總」寬度時，就會將這些加入您定義的寬度。您也可以選擇移除 Div 中元素的欄位間隔，然後在其中放置沒有寬度的第二個 Div，並依設計所需放置欄位間隔。

*/

.content {
	/* [disabled]padding: 10px 0; */
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
	border: 1px dotted #999999;
	color:#FFFFFF;
}
.myDiv{
	margin-left: 20px;
}
-->
</style>
</head>

<body>

<div class="container">
  <div class="header"><img src="logo1.jpg" width="960" height="295"></a></div>
  <div class="content">
    <form name="form1" method="POST" action="<%=MM_LoginAction%>">
      <div align="center">
        <p>擰確認帳號密碼無誤┌</p>
        <p>&nbsp;</p>
      </div>
    </form>
    </div>
    </div>
</div><a href="comming_log.jsp">comming_log</a>
  <div class="footer">
    <div align="right" style="margin-right:220px; color:#FFF">
    copyright&copy;2014
    </div>
    <!-- end .footer --></div>
  <!-- end .container --></div>
<script type="text/javascript">
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgDown:"SpryAssets/SpryMenuBarDownHover.gif", imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});
</script>
</body>
</html>