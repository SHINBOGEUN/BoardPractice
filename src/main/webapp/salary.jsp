<%@page import="DBPKG.Util"%>
<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>salary</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/common.css">
</head>
<body>
	<%@include file="header.jsp"%>

	<section>
		<p>
			<b>회원 매출 조회</b>
		</p>

		<form>
			<table border="1">
				<tr>
					<td>회원 번호</td>
					<td>회원 성명</td>
					<td>고객 등급</td>
					<td>매출</td>
				</tr>
				<%
				request.setCharacterEncoding("UTF-8");
				Connection conn = null;
				Statement stmt = null;
				String grade="";
				try{
					conn = Util.getConnection();
					stmt = conn.createStatement();
					String sql = "select me.custno, me.custname, me.grade, sum(mo.price) price " +
								 "from member_tbl_02 me, money_tbl_02 mo " + 
								 "where me.custno = mo.custno "+
								 "group by me.custno, me.custname, me.grade "+
								 "order by sum(mo.price) desc";
					ResultSet rs = stmt.executeQuery(sql);
					while(rs.next()){
						grade = rs.getString("grade");
						switch(grade){
						case "A":
							grade = "VIP";
							break;
						case "B":
							grade = "일반";
							break;
						case "C":
							grade = "직원";
							break; 
						}
				%>
				<tr>
					<td><%=rs.getString("custno") %></td>
					<td><%=rs.getString("custname") %></td>
					<td><%=grade %></td>
					<td><%=rs.getString("price") %></td>
				</tr>
				<% 
					}
				}catch(Exception e){
					e.printStackTrace();
				}
				%>
			</table>
		</form>
	</section>

	<%@ include file="footer.jsp"%>
</body>
</html>