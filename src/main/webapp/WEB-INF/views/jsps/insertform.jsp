<%@ include file="../header.jsp"%>
<%@ include file="../sessionCheck.jsp"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>




<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.js"></script>
<script src="../js/summernote-ko-KR.js"></script>

<h2>글쓰기</h2>

<form action="postinsert.do" method="POST" onsubmit="insertcheck()" class="form" id="insform"  enctype="multipart/form-data" >
	<input type="hidden" name="userid" id="userid" value="${session_userid }"/>
	<table class="table" table-responsive>
		<tr>
			<th>제목</th>
			<th><input type="text" name="title" id="title" class="form-control"/></th>
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
	<textarea id="content" name="content"></textarea>
	<input multiple="multiple" type="file" class="btn btn-default right" name="file" id="file">
	<input type="submit" value="저장" class="btn btn-default">
	<input type="button"value="목록" class="btn btn-default" onclick="location.href='postlist.do'">
</form>

<script>
	$(document).ready(function() {
		$('#content').summernote({
			lang: 'ko-KR', 
			height: 300,
			fontNames : [ '맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', ],
			fontNamesIgnoreCheck : [ '맑은고딕' ],
			focus: true
		});
	});



	function insertcheck(){
		//alert($("#title").val()==null);
		//alert($("#content").val()); 
		

		if ($("#title").val()==null) {
			aler("제목을 입력하세요");
			return false;

			if ($("#content").val()==null) {
				aler("내용을 입력하세요");
				return false;
			}
		}else {
			return true;
			
		}
	}

</script>


<%@ include file="../footer.jsp"%>