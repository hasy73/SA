<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="Connections/sa.jsp" %>
<%
Driver DriverRecordset1 = (Driver)Class.forName(MM_sa_DRIVER).newInstance();
Connection ConnRecordset1 = DriverManager.getConnection(MM_sa_STRING,MM_sa_USERNAME,MM_sa_PASSWORD);
PreparedStatement StatementRecordset1 = ConnRecordset1.prepareStatement("SELECT * FROM sa.movie");
ResultSet Recordset1 = StatementRecordset1.executeQuery();
boolean Recordset1_isEmpty = !Recordset1.next();
boolean Recordset1_hasData = !Recordset1_isEmpty;
Object Recordset1_data;
int Recordset1_numRows = 0;
%>
<%
int Repeat1__numRows = 5;
int Repeat1__index = 0;
Recordset1_numRows += Repeat1__numRows;
%>
<%
// *** Recordset Stats, Move To Record, and Go To Record: declare stats variables

int Recordset1_first = 1;
int Recordset1_last  = 1;
int Recordset1_total = -1;

if (Recordset1_isEmpty) {
  Recordset1_total = Recordset1_first = Recordset1_last = 0;
}

//set the number of rows displayed on this page
if (Recordset1_numRows == 0) {
  Recordset1_numRows = 1;
}
%>
<% String MM_paramName = ""; %>
<%
// *** Move To Record and Go To Record: declare variables

ResultSet MM_rs = Recordset1;
int       MM_rsCount = Recordset1_total;
int       MM_size = Recordset1_numRows;
String    MM_uniqueCol = "";
          MM_paramName = "";
int       MM_offset = 0;
boolean   MM_atTotal = false;
boolean   MM_paramIsDefined = (MM_paramName.length() != 0 && request.getParameter(MM_paramName) != null);
%>
<%
// *** Move To Record: handle 'index' or 'offset' parameter

if (!MM_paramIsDefined && MM_rsCount != 0) {

  //use index parameter if defined, otherwise use offset parameter
  String r = request.getParameter("index");
  if (r==null) r = request.getParameter("offset");
  if (r!=null) MM_offset = Integer.parseInt(r);

  // if we have a record count, check if we are past the end of the recordset
  if (MM_rsCount != -1) {
    if (MM_offset >= MM_rsCount || MM_offset == -1) {  // past end or move last
      if (MM_rsCount % MM_size != 0)    // last page not a full repeat region
        MM_offset = MM_rsCount - MM_rsCount % MM_size;
      else
        MM_offset = MM_rsCount - MM_size;
    }
  }

  //move the cursor to the selected record
  int i;
  for (i=0; Recordset1_hasData && (i < MM_offset || MM_offset == -1); i++) {
    Recordset1_hasData = MM_rs.next();
  }
  if (!Recordset1_hasData) MM_offset = i;  // set MM_offset to the last possible record
}
%>
<%
// *** Move To Record: if we dont know the record count, check the display range

if (MM_rsCount == -1) {

  // walk to the end of the display range for this page
  int i;
  for (i=MM_offset; Recordset1_hasData && (MM_size < 0 || i < MM_offset + MM_size); i++) {
    Recordset1_hasData = MM_rs.next();
  }

  // if we walked off the end of the recordset, set MM_rsCount and MM_size
  if (!Recordset1_hasData) {
    MM_rsCount = i;
    if (MM_size < 0 || MM_size > MM_rsCount) MM_size = MM_rsCount;
  }

  // if we walked off the end, set the offset based on page size
  if (!Recordset1_hasData && !MM_paramIsDefined) {
    if (MM_offset > MM_rsCount - MM_size || MM_offset == -1) { //check if past end or last
      if (MM_rsCount % MM_size != 0)  //last page has less records than MM_size
        MM_offset = MM_rsCount - MM_rsCount % MM_size;
      else
        MM_offset = MM_rsCount - MM_size;
    }
  }

  // reset the cursor to the beginning
  Recordset1.close();
  Recordset1 = StatementRecordset1.executeQuery();
  Recordset1_hasData = Recordset1.next();
  MM_rs = Recordset1;

  // move the cursor to the selected record
  for (i=0; Recordset1_hasData && i < MM_offset; i++) {
    Recordset1_hasData = MM_rs.next();
  }
}
%>
<%
// *** Move To Record: update recordset stats

