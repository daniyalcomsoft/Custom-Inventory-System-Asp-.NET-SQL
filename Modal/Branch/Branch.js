function AddNewBranch() {
    clearvalidate('Modal');
    $("[Id$=HDDBranchID]").val("0");
    jQuery("#btnAddBranch").showLoading();
    Clear_form_elements('ModalUserBranch');
    ShowModal('ModalUserBranch');
    $("[Id$=txtBranchCode]").removeAttr("disabled");
    $("[Id$=txtBranchName]").removeAttr("disabled");
    $("[Id$=txtPhoneNumber]").removeAttr("disabled");
    $("[Id$=txtCity]").removeAttr("disabled");
    $("[Id$=txtState]").removeAttr("disabled");
    $("[Id$=txtZipCode]").removeAttr("disabled");
    $("[Id$=txtFaxNo]").removeAttr("disabled");
    $("[Id$=txtEmailAddress]").removeAttr("disabled");
    $("[Id$=txtAddress]").removeAttr("disabled");
    $("[Id$=ddlStatus]").removeAttr("disabled");
    $("[Id$=btnSaveBranch]").html('Save').show();
    jQuery("#btnAddBranch").hideLoading();
}

function BindGridView() {
    $.ajax({
        type: "POST",
        url: "Branch.aspx/GetData",
        contentType: "application/json;charset=utf-8",
        data: {},
        dataType: "json",
        success: function (data) {
            $("#GridBranch").empty();

            var Json = JSON.parse(data.d);
            if (Json.length > 0) {
                $("#GridBranch").append("<tr><th>Branch Code</th> <th>Branch Name</th> <th>Phone #</th> <th>Address</th>  <th>Status</th> <th>View</th> <th>Edit</th> <th>Delete</th> </tr>");
                for (var i = 0; i < Json.length; i++) {

                    var BranchID = Json[i].BranchID;
                    var BranchCode = Json[i].BranchCode;
                    var BranchName = Json[i].BranchName;
                    var PhoneNo = Json[i].PhoneNo;
                    var Address = Json[i].Address;
                    var Status = Json[i].Status;

                    $("#GridBranch").append("<tr><td>" +
                    BranchCode + "</td> <td>" +
                    BranchName + "</td> <td>" +
                    PhoneNo + "</td> <td>" +
                    Address + "</td> <td>" +
                    StatusConvertToString(Boolean(Status)) + "</td> <td> " +
                    "<button type='button' class='btn btn-primary' id='btnView' onclick=\"javascript:ViewBranch(" + BranchID + ",'View')\"><i class='icon fa-eye' aria-hidden='true'></i>View</button" +
                    "</td> <td> " +
                    "<button type='button' class='btn btn-primary' id='btnEdit' onclick='javascript:EditBranch(" + BranchID + ")'><i class='icon fa-edit' aria-hidden='true'></i>Edit</button" +
                    "</td> <td> " +
                    "<button type='button' class='btn btn-danger' id='btnDelete' onclick='javascript:BranchDeleteConfirmation(" + BranchID + ");'><i class='icon fa-trash-o' aria-hidden='true'></i>Delete</button" +
                    "</td></tr>");
                }
            }
        },
        error: function (data) {
            alert("Error" + data.d);
        }
    });
}

function ViewBranch(BranchID, Type) {
    $.ajax({
        type: "POST",
        url: "Branch.aspx/ViewBranch",
        contentType: "application/json;charset=utf-8",
        data: "{BranchID: " + BranchID + " }",
        dataType: "json",
        success: function (data) {
            var Json = JSON.parse(data.d);
            if (Json.length > 0) {
                for (var i = 0; i < Json.length; i++) {

                    var BranchID = Json[i].BranchID;
                    var BranchCode = Json[i].BranchCode;
                    var BranchName = Json[i].BranchName;
                    var PhoneNo = Json[i].PhoneNo;
                    var City = Json[i].City;
                    var State = Json[i].State;
                    var ZipCode = Json[i].ZipCode;
                    var FaxNo = Json[i].FaxNo;
                    var EmailAddress = Json[i].EmailAddress;
                    var Address = Json[i].Address;
                    var Status = Json[i].Status;

                    if (Type == 'View') {
                        $("[Id$=txtBranchCode]").val(BranchCode).attr("disabled", "disabled");
                        $("[Id$=txtBranchName]").val(BranchName).attr("disabled", "disabled");
                        $("[Id$=txtPhoneNumber]").val(PhoneNo).attr("disabled", "disabled");
                        $("[Id$=txtCity]").val(City).attr("disabled", "disabled");
                        $("[Id$=txtState]").val(State).attr("disabled", "disabled");
                        $("[Id$=txtZipCode]").val(ZipCode).attr("disabled", "disabled");
                        $("[Id$=txtFaxNo]").val(FaxNo).attr("disabled", "disabled");
                        $("[Id$=txtEmailAddress]").val(EmailAddress).attr("disabled", "disabled");
                        $("[Id$=txtAddress]").val(Address).attr("disabled", "disabled");
                        $("[Id$=ddlStatus]").val(BooleanToInt(Status)).attr("selected", "selected").attr("disabled", "disabled");
                        $("[Id$=btnSaveBranch]").hide();
                    }
                    else {
                        $("[Id$=txtBranchCode]").val(BranchCode).removeAttr("disabled");
                        $("[Id$=txtBranchName]").val(BranchName).removeAttr("disabled");
                        $("[Id$=txtPhoneNumber]").val(PhoneNo).removeAttr("disabled");
                        $("[Id$=txtCity]").val(City).removeAttr("disabled");
                        $("[Id$=txtState]").val(State).removeAttr("disabled");
                        $("[Id$=txtZipCode]").val(ZipCode).removeAttr("disabled");
                        $("[Id$=txtFaxNo]").val(FaxNo).removeAttr("disabled");
                        $("[Id$=txtEmailAddress]").val(EmailAddress).removeAttr("disabled");
                        $("[Id$=txtAddress]").val(Address).removeAttr("disabled");
                        $("[Id$=ddlStatus]").val(BooleanToInt(Status)).attr("selected", "selected").removeAttr("disabled");
                    }

                }
                clearvalidate('Modal');
                ShowModal('ModalUserBranch');
            }
        },
        error: function (data) {
            alert("Error" + data.d);
        }
    });
}

