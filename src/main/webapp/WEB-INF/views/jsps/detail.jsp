<%@ include file="../header.jsp"%>
<%@ include file="../sessionCheck.jsp"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.css" rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.js"></script>
<script src="../js/summernote-ko-KR.js"></script>

<h2>게시글 보기</h2>

<form action="postinsert.do" method="POST" class="form" onsubmit=""
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
	<input multiple="multiple" type="file" class="btn btn-default right"
		name="file" id="file"> <input type="button" value="수정"
		class="btn btn-default pull-righ"> <input type="button"
		value="삭네" class="btn btn-default pull-righ"> <input
		type="button" value="목록" class="btn btn-default pull-righ"
		onclick="location.href='postlist.do'">
</form>


<form name="form1" id="form1" method="post">
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
		<c:if test="${sessionScope.userid == dto.userid}">
			<button type="button" id="btnUpdete" class="btn btn-primary">수정</button>
			<button type="button" id="btnDelete" class="btn btn-primary">삭제</button>
		</c:if>
		<!-- 상세보기 화면에서 게시글 목록화면으로 이동 -->
		<button type="button" id="list" class="btn btn-info">목록</button>
	</div>
</form>


<script>
	function fileCheck(f) {
		//포토 갤러리 유효성 검사
		//1) 이름

		//2) 제목

		//3) 비밀번호

		//4) 첨부파일
		//문) 첨부파일의 확장명을 출력하시오
		//		예) png, gif, jpg

		var filename = f.filename.value.trim();
		if (filename.length < 5) {
			alert("첨부파일을 선택하세요");
			return false;
		}
		var i = f.filename.value.lastIndexOf(".");
		var extention = filename.substring(i);

		extention.toLowerCase();// 소문자로 변환하는 함수
	}//fileCheck end
</script>


<%@ include file="../footer.jsp"%>