// set the first and last displayed record
Recordset1_first = MM_offset + 1;
Recordset1_last  = MM_offset + MM_size;
if (MM_rsCount != -1) {
  Recordset1_first = Math.min(Recordset1_first, MM_rsCount);
  Recordset1_last  = Math.min(Recordset1_last, MM_rsCount);
}

// set the boolean used by hide region to check if we are on the last record
MM_atTotal  = (MM_rsCount != -1 && MM_offset + MM_size >= MM_rsCount);
%>
<%
// *** Go To Record and Move To Record: create strings for maintaining URL and Form parameters

String MM_keepBoth,MM_keepURL="",MM_keepForm="",MM_keepNone="";
String[] MM_removeList = { "index", MM_paramName };

// create the MM_keepURL string
if (request.getQueryString() != null) {
  MM_keepURL = '&' + request.getQueryString();
  for (int i=0; i < MM_removeList.length && MM_removeList[i].length() != 0; i++) {
  int start = MM_keepURL.indexOf(MM_removeList[i]) - 1;
    if (start >= 0 && MM_keepURL.charAt(start) == '&' &&
        MM_keepURL.charAt(start + MM_removeList[i].length() + 1) == '=') {
      int stop = MM_keepURL.indexOf('&', start + 1);
      if (stop == -1) stop = MM_keepURL.length();
      MM_keepURL = MM_keepURL.substring(0,start) + MM_keepURL.substring(stop);
    }
  }
}

// add the Form variables to the MM_keepForm string
if (request.getParameterNames().hasMoreElements()) {
  java.util.Enumeration items = request.getParameterNames();
  while (items.hasMoreElements()) {
    String nextItem = (String)items.nextElement();
    boolean found = false;
    for (int i=0; !found && i < MM_removeList.length; i++) {
      if (MM_removeList[i].equals(nextItem)) found = true;
    }
    if (!found && MM_keepURL.indexOf('&' + nextItem + '=') == -1) {
      MM_keepForm = MM_keepForm + '&' + nextItem + '=' + java.net.URLEncoder.encode(request.getParameter(nextItem));
    }
  }
}

String tempStr = "";
for (int i=0; i < MM_keepURL.length(); i++) {
  if (MM_keepURL.charAt(i) == '<') tempStr = tempStr + "&lt;";
  else if (MM_keepURL.charAt(i) == '>') tempStr = tempStr + "&gt;";
  else if (MM_keepURL.charAt(i) == '"') tempStr = tempStr +  "&quot;";
  else tempStr = tempStr + MM_keepURL.charAt(i);
}
MM_keepURL = tempStr;

tempStr = "";
for (int i=0; i < MM_keepForm.length(); i++) {
  if (MM_keepForm.charAt(i) == '<') tempStr = tempStr + "&lt;";
  else if (MM_keepForm.charAt(i) == '>') tempStr = tempStr + "&gt;";
  else if (MM_keepForm.charAt(i) == '"') tempStr = tempStr +  "&quot;";
  else tempStr = tempStr + MM_keepForm.charAt(i);
}
MM_keepForm = tempStr;

// create the Form + URL string and remove the intial '&' from each of the strings
MM_keepBoth = MM_keepURL + MM_keepForm;
if (MM_keepBoth.length() > 0) MM_keepBoth = MM_keepBoth.substring(1);
if (MM_keepURL.length() > 0)  MM_keepURL = MM_keepURL.substring(1);
if (MM_keepForm.length() > 0) MM_keepForm = MM_keepForm.substring(1);
%>
<%
// *** Move To Record: set the strings for the first, last, next, and previous links

