<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.*"%>
<%@page import="java.text.DecimalFormat" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Calendar" %>
<%@page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<!DOCTYPE html>
<html lang="ko">
  <head>
  	<meta charset="UTF-8">
  	<link rel="stylesheet" type="text/css" href="../style.css">
  	<script src="../script.js" type="text/javascript"></script>
  </head>
<% 
	String id = request.getParameter("id");
	String cusid = request.getParameter("cusid");	
	int payid = Integer.parseInt(request.getParameter("payid"));
%>
	<style>
	table{
	    border:3px solid lightgrey;
	    width: 60%;
		padding: 20px;
		text-align: center;
		margin: auto;
	}
	</style>
  <body>
    <header id="header">
      <div class="navbar">
        <a href="../manMain.jsp?id=<%=id%>">관리자</a>
        <div class="dropdown">
          <button class="dropbtn">영화관관리
            <i class="fa fa-caret-down"></i>
          </button>
          <div class="dropdown-content">
            <a href="CinemaInfo.jsp?id=<%=id%>">영화관정보</a>
            <a href="CinemaReg.jsp?id=<%=id%>">영화관등록</a>
          </div>
        </div>
        <div class="dropdown">
          <button class="dropbtn">영화관리
            <i class="fa fa-caret-down"></i>
          </button>
          <div class="dropdown-content">
            <a href="MovieInfo.jsp?id=<%=id%>">영화정보</a>
            <a href="MovieReg.jsp?id=<%=id%>">영화등록</a>
          </div>
        </div>
           <div class="dropdown">
          <button class="dropbtn">상영관리
            <i class="fa fa-caret-down"></i>
          </button>
          <div class="dropdown-content">
            <a href="ScreenInfo.jsp?id=<%=id%>">상영관정보</a>
            <a href="ScreenReg.jsp?id=<%=id%>">상영관등록</a>
            <a href="FilmReg.jsp?id=<%=id%>">상영영화등록</a>
            <a href="FilmDelete.jsp?id=<%=id%>">상영영화삭제</a>
          </div>
   		</div>
              <div class="dropdown">
          <button class="dropbtn">고객관리
            <i class="fa fa-caret-down"></i>
          </button>
           <div class="dropdown-content">
            <a href="MemInfo.jsp?id=<%=id%>">VIP정보</a>
            </div>       
            </div>
          <div class="dropdown">
          <button class="dropbtn">티켓
            <i class="fa fa-caret-down"></i>
          </button>
           <div class="dropdown-content">
            <a href="ticketIssue.jsp?id=<%=id%>">티켓발행</a>
            </div>       
            </div>
    </header>
	<b><%=id %></b>님이 로그인 하셨습니다.
	<form method="post" action="../cookieLogout.jsp">
		<input type="submit" value="로그아웃">
	</form>
	
	<h2 style="text-align:center;">현장결제</h2>
	<form action="payment2.jsp?">
	<table border="1" width="600">
		<tr>
			<td>회원아이디</td>
			<td>결제금액</td>
		</tr>
		<%
			//db 에서 회원목록 얻어와 테이블에 출력하기.
			Connection conn = null;
			PreparedStatement pstmt = null;
			String str = "";
			ResultSet rs = null;
			try {
				String jdbcUrl = "jdbc:mysql://localhost:3306/db_termp?useUnicode=true&characterEncoding=UTF-8";
				String dbId = "root";
				String dbPass = "admin";
				
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
				String sql = "select * from 결제정보 where 결제번호= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1,payid);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					int totalmoney = rs.getInt("최종결제금액");
		%>
		<tr>
			<td><%=cusid%></td>
			<td><%=totalmoney%></td>
		</tr>
		<%
			}
			} catch (SQLException se) {
				System.out.println(se.getMessage());
			} finally {
				try {
					if (rs != null)
						rs.close();
					if (pstmt != null)
						pstmt.close();
					if (conn != null)
						conn.close();
				} catch (SQLException se) {
					System.out.println(se.getMessage());
				}
			}
		%>
		<tr>
			<input type="hidden" name="id" value="<%=id %>">
			<input type="hidden" name="payid" value="<%=payid %>">
			<td colspan="2"><input type="submit" value="결제"></td>
		</tr>
	</table>
	</form>
</body>
</html>