<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
 String session_userid = (String) request.getAttribute("session_userid");
 System.out.println("----jsp---- session_userid = "+ session_userid);

 
%>

<!DOCTYPE html>
<html lang="en">

<head>
<!-- Theme Made By www.w3schools.com -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat"
	rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Lato"
	rel="stylesheet" type="text/css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/sha256.min.js"></script>



<script type="text/javascript">
	//$('#loginModal').modal({backdrop: 'static'});
	//$('#signinModal').modal({backdrop: 'static'});
	function closeother(e) {

		//alert(e.id);
		var element = e.id;
		if (e.id == ("login")) {
			$('#signinModal').modal('hide');
		} else {
			$('#loginModal').modal('hide');
		}

	}

	function loginProc() {
		var f = $("#form-1");
		var userid = f.children("#userid").val();
		var userpw = f.children("#userpw").val();

		if (userid == "") {
			alert("아이디를 입력해주세요");
			$("#userid").focus();
			return;
		}

		//$반복

		var exp = /[a-z0-9]$/; //영문자와 숫자
		//정규표현식. test(입력값) 규칙에 맞으면 true

		if (!exp.test(userid)) {

			alert("영문자와 숫자만 입력가능합니다.");
			$("#userid").focus();
			return;
		}

		if (userpw == "") {

			alert("비밀번호를 입력해주세요");

			$("#passwd").focus();
			return;
		}
		//비밀번호 암호화
		userpw = sha256(f.children("#userpw").val()).toString();
		console.log(userid);
		console.log(userpw);
/* 
		$.ajax({
			type : "post",
			url : "member/login.ajax",
			data : {
				userid : userid,
				userpw : userpw
			},
			dataType : "json",
			async: false,
			success : function(result) {
				console.log(result)
				if (result == userid) {
					alert("로그인성공");
					window.location.href = "home.do";

				} else {
					alert("로그인실패 비밀번호를 확인해주세요");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("로그인실패 비밀번호를 확인해주세요");
				//self.close();
			}

		}); */
		f.children("#userpw").val(userpw);
		f.submit();
		//alert("일단 전송은 함")
	}

	function logout(){
		window.location.href = "${pageContext.request.contextPath}/logout.do";
	}
</script>
<title>semiproject</title>
<%-- <script src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>
 	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
 	<script src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
 	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
 	<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
  --%>
<style>
body {
	font: 400 15px Lato, sans-serif;
	line-height: 1.8;
	color: #818181;
}

h2 {
	font-size: 24px;
	text-transform: uppercase;
	color: #303030;
	font-weight: 600;
	margin-bottom: 30px;
}

h4 {
	font-size: 19px;
	line-height: 1.375em;
	color: #303030;
	font-weight: 400;
	margin-bottom: 30px;
}

.jumbotron {
	background-color: #75e1f1;
	color: #fff;
	padding: 100px 25px;
	font-family: Montserrat, sans-serif;
}

.container-fluid {
	padding: 60px 50px;
}

.bg-grey {
	background-color: #f6f6f6;
}

.logo-small {
	color: #f4511e;
	font-size: 50px;
}

.logo {
	color: #f4511e;
	font-size: 200px;
}

.thumbnail {
	padding: 0 0 15px 0;
	border: none;
	border-radius: 0;
}

.thumbnail img {
	width: 100%;
	height: 100%;
	margin-bottom: 10px;
}

.carousel-control.right, .carousel-control.left {
	background-image: none;
	color: #f4511e;
}

.carousel-indicators li {
	border-color: #f4511e;
}

.carousel-indicators li.active {
	background-color: #f4511e;
}

.item h4 {
	font-size: 19px;
	line-height: 1.375em;
	font-weight: 400;
	font-style: italic;
	margin: 70px 0;
}

.item span {
	font-style: normal;
}

.panel {
	border: 1px solid #f4511e;
	border-radius: 0 !important;
	transition: box-shadow 0.5s;
}

.panel:hover {
	box-shadow: 5px 0px 40px rgba(0, 0, 0, .2);
}

.panel-footer .btn:hover {
	border: 1px solid #f4511e;
	background-color: #fff !important;
	color: #f4511e;
}

.panel-heading {
	color: #fff !important;
	background-color: #f4511e !important;
	padding: 25px;
	border-bottom: 1px solid transparent;
	border-top-left-radius: 0px;
	border-top-right-radius: 0px;
	border-bottom-left-radius: 0px;
	border-bottom-right-radius: 0px;
}

.panel-footer {
	background-color: white !important;
}

.panel-footer h3 {
	font-size: 32px;
}

.panel-footer h4 {
	color: #aaa;
	font-size: 14px;
}

.panel-footer .btn {
	margin: 15px 0;
	background-color: #f4511e;
	color: #fff;
}

