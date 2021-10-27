<%@ Page Language="C#" AutoEventWireup="true" CodeFile="newrecipe.aspx.cs" Inherits="NR_Valut.newrecipe" %>

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
                <a class="navbar-brand" href="default.aspx">NR Home</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="default.aspx">Home <span class="sr-only">(current)</span></a>
                        </li>
                         <li class="nav-item">
                            <a class="nav-link" href="recipearchive.aspx">Recipes</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="vault.aspx">Vault</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
                                aria-haspopup="true" aria-expanded="false">Other
                            </a>
                            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item" href="newrecipe.aspx">New Recipe</a>
                                <a class="dropdown-item" href="photo.aspx">Photo Archive</a>
                                <a class="dropdown-item" href="recipe.aspx">Recipe Layout Builder</a>
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
</body>

<footer class="text-muted">
</footer>

</html>

<script>

    $(document).ready(function () {
        $(".dropdown-toggle").dropdown();

    });

</script>

</html>
