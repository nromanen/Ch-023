<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title><tiles:getAsString name="title" /></title>	
    <link rel="shortcut icon" href="<c:url value="/resources/img/icon.png" />" type="image/x-icon">
    <link href='<c:url value="/resources/style/bootstrap/css/bootstrap.min.css" />' rel="stylesheet">
    <link href='<c:url value="/resources/style/main.css" />' rel="stylesheet">
    <link href='<c:url value="/resources/style/list.css" />' rel="stylesheet">
    <script type='text/javascript' src='<c:url value="/resources/js/lib/jquery-1.11.0.js" />'></script>
    <script type='text/javascript' src="<c:url value="/resources/style/bootstrap/js/bootstrap.min.js" />"></script>		
</head>
<body>
<div class="container">
    <div class="row">
        <tiles:insertAttribute name="menu" />
    </div>
    <div class="row">
        <div class="col-md-3 hidden-sm hidden-xs">
            <tiles:insertAttribute name="left" />
        </div>
        <div class="col-md-9">
            <tiles:insertAttribute name="content" />
        </div>
    </div>
</div>

<tiles:insertAttribute name="footer" />

</body>
</html>