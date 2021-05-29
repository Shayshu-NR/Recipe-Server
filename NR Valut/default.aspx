﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="NR_Valut._default" %>

    <!DOCTYPE html>

    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"
            integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-p34f1UUtsS3wqzfto5wAAmdvj+osOnFyQFpp4Ua3gs/ZVWx6oOypYoCJhGGScy+8"
            crossorigin="anonymous"></script>
        <script src="https://kit.fontawesome.com/ea86fc6cea.js" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"
            integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>

    <body>
        <div class="container">
            <div>
                <nav class="navbar navbar-expand-lg navbar-light">
                    <a class="navbar-brand" href="#">NR Home</a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse"
                        data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                        aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav mr-auto">
                            <li class="nav-item active">
                                <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="vault.aspx">Vault</a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                                    data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Other
                                </a>
                                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                    <a class="dropdown-item" href="recipe.aspx">Recipe Archive</a>
                                    <a class="dropdown-item" href="photo.aspx">Photo Archive</a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="admin.aspx">Admin</a>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <form class="navbar-form navbar-left">
                        <div class="row">
                            <div class="col-auto">

                                <button class="btn btn-outline-success" type="submit">Search</button>
                            </div>
                            <div class="col">

                                <input class="form-control mr-sm-2" type="search" placeholder="Search"
                                    aria-label="Search">
                            </div>
                        </div>
                    </form>
                </nav>
            </div>
        </div>
        <div class="position-fixed top-80 end-0 p-3" style="z-index: 5">
            <div id="loginStatus" class="toast hide" role="alert" aria-live="assertive" aria-atomic="true"
                data-bs-autohide="false">
                <div class="toast-header">
                    <strong class="me-auto">NR Vault</strong>
                    <small id="loginTime"></small>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                </div>
            </div>
        </div>
        <br><br>


        <div class="container text-center form-group">
            <div class="row justify-content-center align-items-center">
                <form class="col-md-5 card p-3" id="login">
                    <h1 class="h3 mb-3 font-weight-normal">
                        Login
                    </h1>

                    <input type="username" class="form-control" placeholder="Username" id="username" required=""
                        autofocus="">

                    <br>
                    <div class="input-group">
                        <input type="password" class="form-control current-password" placeholder="Password"
                            id="password" required="">
                        <span class="input-group-btn">
                            <button class="form-control reveal" type="button">
                                <i class="fa fa-eye" aria-hidden="true"></i>
                            </button>
                        </span>
                    </div>
                    <br>
                    <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
                </form>
            </div>
        </div>

        <div id="userInfo">
        </div>
    </body>

    <footer class="text-muted">

    </footer>

    </html>

    <script>
        var username;
        var password;

        $(document).ready(function () {
            $('.toast').toast();
            $('#loginStatus').toast('hide');
            $(".dropdown-toggle").dropdown();

            $(".reveal").click(function () {
                var $pwd = $("#password");
                if ($pwd.attr('type') == "password") {
                    $pwd.attr('type', 'text');
                    $(".fa").removeClass("fa-eye");
                    $(".fa").addClass("fa-eye-slash");
                } else {
                    $pwd.attr('type', 'password');
                    $(".fa").removeClass("fa-eye-slash");
                    $(".fa").addClass("fa-eye");
                }
            });

            $("#login").on("submit", function (e) {
                e.preventDefault();

                username = $("#username").val()
                password = $("#password").val()

                var dataDict = JSON.stringify({ "username": username, "password": password })
                console.log(dataDict)
                // Send ajax request 
                $.ajax({
                    type: "POST",
                    url: "default.aspx/Login",
                    dataType: "json",
                    data: dataDict,
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        var recvData = JSON.parse(data.d);
                        console.log(recvData);

                        if (recvData.Success != 'undefined') {
                            // Show alert and remove login screen
                            $("#login").animate({ borderColor: "green" }, 500, "swing").delay(100).animate({ borderColor: "rgba(0,0,0,0.125)" }, 500, "swing", function () {
                                $("#login").slideUp(500)
                                $(".toast-body").html("Login Sucessful")
                                $("#loginStatus").toast('show')

                                // Get user info and show it...
                                $.ajax({
                                    type: "POST",
                                    url: "default.aspx/getUserInfo",
                                    dataType: "json",
                                    data: dataDict,
                                    contentType: "application/json; charset=utf-8",
                                    success: function(data){
                                        console.log(data.d)
                                    }
                                })

                            })

                        }
                        else {
                            // Show error and clear inputs...
                            $("#login").animate({ borderColor: "red" }, 500, "swing").delay(100).animate({ borderColor: "rgba(0,0,0,0.125)" }, 500, "swing")
                            $(".toast-body").html("Login failed")
                            $("#loginStatus").toast('show')
                        }

                    }
                })


            })
        });
    </script>

    </html>