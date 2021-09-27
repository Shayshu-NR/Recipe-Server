<%@ Page Language="C#" AutoEventWireup="true" CodeFile="recipe.aspx.cs" Inherits="NR_Valut.recipe" %>

    <!DOCTYPE html>

    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"
            integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />

        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />

        <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-p34f1UUtsS3wqzfto5wAAmdvj+osOnFyQFpp4Ua3gs/ZVWx6oOypYoCJhGGScy+8"
            crossorigin="anonymous"></script>

        <script src="https://code.jquery.com/jquery-3.6.0.js"
            integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"
            integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30=" crossorigin="anonymous"></script>

        <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jQuery-formBuilder/3.7.2/form-builder.min.js"
            integrity="sha512-qy8cWnyo8rrk1KrntbQJMFuyvFy4F8ccZrBVKedX84VFyeq0IPZZXkx+cpFPvQ6zTate/l02ILa0OnjkRlK76A=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>

        <script src="https://kit.fontawesome.com/ea86fc6cea.js" crossorigin="anonymous"></script>

    </head>
    <style>
        #draggablePanelList .panel-heading {
            cursor: move;
        }

        #draggablePanelList2 .panel-heading {
            cursor: move;
        }

        .select2-selection__rendered {
            line-height: 49px !important;
        }

        .select2-container .select2-selection--single {
            height: 53px !important;
        }

        .select2-selection__arrow {
            height: 52px !important;
        }

        .form-rendered #build-wrap {
            display: none;
        }

        .render-wrap {
            display: none;
        }

        .form-rendered .render-wrap {
            display: block;
        }

        #edit-form {
            display: none;
            float: right;
        }

        .form-rendered #edit-form {
            display: block;
        }
    </style>
    <br>

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
                                    data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Other
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
        <br />
        <div class="container">
            <h2>Recipe Layout Builder</h2>
            <input placeholder="Layout Name..." type="text" class="form-control" name="layout_name" id="layout_name"
                required>
        </div>
        <br>
        <div class="container">
            <div id="build-wrap"></div>
            <div class="render-wrap"></div>
        </div>


    </body>

    </html>



    <script>


        jQuery($ => {
            const fbEditor = document.getElementById('build-wrap');

            var options = {
                onSave: function (evt, formData) {
                    console.log(typeof formData);

                    // Check if the layout name is filled in...
                    if ($("#layout_name").val().length > 0) {
                        var layoutData = {
                            "name": $("#layout_name").val(),
                            "structure": formData
                        }

                        console.log(JSON.stringify(layoutData));

                        $.ajax({
                            type: "POST",
                            url: "recipe.aspx/NewRecipeLayout",
                            data: JSON.stringify(layoutData),
                            dataType: "json",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) { 
                                console.log(data.d);
                            },
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                alert("Status: " + textStatus); alert("Error: " + errorThrown);
                            } 
                        })
                    }
                    else {
                        console.log("Need a layout name")
                    }
                }
            };

            const formBuilder = $(fbEditor).formBuilder(options)

        });


    </script>