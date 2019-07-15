<%@ include file="../header.jsp"%>
<%-- <%@ include file="../sessionCheck.jsp"%> --%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/summernote-ko-KR.js"></script>
<div class="container">

<h2>게시글 보기</h2>


<%-- 
<form action="" method="POST" class="form" onsubmit=""
	enctype="multipart/form-data">
	<table class="table" table-responsive>
		<tr>
			<th>제목</th>
			<th><input type="text" name="title" id="title"
				class="form-control" value="${dto.title }" /></th>
		</tr>
		<tr>
			<th>분류</th>
			<th><select name="category" id="category" class="form-control">
					<option value="교수학습방법">교수학습방법</option>
					<option value="평가방법">평가방법</option>
					<option value="강의자료">강의자료</option>
					<option value="기타자료">기타자료</option>
					<option value="보고서">보고서</option>
			</select></th>

		</tr>
	</table>
	<textarea id="content" name="content" class="form-control"
		style="height: 300px"></textarea>
	<div>
		<!-- 원하는 날짜형식으로 출력하기 위해 fmt태그 사용 -->
		작성일자 :
		<fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd a HH:mm:ss" />
		<!-- 날짜 형식 => yyyy 4자리연도, MM 월, dd 일, a 오전/오후, HH 24시간제, hh 12시간제, mm 분, ss 초 -->
	</div>
	<div>조회수 : ${dto.views}</div>
	<div>
		제목 <input name="title" id="title" size="80" value="${dto.title}"
			placeholder="제목을 입력해주세요">
	</div>
	<div>
		내용
		<textarea name="content" id="content" rows="4" cols="80"
			placeholder="내용을 입력해주세요">${dto.content}</textarea>
	</div>
	<div>
		작성자
		<input name="writer" id="writer" value="${dto.userid}" placeholder="이름을 입력해주세요">
		${dto.userid}
	</div>
	<!-- 첨부파일 목록 -->
	<div>
		첨부파일
		<div id="uploadedList"></div>
	</div>
	<!-- 첨부파일을 드래그할 영역 -->
	<div>
		<div id="fileDrop"></div>
	</div>
	<div style="width: 650px; text-align: center;">
		<!-- 게시물번호를 hidden으로 처리 -->
		<input type="hidden" name="postno" value="${dto.postno}">
		<!-- 본인이 쓴 게시물만 수정, 삭제가 가능하도록 처리 -->
		<c:if test="${session_userid == dto.userid}">
			<button type="button" id="btnUpdete" class="btn btn-primary">수정</button>
			<button type="button" id="btnDelete" class="btn btn-primary">삭제</button>
		</c:if>
		<!-- 상세보기 화면에서 게시글 목록화면으로 이동 -->
		<button type="button" id="list" class="btn btn-info">목록</button>
	</div>
</form>
 --%>
 
	
<form id="updateform" action="updateproc.do" method="post" enctype="multipart/form-data" class="form-inline" style="float: rigjt" >
<input type="hidden" name="postno" value="${dto.postno }">
<div class="pull-right">
작성자&nbsp;-&nbsp; ${dto.userid }&nbsp;&nbsp;
작성일&nbsp;-&nbsp; ${dto.regdate }
</div>

<table class="table table-bordered table-condensed"  style="margin:0 auto;">		
	
	<tr>
		<th>제목</th>
		<td><input type="text" class="form-control" name="title" id="title"
			size="20" maxlength="100" readonly="readonly" value="${dto.title }"></td>
	</tr>
	<tr>
		<th>내용</th>
		<td>
		<div id="condiv">
			${dto.content }		
		</div>
		<textarea id="content" style="display: none;" readonly="readonly" class="form-control" rows="5" cols="30" name="content" id="content">
			${dto.content }		
		</textarea>
		</td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td id="fileTd">
		<%-- 
		<a class="file_names" href="${pageContext.request.contextPath}/resources/files_updown/1562918944120Capture001.png" download>${dto.file_names }</a>
		 --%>
		 <c:forEach var="file" items="${file_names}" varStatus="st">
