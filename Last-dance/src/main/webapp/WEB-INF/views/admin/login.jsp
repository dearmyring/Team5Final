<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>냉장고를 부탁해</title>

    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <!-- Bootswatch CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.0.2/litera/bootstrap.min.css" integrity="sha512-WC/IImFzoPRFTlJQpUSqaM1QOKsIWIfrmhkkXRXoDeB9hlArdsUAWOURes+oFcDRPUUZhuc2QdyfaZEGXjd6kg==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <!-- font awesome CDN-->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
    
    <style>
		.yellow-btn { 
			background-color:#ECBE42;
			color:white;
		}
    </style>
    
  </head>
  <body>

    <div class="container-fluid 
    position-absolute top-50 start-50 translate-middle">

        <div class="row">
            <div class="col-lg-2 offset-lg-5 col-md-4 offset-md-4 col-sm-6 offset-sm-3">
				<img class="w-100" src="${pageContext.request.contextPath}/images/logo.png"/>
            </div>
		</div>
		
        <form action="login" method="post" class="admin-login-form">
        <div class="row">
            <div class="col-lg-2 offset-lg-5 col-md-4 offset-md-4 col-sm-6 offset-sm-3">
                <div class="form-floating">
                    <input type="text" name="adminId" autocomplete="off" id="floatingInput" placeholder="name@example.com" class="form-control rounded">
                    <div class="invalid-feedback"></div>
                    <label for="floatingInput">ID</label>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-2 offset-lg-5 col-md-4 offset-md-4 col-sm-6 offset-sm-3">
                <div class="form-floating">
                    <input type="password" name="adminPw" autocomplete="off" id="floatingPassword" placeholder="Password" class="form-control rounded">
                    <div class="invalid-feedback">아이디 또는 비밀번호 입력정보를 확인해주세요.</div>
                    <label for="floatingPassword">Password</label>
                </div>
            </div>
        </div>
        <div class="row mt-4">
            <div class="col-lg-2 offset-lg-5 col-md-4 offset-md-4 col-sm-6 offset-sm-3">
                <div class="form-floating">
                    <button class="login-btn btn btn-lg w-100 rounded yellow-btn admin-login-btn" type="submit">로그인</button>
                </div>
            </div>
        </div>
        </form>
        
        <div class="row mt-4">
            <div class="col-lg-2 offset-lg-5 col-md-4 offset-md-4 col-sm-6 offset-sm-3">
				<div class="text-center">
					&copy; Last-dance Corp.
				</div>
				<div class="text-center">
					All rights reserved.
				</div>
			</div>        	
        </div>

    </div>

    <!-- Optional JavaScript; choose one of the two! -->

    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

    <!-- Option 2: Separate Popper and Bootstrap JS -->
    <!--
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    -->

    <!-- jquery 사용 위한 라이브러리 파일 불러옴 -->
    <script src="https://code.jquery.com/jquery-3.6.1.js"></script>
    <script type="text/javascript">
        $(function(){
        	$(".admin-login-btn").on("click", function(e){
        		e.preventDefault();
                var adminId = $("[name=adminId]").val();
                var adminPw = $("[name=adminPw]").val();

                if(adminId == '' || adminPw == ''){
					$("[name=adminId]").addClass("is-invalid");
					$("[name=adminPw]").addClass("is-invalid");
                }

                else{
                    $.ajax({
                        url: "http://localhost:8888/rest/admin",
                        method: "post",
                        contentType: 'application/json',
                        data: JSON.stringify({
                            adminId : adminId,
                            adminPw : adminPw
                        }),
                        success: function(resp){
                        	console.log(resp);
                            if(resp == 'fail'){
                                $("[name=adminId]").addClass("is-invalid");
                                $("[name=adminPw]").addClass("is-invalid");
                            }
                            else{
								$(".admin-login-form").submit();
                            }
                        }
                    });
                }
        	});
        });
    </script>
</body>
</html>