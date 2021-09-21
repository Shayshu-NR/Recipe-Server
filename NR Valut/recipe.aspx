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

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jQuery-formBuilder/3.7.2/form-builder.min.js" integrity="sha512-qy8cWnyo8rrk1KrntbQJMFuyvFy4F8ccZrBVKedX84VFyeq0IPZZXkx+cpFPvQ6zTate/l02ILa0OnjkRlK76A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jQuery-formBuilder/3.7.2/form-render.min.js" integrity="sha512-Dxm3yhPE+u1tqRfs9na7yB9hTNAifhzKJO9poSgpXoUBMaXIU/9nZ5/moHxA+HHBGxvnQFEdc02QJd4mL/NIPQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

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
    </style>
    <br>

    <body>
        <div class="container">
            <ul id="draggablePanelList" class="list-group list-group-flush">
                <li class="list-group-item input-group mb-3">
                    <div class="input-group mb-3">
                        <div class="input-group-prepend drag-panel">
                            <span class="input-group-text">
                                <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor"
                                    class="bi bi-grip-vertical" viewBox="0 0 16 16">
                                    <path
                                        d="M7 2a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zM7 5a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zM7 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm-3 3a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm-3 3a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
                                </svg>
                            </span>
                        </div>
                        <textarea class="form-control" rows="1" placeholder="Paragraph..."
                            aria-label="Username"></textarea>
                    </div>
                </li>
                <li class="list-group-item">
                    <div class="input-group mb-3">
                        <div class="input-group-prepend drag-panel">
                            <span class="input-group-text">
                                <svg xmlns="http://www.w3.org/2000/svg" width="32" height="34" fill="currentColor"
                                    class="bi bi-grip-vertical" viewBox="0 0 16 16">
                                    <path
                                        d="M7 2a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zM7 5a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zM7 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm-3 3a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm-3 3a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
                                </svg>
                            </span>
                        </div>
                        <input class="form-control form-control-lg" style="font-weight: bold;"
                            placeholder="Header..." />
                    </div>
                </li>
                <li class="list-group-item">
                    <div class="input-group mb-3">
                        <div class="input-group-prepend drag-panel">
                            <span class="input-group-text">
                                <svg xmlns="http://www.w3.org/2000/svg" width="32" height="34" fill="currentColor"
                                    class="bi bi-grip-vertical" viewBox="0 0 16 16">
                                    <path
                                        d="M7 2a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zM7 5a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zM7 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm-3 3a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm-3 3a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
                                </svg>
                            </span>
                        </div>
                        <input class="form-control" placeholder="Ingredient" />
                        <div class="col-xs-2">
                            <select class="form-select select2-units" aria-label="select example"
                                style="height: 50px !important;">
                                <option selected value="">Unit</option>
                                <option value="1">Cup</option>
                                <option value="2">Teaspoon</option>
                                <option value="3">Tablespoon</option>
                                <option value="3">Fluid Ounce</option>
                                <option value="3">Millimeter </option>
                                <option value="3">Liter</option>
                                <option value="3">Pound</option>
                                <option value="3">Milligram</option>
                                <option value="3">Gram</option>
                                <option value="3">Killogram</option>
                            </select>
                        </div>
                        <div class="col-xs-2">
                            <input class="form-control" placeholder="Quantity" />
                        </div>
                    </div>
                </li>
                <li class="list-group-item">
                    <div class="drag-panel">You can drag this panel too.</div>
                    <div class="panel-body">Another content panel here...</div>
                </li>
            </ul>
        </div>

        <button type="button" class="btn btn-primary" name="add" id="addItem">test</button>

    </body>

    </html>



    <script>
        jQuery(function ($) {
            var panelList = $('#draggablePanelList');

            panelList.sortable({
                // Only make the .panel-heading child elements support dragging.
                // Omit this to make then entire <li>...</li> draggable.
                handle: '.drag-panel',
                update: function () {
                    $('.panel', panelList).each(function (index, elem) {
                        var $listItem = $(elem),
                            newIndex = $listItem.index();

                        // Persist the new indices.
                    });
                }
            });
        });

        jQuery(function ($) {
            var panelList2 = $('#draggablePanelList2');

            panelList2.sortable({
                // Only make the .panel-heading child elements support dragging.
                // Omit this to make then entire <li>...</li> draggable.
                handle: '.panel-heading',
                update: function () {
                    $('.panel', panelList2).each(function (index, elem) {
                        var $listItem = $(elem),
                            newIndex = $listItem.index();

                        // Persist the new indices.
                    });
                }
            });
        });
        $(document).ready(function () {
            $("#addItem").click(function () {
                // Add a child element 
                $("#draggablePanelList").append('<li class="list-group-item">\
                    <div class="drag-panel">You can drag this panel too.</div>\
                    <div class="panel-body">Another content panel here...</div>\
                </li>')
            })

            $('.select2-units').select2();

        })
    </script>