.navbar {
	margin-bottom: 0;
	background-color: #49b6ff;
	z-index: 9999;
	border: 0;
	font-size: 12px !important;
	line-height: 1.42857143 !important;
	letter-spacing: 4px;
	border-radius: 0;
	font-family: Montserrat, sans-serif;
	position: inherit;
}

.navbar li a, .navbar .navbar-brand {
	color: #fff !important;
}

.navbar-nav li a:hover, .navbar-nav li.active a {
	color: #f4511e !important;
	background-color: #fff !important;
}

.navbar-default .navbar-toggle {
	border-color: transparent;
	color: #fff !important;
}

footer .glyphicon {
	font-size: 20px;
	margin-bottom: 20px;
	color: #f4511e;
}

.slideanim {
	visibility: hidden;
}

.slide {
	animation-name: slide;
	-webkit-animation-name: slide;
	animation-duration: 1s;
	-webkit-animation-duration: 1s;
	visibility: visible;
}

@
keyframes slide { 0% {
	opacity: 0;
	transform: translateY(70%);
}

100%
{
opacity


:





					

1;
transform


:





					

translateY

 

(0%);
}
}
@
-webkit-keyframes slide { 0% {
	opacity: 0;
	-webkit-transform: translateY(70%);
}

100%
{
opacity


:


					

1;
-webkit-transform


:





					

translateY

 

(0%);
}
}
@media screen and (max-width: 768px) {
	.col-sm-4 {
		text-align: center;
		margin: 25px 0;
	}
	.btn-lg {
		width: 100%;
		margin-bottom: 35px;
	}
}

@media screen and (max-width: 480px) {
	.logo {
		font-size: 150px;
	}
}

#login {
	text-decoration: underline;
	background-color: #a3aaff;
	text-size-adjust: unset;
}

#signin {
	text-decoration: underline;
	background-color: #a3aaff;
	text-size-adjust: unset;
}
#logout {
	text-decoration: underline;
	background-color: #a3aaff;
	text-size-adjust: unset;
}

div.modal.fade {
	margin: 15% auto;
}

.inputA {
	
}

.modal-content.modset {
	width: 450px;
	margin: auto;
	padding: auto;
}

.form-1 input {
	width: 99%;
}
</style>
</head>

<body id="myPage" data-spy="scroll" data-target=".navbar"
	data-offset="60">

	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="${pageContext.request.contextPath}/home.do">신나는 플랫폼</a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
					<!-- 
					<li><a href="#about">ABOUT</a></li>
					<li><a href="#services">SERVICES</a></li>
					<li><a href="#pricing">PRICING</a></li>
				 -->
					<li><a href="${pageContext.request.contextPath}/postlist.do">RECOURCES</a></li>
					<li><a href="#contact">CONTACT</a></li>
					<c:choose>
						<c:when test="${empty session_userid}">
							<!-- 비회원 -->
							<li><a data-toggle="modal" href="#loginModal" id="login"
								onclick="closeother(this)">LOGIN</a></li>
							<li><a data-toggle="modal" href="#signinModal" id="signin"
								onclick="closeother(this)">SIGN IN</a></li>
						</c:when>
						<c:otherwise>
							<!-- 회원 -->
							<li><a href="${pageContext.request.contextPath}/logout.do" id="logout">LOGOUT</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>


		</div>
	</nav>

	<!-- Modal -->
	<div class="modal fade " id="loginModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true"
		style="height: 600px">
		<div class="modal-dialog" role="document">
			<div class="modal-content modset">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h5 class="modal-title" id="exampleModalLabel">Login</h5>
				</div>
				<div class="modal-body">
					<form class="form-1" id="form-1" action="${pageContext.request.contextPath}/login.do" method="post" name="dto" >
						<span class="inputA">ID</span><br> <input type="text"
							id="userid" name="userid" /><br> <span class="inputA">Password</span><br>
						<input type="password" id="userpw" name="userpw" /><br>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="loginsubmit" onclick="loginProc()">Submit</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="signinModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true"
		style="height: 800px">
		<div class="modal-dialog" role="document">
			<div class="modal-content modset">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h5 class="modal-title" id="exampleModalLabel">Sign In</h5>
				</div>
				<div class="modal-body">
					<form class="form-1" id="form-1">
						<span class="inputA">ID</span><br> <input type="text"
							value="" id="createID" /><br> <span class="inputA">Password</span><br>
						<input type="password" value="" id="createPW" /><br> <span
							class="inputA">PasswordCheck</span><br> <input
							type="password" value="" id="createPWcheck" /><br> <span
							class="inputA">E-mail</span><br> <input type="email"
							value="" id="useremail" /><br>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary">Submit</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 모달끝 -->