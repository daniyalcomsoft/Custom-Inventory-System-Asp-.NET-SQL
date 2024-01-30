function AddNewRole() {
    clearvalidate('Modal');
    $("[Id$=HDDRoleID]").val("0");
    jQuery("#btnAddRole").showLoading();
    Clear_form_elements('ModalUserRole');
    ShowModal('ModalUserRole');
    $("[Id$=ddlCompany]").prop('selectedIndex', 1);
    $("[Id$=txtRoleName]").removeAttr("disabled");
    $("[Id$=Description]").removeAttr("disabled");
    $("[Id$=ddlStatus]").removeAttr("disabled");
    $("[Id$=btnSaveRole]").html('Save').show();
    jQuery("#btnAddRole").hideLoading();
}

function BindGridView() {
    $.ajax({
        type: "POST",
        url: "UserRole.aspx/GetData",
        contentType: "application/json;charset=utf-8",
        data: {},
        dataType: "json",
        success: function (data) {
            $("#GridUserRole").empty();

            var Json = JSON.parse(data.d);
            if (Json.length > 0) {
                $("#GridUserRole").append("<tr><th>Role Name</th> <th>Description</th>  <th>Status</th>  <th>Edit</th>  <th>Role Permissions</th> </tr>");
                for (var i = 0; i < Json.length; i++) {

                    var RoleID = Json[i].RoleID;
                    var RoleName = Json[i].RoleName;
                    var Description = Json[i].Description;
                    var Status = Json[i].Status;
                    if (RoleID > 1)
                        {
                    $("#GridUserRole").append("<tr><td>" +
                    RoleName + "</td> <td>" +
                    Description + "</td> <td >" +
                    StatusConvertToString(Boolean(Status)) + "</td> <td style=' width: 12%;text-align: center;'> " +
                   
                    "<button type='button' class='btn btn-primary' id='btnEdit' onclick='javascript:EditRole(" + RoleID + ")'><i class='icon fa-edit' aria-hidden='true'></i>Edit</button" +
                    "</td> <td style=' width: 12%;text-align: center;'> " +
                    //"<button type='button' style='background: transparent;border: none;color: #9c27b0;' id='btnDelete' onclick='javascript:RoleDeleteConfirmation(" + RoleID + ");'><i class='icon fa-trash-o icon_custom' aria-hidden='true'></i></button" +
                    //"</td> <td style='    width: 12%;text-align: center;'> " +
                    "<button type='button' class='btn btn-primary' id='btnPermission' onclick=\"javascript:RolePermission(" + RoleID + ",'" + RoleName + "')\"><i class='icon fa-check' aria-hidden='true'></i>Permission</button" +
                    "</td></tr>");
                    }
                    else
                        {
                    $("#GridUserRole").append("<tr><td>" +
                  RoleName + "</td> <td>" +
                  Description + "</td> <td >" +
                  StatusConvertToString(Boolean(Status)) + "</td> <td style=' width: 12%;text-align: center;'> " +

                 
                  "</td><td></td></tr>");
                    }
                }
            }
        },
        //"<button type='button' class='btn btn-danger' id='btnDelete' onclick='javascript:RoleDeleteConfirmation(" + RoleID + ");'><i class='icon fa-trash-o' aria-hidden='true'></i>Delete</button" +
        //           "</td> <td style='    width: 12%;text-align: center;'> " +
        error: function (data) {
            alert("Error" + data.d);
        }
    });
}

function ViewRole(RoleID, Type) {
    $.ajax({
        type: "POST",
        url: "UserRole.aspx/ViewRole",
        contentType: "application/json;charset=utf-8",
        data: "{RoleID: " + RoleID + " }",
        dataType: "json",
        success: function (data) {
            var Json = JSON.parse(data.d);
            if (Json.length > 0) {
                for (var i = 0; i < Json.length; i++) {

                    var CompanyID = Json[i].CompanyID;
                    var RoleID = Json[i].RoleID;
                    var RoleName = Json[i].RoleName;
                    var Description = Json[i].Description;
                    var Status = Json[i].Status;

                    if (Type == 'View') {
                        $("[Id$=ddlCompany]").val(parseInt(CompanyID)).attr("selected", "selected").attr("disabled", "disabled");
                        $("[Id$=txtRoleName]").val(RoleName).attr("disabled", "disabled");
                        $("[Id$=Description]").val(Description).attr("disabled", "disabled");
                        $("[Id$=ddlStatus]").val(BooleanToInt(Status)).attr("selected", "selected").attr("disabled", "disabled");
                        $("[Id$=btnSaveRole]").hide();
                    }
                    else {
                        $("[Id$=ddlCompany]").val(parseInt(CompanyID)).attr("selected", "selected").attr("disabled", "disabled");
                        $("[Id$=txtRoleName]").val(RoleName).removeAttr("disabled");
                        $("[Id$=Description]").val(Description).removeAttr("disabled");
                        $("[Id$=ddlStatus]").val(BooleanToInt(Status)).attr("selected", "selected").removeAttr("disabled");
                    }

                }
                clearvalidate('Modal');
                ShowModal('ModalUserRole');
            }
        },
        error: function (data) {
            alert("Error" + data.d);
        }
    });
}