function EditBranch(BranchID) {
    $("[Id$=HDDBranchID]").val(BranchID);
    $("[Id$=btnSaveBranch]").html('Update').show();
    ViewBranch(BranchID);
}

function DeleteBranch(BranchID) {
    $.ajax({
        type: "POST",
        url: "Branch.aspx/DeleteBranch",
        contentType: "application/json;charset=utf-8",
        data: "{BranchID: " + BranchID + " }",
        dataType: "json",
        success: function (data) {
            BindGridView();
            ToastMsg('1', "Branch Delete Successfully", 'bottom-right');
        },
        error: function (data) {
            ToastMsg('1', data.d, 'bottom-right');
        }
    });
}

function BranchDeleteConfirmation(BranchID) {
    if (confirm("Are you sure you want to delete this branch?")) {
        $.ajax({
            type: "POST",
            url: "Branch.aspx/ChildRecordExistsByBranch",
            data: "{BranchID: " + BranchID + "}",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (result) {
                alert("Error" + result.d);
            },
            success: function (result) {
                if (Boolean(result.d) == true) {
                    ToastMsg('2', "Child Record Exists", 'bottom-right');
                }
                else {
                    DeleteBranch(BranchID);
                }
            }
        });
        return true;
    }
    else
        return false;
}

function SaveUpdateBranch() {
    jQuery("#btnAddBranch").showLoading();
    var BranchID = $("[Id$=HDDBranchID]").val();
    var BranchCode = $("[Id$=txtBranchCode]").val();
    var BranchName = $("[Id$=txtBranchName]").val();
    var PhoneNo = $("[Id$=txtPhoneNumber]").val();
    var City = $("[Id$=txtCity]").val();
    var State = $("[Id$=txtState]").val();
    var ZipCode = $("[Id$=txtZipCode]").val();
    var FaxNo = $("[Id$=txtFaxNo]").val();
    var EmailAddress = $("[Id$=txtEmailAddress]").val();
    var Address = $("[Id$=txtAddress]").val();
    var StatusID = $("[Id$=ddlStatus] option:selected").val();
    if (BranchID == "0") {
        SaveBranch(BranchCode, BranchName, PhoneNo, City, State, ZipCode, FaxNo, EmailAddress, Address, StringToBoolean(StatusID));
    }
    else {
        UpdateBranch(parseInt(BranchID), BranchCode, BranchName, PhoneNo, City, State, ZipCode, FaxNo, EmailAddress, Address, StringToBoolean(StatusID));
    }
    jQuery("#btnAddBranch").hideLoading();
}

function SaveBranch(BranchCode, BranchName, PhoneNo, City, State, ZipCode, FaxNo, EmailAddress, Address, Status) {
    var dataValue = "{ BranchCode: " + BranchCode + ", BranchName: '" + BranchName + "', PhoneNo: '" + PhoneNo + "', City: '" + City + "', State: '" + State + "', ZipCode: '" + ZipCode + "', FaxNo: '" + FaxNo + "', EmailAddress: '" + EmailAddress + "', Address: '" + Address + "', Status: " + Status + "}";
    $.ajax({
        type: "POST",
        url: "Branch.aspx/SaveBranch",
        data: dataValue,
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        error: function (result) {
            jQuery("#btnSaveBranch").hideLoading();
            ToastMsg('3', result.d, 'bottom-right');
        },
        success: function (result) {
            BindGridView();
            jQuery("#btnSaveBranch").hideLoading();
            HideModal('ModalUserBranch');
            ToastMsg('1', 'Branch Saved Successfully', 'bottom-right');
        }
    });
}

$(".GridWrapper").height(screen.height - (screen.height / 100) * 42.5);
$(window).resize(function () {
    $(".GridWrapper").slimscroll({
        height: 'auto'
    })
    $(".GridWrapper").height(screen.height - (screen.height / 100) * 42.5);
    $(".slimScrollDiv").height(screen.height - (screen.height / 100) * 42.5);
    //$("table table table:first", "#GridUserRole").find("th").each(function (i, elem) {
    //    $("table table table:eq(1)", "#GridUserRole").find("tr:first td:eq(" + i + ")").css("width", ($(elem).width() + 16) + "px");
    //});
});
