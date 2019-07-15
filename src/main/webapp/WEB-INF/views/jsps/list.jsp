<%@ include file="../header.jsp"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
${msg }
<div class="container">
	<h2>자료실</h2>
	<div class="table-responsive">
	<div class="pull-right">
		<form id="searchform" onsubmit="checkforsearch(this)" class="form-inline" style="float: rigjt" action="postlist.do" method="get">
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
			<select name="searchOption" id="searchOption" class="form-control">
				<option value="all" selected>선택</option>
				<option value="title">제목</option>
				<option value="title">내용</option>
				<option value="userid">작성자</option>
			</select> 
			<input type="text" name="keyword" id="keyword" class="form-control">
			<input type="hidden" name="curPage" id="curPage" value="${map.boardPager.curPage }" class="form-control">
			<input type="hidden" name="word" id="word" class="form-control">
			<input type="hidden" name="word" id="word" class="form-control">
			<input type="submit" name="search" id="searchNAJAX" class="btn btn-defalt" value="조회">
		</form>
	</div>
		<br>
		<h4>총글수 : ${map.count }</h4>
		<table id="" class="table table-hover" >
			<thead>
				<tr>
					<th>순번</th>
					<th>분류</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<!-- <th>조회수</th> -->
					<!-- <th>첨부파일</th> -->
				</tr>
			</thead>
			<tbody id="tbody">
				<c:forEach var="item" items="${map.list }" varStatus="status">
					<tr class=""  onclick="location.href='postdetail.do?postno=${item.postno}'" style="cursor:pointer;">
						<td>${map.count - ((map.boardPager.curPage -1)*10) - status.index }</td>
						<td>${item.category}</td>
						<td>${item.title}</td>
						<td>${item.userid}</td>
						<td>${item.regdate}</td>
						<%-- <td>${item.views}</td> --%>
						<%-- <td>${item.file_names}</td> --%>
					</tr>
				</c:forEach>
				
			</tbody>
			
			<!-- 페이징 -->
			<tr>
				<td colspan="5">
					<!-- 처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력-->
					<c:if test="${map.boardPager.curBlock > 1}">
						<a href="javascript:list('1')">[처음]</a>
					</c:if>
					
					<!-- 이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
					<c:if test="${map.boardPager.curBlock > 1}">
						<a href="javascript:list('${map.boardPager.prevPage}')">[이전]</a>
					</c:if>
					
					<!-- **하나의 블럭 시작페이지부터 끝페이지까지 반복문 실행 -->
					<c:forEach var="num" begin="${map.boardPager.blockBegin}" end="${map.boardPager.blockEnd}">
						<!-- 현재페이지이면 하이퍼링크 제거 -->
						<c:choose>
							<c:when test="${num == map.boardPager.curPage}">
								<span style="color: red">${num}</span>&nbsp;
							</c:when>
							<c:otherwise>
								<a href="javascript:list(${num})">${num}</a>&nbsp;
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<!-- 다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
					<c:if test="${map.boardPager.curBlock <= map.boardPager.totBlock}">
						<a href="javascript:list(${map.boardPager.nextPage})">[다음]</a>
					</c:if>
					
					<!-- 끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
					<c:if test="${map.boardPager.curPage <= map.boardPager.totPage}">
						<a href="javascript:list(${map.boardPager.totPage})">[끝]</a>
					</c:if>
				</td>
			</tr>
			<!-- 페이징 -->
		</table>

	</div>
	<div style="margin: auto">
		<button class="btn pull-right" onclick="location.href='postinsert.do'">글쓰기</button>
	</div>
</div>

<script type="text/javascript">

/* 
function checkforsearch(f){
	var form = $('#searchform');
	
	alert(form.find("#category option:selected").val());
	alert(form.find("#searchOption option:selected").val());
	return false;
	}
	
}

 */


$(document).ready(function(){
	$('#search').on('click', function(){
		//concol.log(form);
		var form = $(this).parent("#searchform");
		//alert("!!"+form);
		var $startdate = form.children("#startdate").val();
		var $enddate = form.children("#enddate").val();
		var $category = form.find("#category option:selected").val();//선택안되어있으면 undefind?
		var $searchOption = form.find("#writerortitle option:selected").val();
		var $word = form.children("#word").val();

		console.log($startdate);
		console.log($enddate);
		console.log($category);
		console.log($writerortitle);
		console.log($word);
		//alert($word=='')

		if (($searchOption=='choose')&&($word!='')) {
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

	$("<tr/>", {
	    "class": "tr",
	    html: [ 
			$("<td/>", { html: post.postno, }),
			$("<td/>", { html: post.category, }),
			$("<td/>", { html: post.title, }),
			$("<td/>", { html: post.userid, }),
			$("<td/>", { html: post.regdate, }),
			$("<td/>", { html: post.p_code, })
	    ]
	}).appendTo("#tbody");
		

	
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






	// 원하는 페이지로 이동시 검색조건, 키워드 값을 유지하기 위해 
function list(page){
	location.href="${pageContext.request.contextPath}/postlist.do?curPage="+page+"&searchOption=${map.searchOption}"+"&keyword=${map.keyword}";
}
</script>
<%@ include file="../footer.jsp"%>