function EditRole(RoleID) {
    $("[Id$=HDDRoleID]").val(RoleID);
    $("[Id$=btnSaveRole]").html('Update').show();
    ViewRole(RoleID);
}

function DeleteRole(RoleID) {
    $.ajax({
        type: "POST",
        url: "UserRole.aspx/DeleteRole",
        contentType: "application/json;charset=utf-8",
        data: "{RoleID: " + RoleID + " }",
        dataType: "json",
        success: function (data) {
            BindGridView();
            showStatusMsg("1", "Role Deleted Successfully.");
        },
        error: function (data) {
            showStatusMsg("2", data.d);
        }
    });
}

function SaveRole(CompanyID, RoleName, Description, Status) {
    var dataValue = "{ CompanyID: " + CompanyID + ", RoleName: '" + RoleName + "', Description: '" + Description + "', Status: " + Status + "}";
    $.ajax({
        type: "POST",
        url: "UserRole.aspx/SaveRole",
        data: dataValue,
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        error: function (result) {
            jQuery("#btnSaveRole").hideLoading();
            showStatusMsg('2', result.d);
        },
        success: function (result) {
            BindGridView();
            jQuery("#btnSaveRole").hideLoading();
            HideModal('ModalUserRole');
            showStatusMsg("1", "Role Saved Successfully.");
        }
    });
}

function UpdateRole(CompanyID, RoleID, RoleName, Description, Status) {
    var dataValue = "{ CompanyID: " + CompanyID + ", RoleID: " + RoleID + ", RoleName: '" + RoleName + "', Description: '" + Description + "', Status: " + Status + "}";
    $.ajax({
        type: "POST",
        url: "UserRole.aspx/EditRole",
        data: dataValue,
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        error: function (result) {
            jQuery("#btnSaveRole").hideLoading();
            showStatusMsg('2', result.d);
        },
        success: function (result) {
            BindGridView();
            jQuery("#btnSaveRole").hideLoading();
            HideModal('ModalUserRole');
            showStatusMsg( "1", "Role Saved Successfully.");
        }
    });
}

function SaveUpdateRole() {
    jQuery("#btnSaveRole").showLoading();
    var CompanyID = $("[Id$=ddlCompany] option:selected").val();
    var RoleID = $("[Id$=HDDRoleID]").val();
    var RoleName = $("[Id$=txtRoleName]").val();
    var Description = $("[Id$=Description]").val();
    var StatusID = $("[Id$=ddlStatus] option:selected").val();
    if (RoleID == "0") {
        SaveRole(parseInt(CompanyID), RoleName, Description, StringToBoolean(StatusID));
    }
    else {
        UpdateRole(parseInt(CompanyID), parseInt(RoleID), RoleName, Description, StringToBoolean(StatusID));
    }
    jQuery("#btnSaveRole").hideLoading();
}

function RolePermission(RoleID, RoleName) {
    $.ajax({
        type: "POST",
        url: "UserRole.aspx/RolePermission",
        data: "{RoleID: " + RoleID + ",RoleName: '" + RoleName + "'}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        error: function (result) {
            alert("Error" + result.d);
        },
        success: function (result) {
            window.location = result.d;
        }
    });
}

function RoleDeleteConfirmation(RoleID) {
  
        $.ajax({
            type: "POST",
            url: "UserRole.aspx/ChildRecordExistsByRole",
            data: "{RoleID: " + RoleID + "}",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (result) {
                alert("Error" + result.d);
            },
            success: function (result) {
                if (Boolean(result.d) == true) {
                    showStatusMsg( "3", "Role Use in Users.");
                }
                else {
                    DeleteRole(RoleID);
                }
            }
        });
        return true;
   
}

$(".GridWrapper").height(screen.height - (screen.height / 100) * 42.5);

