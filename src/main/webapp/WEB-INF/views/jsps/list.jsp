<%@ include file="../header.jsp"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<div class="container">
	<h2>자료실</h2>
	<div class="table-responsive">
	<div class="pull-right">
		<form id="searchform" class="form-inline" style="float: rigjt">
			<input type="date" class="form-control docs-date" id="startdate"
				name="startdate" placeholder="Pick a date" style="widows: auto">&nbsp;~&nbsp; 
			<input type="date" class="form-control docs-date" id="enddate"
				name="enddate" placeholder="Pick a date" style="widows: auto">
			&nbsp; &nbsp; &nbsp; 
			<select name="category" id="category" class="form-control">
				<option value="분류" selected>분류</option>
				<option value="교수학습방법" >교수학습방법</option>
				<option value="평가방법">평가방법</option>
				<option value="보고서" >보고서</option>
				<option value="강의자료" >강의자료</option>
				<option value="기타자료" >기타자료</option>
			</select>&nbsp;&nbsp;  
			<select name="writerortitle" id="writerortitle" class="form-control">
				<option value="choose" selected>선택</option>
				<option value="title">제목</option>
				<option value="userid">작성자</option>
			</select> 
			<input type="text" name="word" id="word" class="form-control">
			<input type="button" name="search" id="search" class="btn btn-defalt" value="조회">
		</form>
	</div>
		<br>
		<table id="" class="table table-hover" >
			<thead>
				<tr>
					<th>순번</th>
					<th>분류</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>첨부파일</th>
				</tr>
			</thead>
			<tbody id="tbody">
				<c:forEach var="item" items="${list }" varStatus="status">
					<tr class=""  onclick="location.href='postdetail.do?postno=${item.postno}'" style="cursor:pointer;">
						<td>${fn:length(list)- status.index }</td>
						<td>${item.category}</td>
						<td>${item.title}</td>
						<td>${item.userid}</td>
						<td>${item.regdate}</td>
						<td>${item.views}</td>
						<td>${item.file_names}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="">$.parseHTML(${paging })</div>

	</div>
	<div style="margin: auto">
		<button class="btn pull-right" onclick="location.href='postinsert.do'">글쓰기</button>
	</div>
</div>

<script type="text/javascript">

$(document).ready(function(){
	$('#search').on('click', function(){
		//concol.log(form);
		var form = $(this).parent("#searchform");
		//alert("!!"+form);
		var $startdate = form.children("#startdate").val();
		var $enddate = form.children("#enddate").val();
		var $category = form.find("#category option:selected").val();//선택안되어있으면 undefind?
		var $writerortitle = form.find("#writerortitle option:selected").val();
		var $word = form.children("#word").val();

		console.log($startdate);
		console.log($enddate);
		console.log($category);
		console.log($writerortitle);
		console.log($word);
		//alert($word=='')

		if (($writerortitle=='choose')&&($word!='')) {
			alert("검색 대상을 선택해주세요");
			$("#writerortitle").focus();
			return false;
		}
		if (($category=='분류')&&($word!='')) {
			alert("분류를 구분해주세요");
			$("#category").focus();
			return false;
		}
	/* 	alert(startdate);
		alert(enddate);
		alert(category);
		alert(writerortitle);
		alert(word);
	 */	//search(form);.find("#day option:selected").val()

	 $.ajax({
			type: "get",
			contentType: "application/json; charset=UTF-8",
			url: "postlist.ajax",
			data: {
				startdate:$startdate,
				enddate:$enddate,
				category:$category,
				writerortitle:$writerortitle,
				word:$word				

			},
			dataType: "json",
			async: true,
			success: function (data) {
				console.log(data); // chrome console에 출력
				searchedlist(data); 
			},
			error: function (xhr, status, error) {
				alert("Error! " + error);
			}
		}); // ajax end 
	});//search click 이벤크 끝
	  
});

// 테이블에 검색한 데이터 추가
function searchedlist(datas){
	$("#tbody").empty();
	var posts = new Array();//polyline 그릴 좌표 배열
	/* 
	<c:forEach var="post" items="${datas }">//마커찍을 전체 도시들 정보 Array에 저장
	var cityDTO = new Object();
	post.category = "${post.ct_name}";
	post.title = "${post.ct_code}";
	post.writer = "${post.c_code}";
	post.content = "${post.lat}";
	post.regdate = "${post.lng}";
	post.views= "${post.lng}";
	post.file_names= "${post.lng}";
	posts.push(post);
	</c:forEach> */
	
	$("<tr/>", {
	    "class": "tr",
	    html: [ 
			$("<td/>", { html: p_code, }),
			$("<td/>", { html: p_code, }),
			$("<td/>", { html: p_code, }),
			$("<td/>", { html: p_code, }),
			$("<td/>", { html: p_code, }),
			$("<td/>", { html: p_code, }),
	    ]
	}).appendTo(".sub-menu .csp-list");
		
 	/* $("<li/>", {
			    "class": "root list-group-item",
			    html: [ 
					$("<span/>", { "class": "root-place", "id": "p_code", html: p_code, "style": "display: none;" }),
					$("<h3/>", { "class": "root-place", html: [
						$("<span/>", { "class": "num", html: 1, "style": "margin-right: 20px;" }),
						$("<span/>", { "class": "root-place", "id": "p_name", html: p_name })
					] }),
					$("<span/>", { "class": "root-addr", "id": "address", html: address }),
					$("<span/>", { "class": "lat", "id": "lat", html: lat, "style": "display: none;" }),
					$("<span/>", { "class": "lng", "id": "lng", html: lng, "style": "display: none;" })
			    ]
			}).appendTo(".sub-menu .csp-list"); */
}
/* 페이징 시작~~~ */
</script>
<%@ include file="../footer.jsp"%>