<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />


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
			
		// 유효성 검사(타이틀, 내용 입력)
		} else {
			if(bbs.getBbsTitle() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("    alert('타이틀이 입력되지 않았습니다.') ");
				script.println("    history.back() ");
				script.println("</script>");
				
			} else if(bbs.getBbsContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("    alert('내용이 입력되지 않았습니다.') ");
				script.println("    history.back() ");
				script.println("</script>");
				
			// 유효성 검사 완료 후 쿼리 수행
			} else {
				BbsDAO bbsDAO	= new BbsDAO();
				int 	result 	= bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
				
				// db 오류
				if(result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("    alert('글쓰기에 실패했습니다.') ");
					script.println("</script>");
					
				// 정상 처리
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("    location.href='main.jsp' ");
					script.println("</script>");
				}
			}
		}
	%>
	
</body>
</html>