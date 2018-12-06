<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import="java.sql.*" %>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	String id = request.getParameter("id");
	int screenid = Integer.parseInt(request.getParameter("screenid"));
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
		
	try{
		String jdbcUrl = "jdbc:mysql://localhost:3306/db_termp?useUnicode=true&characterEncoding=UTF-8";
		String dbId = "root";
		String dbPass = "euncha315^^";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		String sql = "select 상영관번호 from 상영관 where 상영관번호=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,screenid);
		rs = pstmt.executeQuery();
		
		// 레코드의 검색 결과로 작업 처리
		if(rs.next()){ //기존에 아이디가 존재하는 경우 수행
			int mId = rs.getInt("상영관번호");
			if(screenid==mId ){// 패스워드가 일치하는 경우 수행
				sql = "delete from 상영관 where 상영관번호 = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, screenid);
				pstmt.executeUpdate();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html14/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
</head>
<body>
<%
			}else{// 패스워드가 일치하지 않을 경우
				out.println("상영관번호가 틀렸습니다.");
			}
		}else{//존재하지 않는 아이디인 경우
			out.println("존재하지않는 영화번호입니다.");
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(rs != null) try{rs.close();}catch(SQLException sqle){}
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
		if(conn != null) try{conn.close();}catch(SQLException sqle){}
	}
%>
	<form action="ScreenInfo.jsp" id="moveId"><input type="hidden" name="id" value="<%=id%>"></form>
	<script>
		moveId.submit();
	</script>
</body>
</html>