<%-- 		  	 ${fn:length(file) }
${fn:substring(file,0,3) }<br>
${fn:substring(file,3,) }<br>
${fn:substring(file,9,13) }<br> --%>
			<c:if test="${file.uplodedName != null}">
			<a class="file_names${st.index}" href="${pageContext.request.contextPath}/resources/files_updown/${file.uplodedName}" download>${file.originName }</a>
			<button onclick="deletefile(${st.index}, '${file.uplodedName}');" style="display: none;" type="button" id="deletefiel${st.index}" class="deletefiel" value="제거">제거</button><br>

			</c:if>
 
		  	
 		</c:forEach>
		 
		<br>
		<input style="display: none" id="file_names" type="file" class="form-control" readonly="readonly">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center" id="buttonTd">
		 <c:if test="${session_userid == dto.userid}">
			<button onclick="changeForUpdate()" type="button" id="btnUpdete" class="btn btn-primary">수정</button>
			<button onclick="deletepost();" type="button" id="btnDelete" class="btn btn-primary">삭제</button>
		</c:if>
		<!-- 상세보기 화면에서 게시글 목록화면으로 이동 -->
		<button type="button" id="list" onclick="location.href='${pageContext.request.contextPath}/postlist.do'" class="btn btn-info">목록</button>
			
		</td>
	</tr>
</table>
</form>

<script>
function deletepost(){
	console.log("deletepost() 요청");
	var conf = confirm("정말로 삭제하시겠습니까? 삭제한 내용은 복구 되지 않습니다.");
	if (!conf) {
		return false;
	}
	
	$.ajax({
		type : "POST",
		url : "${pageContext.request.contextPath}/postdelete.ajax",
		dataType : "text",
		data : { 
			userid : "${dto.userid}",
			postno : ${dto.postno }
		},
		async: false,
		success : function(result) {
			console.log(result)
			if (result == "1") {
				alert("제거성공");
				//alert(window.location.href );
				window.location.href = "${pageContext.request.contextPath}/postlist.do";

			} else {
				alert("알수 없는 이유로 제거 실패");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert("제거 실패");
			//self.close();
		}

	});
	
}

	//$('#content').summernote('disable','height: 300', 'toolbar: false');
		/*
		{
			lang: 'ko-KR', 
			height: 300,
			fontNames : [ '맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', ],
			fontNamesIgnoreCheck : [ '맑은고딕' ],
			focus: true
		}
		*/
function changeForUpdate(){
	$("#title").removeAttr("readonly"); 
	$("#condiv").remove(); 
	$("#content").removeAttr("style"); 
	$(".deletefiel").removeAttr("style"); 
	$("#file_names").removeAttr("style"); 
	$("#content").removeAttr("readonly"); 
	$("#content").summernote({
		lang: 'ko-KR', 
		height: 300,
		fontNames : [ '맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', ],
		fontNamesIgnoreCheck : [ '맑은고딕' ],
		focus: true
	});

	$("#btnUpdete").attr("onclick", "updateProc()");
	$("#btnDelete").text("수정 취소");
	$("#btnDelete").attr("onclick", "cancle()");
	
}
function cancle(){
	location.href="${pageContext.request.contextPath}/postdetail.do?postno=${dto.postno}";
}
function updateProc(){
	console.log("업데이트 합시다.");

	console.log($("#updateform").children("#title").val());
	console.log($("#updateform").children("#content").val());
	console.log($("#updateform").children("#postno").val());
	var conf = confirm("정말로 수정하시겠습니까? 수정한 내용은 복구 되지 않습니다.");
	if (!conf) {
		return false;
	}
	$("#updateform").submit();
	
		
	
}
function deletefile(idx, fn){
	console.log("deletefile() 요청");
	var conf = confirm("정말로 삭제하시겠습니까? 삭제한 내용은 복구 되지 않습니다.");
	if (!conf) {
		return false;
	}
	var filename =  fn.toString();
	//var idx =  idx.toString();
	console.log(filename);
	
	$.ajax({
		type : "POST",
		url : "${pageContext.request.contextPath}/deletefile.ajax",
		dataType : "json",
		data : { 
			idx : idx,
			fileName : filename,
			postno: "${dto.postno }",
			file_names: '${dto.file_names }',
			userid :"${dto.userid }"
		},
		async: false,
		success : function(result) {
			console.log(result)
			if (result == "1") {
				alert("제거성공");
				var delA=".file_names"+idx;
				var delB="#deletefiel"+idx;
				console.log(delA);
				console.log(delB);
				$(delA).remove(); 
				$(delB).remove(); 
				//alert(window.location.href );
				//window.location.href = "${pageContext.request.contextPath}/postlist.do";

			} else {
				alert("알수 없는 이유로 제거 실패");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert("제거 실패");
			//self.close();
		}

	});
	
}



/* 
	$("<a/>",{"class": "file_names",
			html: ${file} 
	}).appendTo.("#fileTd");
 */
/*
 $("<li/>", {
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
			}).appendTo(".sub-menu .csp-list");
 */
</script>


</div>
<%@ include file="../footer.jsp"%>