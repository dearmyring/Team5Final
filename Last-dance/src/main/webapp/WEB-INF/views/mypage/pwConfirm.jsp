<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param name="title" value="����������"/>
</jsp:include>

<div>
	<form action="pwConfirm" method="post">
		<label for="pwConfirm">��й�ȣ Ȯ��</label>
		<input name="pwConfirm" id="pwConfirm" placeholder="��й�ȣ�� �Է����ּ���"/>
		<button>Ȯ��</button>
	</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>