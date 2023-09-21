<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>JSP 게시판 웹 사이트</title>

</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		
		// 로그인이 되어 있지 않은 경우
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("    alert('로그인을 하세요.') ");
			script.println("    location.href='login.jsp' ");
			script.println("</script>");
		} 
		
		int bbsID = 0;
		if(request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		
		// 유효하지 않은 게시글
		if(bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("    alert('유효하지 않은 게시글입니다.') ");
			script.println("    location.href='bbs.jsp' ");
			script.println("</script>");
		}
		
		// 로그인 유저와 게시글 작성자가 다를 경우
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if(!userID.equals(bbs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("    alert('권한이 없습니다.') ");
			script.println("    location.href='bbs.jsp' ");
			script.println("</script>");
			
		} else {
			BbsDAO bbsDAO	= new BbsDAO();
			int 	result 	= bbsDAO.delete(bbsID);
			
			// db 오류
			if(result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("    alert('글 삭제에 실패했습니다.') ");
				script.println("    history.back() ");
				script.println("</script>");
				
			// 정상 처리
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("    location.href='bbs.jsp' ");
				script.println("</script>");
			}
		}
	%>
	
</body>
</html>