<%@ include file="/layout/common.jsp" %>
<%
	session.invalidate();
	response.sendRedirect(root+"/admin/adminLogin.jsp");
%>