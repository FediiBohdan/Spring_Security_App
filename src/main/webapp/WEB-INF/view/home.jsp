<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="secutiry" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title>Title</title>
</head>

<body>
<h2>Home page</h2>
<hr>
<p>
    Welcome to home page!
</p>

<hr>

<p>
    User: <secutiry:authentication property="principal.username"/>
    <br><br>
    Role(s): <secutiry:authentication property="principal.authorities"/>
</p>

<secutiry:authorize access="hasRole('MANAGER')">
    <p>
        <a href="${pageContext.request.contextPath}/leaders">Leadership meeting</a>
        (Only for Managers)
    </p>
</secutiry:authorize>

<secutiry:authorize access="hasRole('ADMIN')">
    <p>
        <a href="${pageContext.request.contextPath}/systems">IT Systems meeting</a>
        (Only for Admins)
    </p>
</secutiry:authorize>

<hr>

<form:form action="${pageContext.request.contextPath}/logout" method="POST">
    <input type="submit" value="Logout"/>
</form:form>
</body>
</html>