String MM_moveFirst,MM_moveLast,MM_moveNext,MM_movePrev;
{
  String MM_keepMove = MM_keepBoth;  // keep both Form and URL parameters for moves
  String MM_moveParam = "index=";

  // if the page has a repeated region, remove 'offset' from the maintained parameters
  if (MM_size > 1) {
    MM_moveParam = "offset=";
    int start = MM_keepMove.indexOf(MM_moveParam);
    if (start != -1 && (start == 0 || MM_keepMove.charAt(start-1) == '&')) {
      int stop = MM_keepMove.indexOf('&', start);
      if (start == 0 && stop != -1) stop++;
      if (stop == -1) stop = MM_keepMove.length();
      if (start > 0) start--;
      MM_keepMove = MM_keepMove.substring(0,start) + MM_keepMove.substring(stop);
    }
  }

  // set the strings for the move to links
  StringBuffer urlStr = new StringBuffer(request.getRequestURI()).append('?').append(MM_keepMove);
  if (MM_keepMove.length() > 0) urlStr.append('&');
  urlStr.append(MM_moveParam);
  MM_moveFirst = urlStr + "0";
  MM_moveLast  = urlStr + "-1";
  MM_moveNext  = urlStr + Integer.toString(MM_offset+MM_size);
  MM_movePrev  = urlStr + Integer.toString(Math.max(MM_offset-MM_size,0));
}
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>登入失敗</title>
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
	margin-right:20px;
	margin-bottom:20px;
	margi-top:20px;
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
    <div style="margin-right:6px" class="myTablelogin">
      <div align="right">xxx,歡迎回來!　<a href="hot_movie.jsp">登出</a>      </div>
    </div>
    <div style="clear:both"></div>
     <h1>&nbsp;</h1>
     <h1>現正熱映</h1>
    <p>&nbsp;</p>
    <form name="form2" method="get" action="hot_movie.jsp">
    
      <% while ((Recordset1_hasData)&&(Repeat1__numRows-- != 0)) { %>
  <table width="917" height="77" border="0" class="myDiv">
    <tr>
      <td width="200"><a href="hot_movie.jsp"><img src="<%=(((Recordset1_data = Recordset1.getObject("pic"))==null || Recordset1.wasNull())?"":Recordset1_data)%>" name="<%=(((Recordset1_data = Recordset1.getObject("電影編號"))==null || Recordset1.wasNull())?"":Recordset1_data)%>" width="201" height="297" id="<%=(((Recordset1_data = Recordset1.getObject("電影編號"))==null || Recordset1.wasNull())?"":Recordset1_data)%>">
        
      </a></td>
      <td width="693"><h1><%=(((Recordset1_data = Recordset1.getObject("電影名稱"))==null || Recordset1.wasNull())?"":Recordset1_data)%></h1>
        <p>上映日期：<%=(((Recordset1_data = Recordset1.getObject("上映日期"))==null || Recordset1.wasNull())?"":Recordset1_data)%><br>
          級　　別：<%=(((Recordset1_data = Recordset1.getObject("級別"))==null || Recordset1.wasNull())?"":Recordset1_data)%><br>
          導　　演：<%=(((Recordset1_data = Recordset1.getObject("導演"))==null || Recordset1.wasNull())?"":Recordset1_data)%><br>
          演　　員：<%=(((Recordset1_data = Recordset1.getObject("演員"))==null || Recordset1.wasNull())?"":Recordset1_data)%></p>
        <p>&nbsp;</p></td>
      </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      </tr>
  </table>
  <%
  Repeat1__index++;
  Recordset1_hasData = Recordset1.next();
}
%>
<p>&nbsp;</p>
<p>
  <% if (MM_atTotal) { %>
    <a href="<%=MM_moveFirst%>">第一頁</a>　 <a href="<%=MM_movePrev%>">上一頁</a>　
    <% } /* end MM_atTotal */ %>
  <% if (MM_offset == 0) { %>
    <a href="<%=MM_moveNext%>">下一頁</a> 　 <a href="<%=MM_moveLast%>">最後一頁</a>
  <% } /* end MM_offset == 0 */ %>
</p>
</p>
<p><br>
  </p>
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
