<%@ Page Language="C#" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="NR_Valut._default" %>

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
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />
</head>

<style>
    body {
        margin-top: 20px;
        background: #f5f5f5;
    }

    .ui-w-100 {
        width: 100px !important;
        height: auto;
    }

    .card {
        background-clip: padding-box;
        box-shadow: 0 1px 4px rgba(24, 28, 33, 0.012);
    }

    .user-view-table td:first-child {
        width: 9rem;
    }

    .user-view-table td {
        padding-right: 0;
        padding-left: 0;
        border: 0;
    }

    .text-light {
        color: #babbbc !important;
    }

    .card .row-bordered > [class*=" col-"]::after {
        border-color: rgba(24, 28, 33, 0.075);
    }

    .text-xlarge {
        font-size: 170% !important;
    }
</style>

<body>
    <div class="container">
        <div>
            <nav class="navbar navbar-expand-lg navbar-light">
                <a class="navbar-brand" href="#">NR Home</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
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
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
                                aria-haspopup="true" aria-expanded="false">Other
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

                            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
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
    <br>
    <br>


    <div class="container text-center form-group" runat="server" id="loginContainer">
    </div>

    <div id="userInfo" style="display: none;">
        <div class="container bootdey flex-grow-1 container-p-y">
            <div class="media align-items-center py-3 mb-3">
                <div class="media-body ml-4">
                    <h4 class="font-weight-bold mb-0" id="name"></h4>
                    <button class="btn btn-primary btn-sm">Edit Profile</button>&nbsp;
                </div>
            </div>

            <div class="card mb-4" id="profileInfoCard">
                <div class="card-body">
                    <table class="table user-view-table m-0">
                        <tbody>
                            <tr>
                                <td>ID:</td>
                                <td id="userID" runat="server"></td>
                            </tr>
                            <tr>
                                <td>Registered:</td>
                                <td id="registerDate" runat="server"></td>
                            </tr>
                            <tr>
                                <td>Latest activity:</td>
                                <td id="lastActive" runat="server"></td>
                            </tr>
                            <tr>
                                <td>Verified:</td>
                                <td id="verifiedCheck" runat="server"><span class=""></span>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>Role:</td>
                                <td id="userRole" runat="server"></td>
                            </tr>
                            <tr>
                                <td>Status:</td>
                                <td><span class="badge bg-success">Active</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <hr class="border-light m-0">
                <div class="table-responsive">
                    <table class="table card-table m-0">
                        <tbody>
                            <tr>
                                <th>Module Permission</th>
                                <th>Read</th>
                                <th>Write</th>
                                <th>Delete</th>
                            </tr>
                            <!-- fa fa-check text-primary -->
                            <!-- -->
                            <tr id="userPermissionsClient">
                                <div id="userPermissions" runat="server">
                                    <td>Users</td>
                                    <td><span class=""></span></td>
                                    <td><span class=""></span></td>
                                    <td><span class=""></span></td>
                                </div>
                            </tr>
                            <tr id="userRecipesClient">
                                <div id="userRecipes" runat="server">
                                    <td>Recipes</td>
                                    <td><span class=""></span></td>
                                    <td><span class=""></span></td>
                                    <td><span class=""></span></td>
                                </div>

                            </tr>
                            <tr id="userPhotosClient">
                                <div id="userPhotos" runat="server">
                                    <td>Photos</td>
                                    <td><span class=""></span></td>
                                    <td><span class=""></span></td>
                                    <td><span class=""></span></td>
                                </div>

                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <table class="table user-view-table m-0">
                        <tbody>
                            <tr>
                                <td>Username:</td>
                                <td id="userName" runat="server"></td>
                            </tr>
                            <tr>
                                <td>Name:</td>
                                <td id="infoName" runat="server"></td>
                            </tr>
                            <tr>
                                <td>E-mail:</td>
                                <td id="Email" runat="server"></td>
                            </tr>
                        </tbody>
                    </table>

                    <h6 class="mt-4 mb-3">Personal info</h6>

                    <table class="table user-view-table m-0">
                        <tbody>
                            <tr>
                                <td>Birthday:</td>
                                <td id="birthday" runat="server"></td>
                            </tr>
                        </tbody>
                    </table>

                    <h6 class="mt-4 mb-3">Contacts</h6>

                    <table class="table user-view-table m-0">
                        <tbody>
                            <tr>
                                <td>Phone:</td>
                                <td id="phone" runat="server"></td>
                            </tr>
                        </tbody>
                    </table>

                </div>
            </div>

        </div>
    </div>
</body>

<footer class="text-muted">
</footer>

</html>

<script>
    var username;
    var password;
    if ($("#userID").text().length > 0) {
        console.log("User ID set");
        $('#userInfo').show(500);
    }

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

            // Send ajax request 
            $.ajax({
                type: "POST",
                url: "default.aspx/Login",
                dataType: "json",
                data: dataDict,
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var recvData = JSON.parse(data.d);
                    console.log(recvData.Success);

                    if (typeof recvData.Success != 'undefined') {
                        // Show alert and remove login screen
                        $("#login").animate({ borderColor: "green" }, 500, "swing").delay(100).animate({ borderColor: "rgba(0,0,0,0.125)" }, 500, "swing", function () {
                            $("#login").slideUp(500)
                            $(".toast-body").html("Login Sucessful")
                            $("#loginStatus").toast('show')

                            var userInfo = recvData.Info[0];
                            $('#registerDate').text(userInfo.datecreated);
                            $('#lastActive').text(userInfo.lastlogin);
                            $('#verified').text(userInfo.verified);
                            $('#userRole').text(userInfo.user_type);
                            $('#birthday').text(userInfo.birthday);
                            $('#phone').text(userInfo.phone_number);
                            $('#Email').text(userInfo.email);
                            $('#infoName').text(userInfo.name);
                            $('#userName').text(userInfo.username);
                            $("#userID").text("ID: " + userInfo.id);

                            var userPermission = getPermissions(userInfo.user_permission);
                            var index = 0;
                            $.each($("#userPermissionsClient").find('span'), function () {
                                if (userPermission[index] !== null) {
                                    this.classList.add(...userPermission[index]);
                                }
                                index++;
                            });

                            var recipePermissions = getPermissions(userInfo.recipe_permission)
                            index = 0;
                            $.each($("#userRecipesClient").find('span'), function () {
                                if (recipePermissions[index] !== null) {
                                    this.classList.add(...recipePermissions[index]);
                                }
                                index++;
                            });

                            var photoPermissions = getPermissions(userInfo.photo_permission)
                            console.log(photoPermissions)
                            index = 0;
                            $.each($("#userPhotosClient").find('span'), function () {
                                if (photoPermissions[index] !== null) {
                                    this.classList.add(...photoPermissions[index]);
                                }
                                index++;
                            });



                            $('#userInfo').show(500);

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

    var RWD = {
        'R': 0,
        'W': 1,
        "D": 2
    }
    function getPermissions(dbPermission) {
        //['R', 'W', 'D']
        var access = [null, null, null];
        for (var i = 0; i < 3; i++) {
            if (typeof dbPermission[i] !== 'undefined') {
                access[RWD[dbPermission[i]]] = ["fa", "fa-check", "text-primary"];
            }
            else {
                access[i] = ["fa", "fa-times", "text-light"];
            }
        }

        return access;
    }
</script>

</html>