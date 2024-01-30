function ShowDialog(id) {
    $('#' + id).dialog("open");
    return false;
}

function CloseDialog(id) {
    $('#' + id).dialog("close");
    return false;
}

function ShowModal(id) {
    $('#' + id).modal('show');
    return false;
}

function HideModal(id) {
    $('#' + id).modal("hide");
    return false;
}


function Clear_form_elements(ele) {
    $('#' + ele).find(':input').each(function () {
        if (this.type == 'text' || this.type == 'textarea') {
            this.value = '';
        }
        else if (this.type == 'radio' || this.type == 'checkbox') {
            this.checked = false;
        }
        else if (this.type == 'select-one' || this.type == 'select-multiple') {
            $('#' + this.id).prop('selectedIndex', 0);
        }
    });
}

function ValidateNumber(evet) {
    var charCode = (evet.which) ? evet.which : event.keyCode
    if (charCode != 9) {
        if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
    }
    return true;
}

function RedirectAfterDelayFn(RedirectPage) {
    var seconds = 1;
    setInterval(function () {
        seconds--;
        if (seconds == 0) {
            window.location = RedirectPage;
        }
    }, 500);
}

function NoRecordExists(GridID, Colspan, Message) {
    if ($("[Id$=" + GridID + "] td").length == 0) {
        $("[Id$=" + GridID + "] tbody").append("<tr><td colspan = '" + Colspan + "' align = 'center' style='font-size: 24px;'>" + Message + "</td></tr>")
    }
    else {
        $("[Id$=" + GridID + "] tbody").append("<tr><td colspan = '" + Colspan + "' align = 'center' style='font-size: 24px;'>" + Message + "</td></tr>")
    }
}

function StringToBoolean(string) {
    switch (string.toLowerCase().trim()) {
        case "true": case "yes": case "1": return true;
        case "false": case "no": case "0": case null: return false;
        default: return Boolean(string);
    }
}

function BooleanToInt(Int) {
    if (Int == true) {
        return 1;
    }
    else {
        return 0;
    }
}

function SearchGridData(GridID, Value, Colspan) {
    var RecordNotFound = false;
    var table = $("[Id$=" + GridID + "]");

    table.find('tr').each(function (index, row) {
        var allCells = $(row).find('td');

        if (allCells.length > 0) {
            var found = false;
            allCells.each(function (index, td) {
                var regExp = new RegExp(Value, 'i');
                if (regExp.test($(td).text())) {
                    found = true;
                    return false;
                }
            });

            if (found == true) {
                $(row).show();
                RecordNotFound = true;
            } else {
                $(row).hide();
            }
        }
    });

    if (RecordNotFound == false) {
        if ($("[Id$=" + GridID + "] tr > td:last").html() == "Record Not Found") {
            $("[Id$=" + GridID + "] tr > td:last").hide();
        }
        NoRecordExists(GridID, Colspan, 'Record Not Found');
    }
}

function ClearRecordNotFound(GridID, InputID) {
    $("[Id$=" + InputID + "]").val("");
    if ($("[Id$=" + GridID + "] tr > td:last").html() == "Record Not Found") {
        $("[Id$=" + GridID + "] tr > td:last").hide();
    }
    $("[Id$=" + GridID + "] tr").show();
}

function StatusConvertToString(Status) {
    if (Status == true) {
        return "Active";
    }
    else {
        return "Deactive";
    }
}

function DateTimePicker() {

    $('.datetimepicker').datepicker();
}
function showStatusMsg(MsgType, Msg) {
    if (MsgType == "1") {
        $("#StausMsg").removeClass().addClass("alert alert-success");

        $("#StausMsg").html("<p><b>Success!</b> " + Msg + "</p>");
    }
    else if (MsgType == "2") {
        $("#StausMsg").removeClass().addClass("alert alert-danger");
        $("#StausMsg").html("<p><b>Error!</b> " + Msg + "</p>");
    }
    else if (MsgType == "3") {
        $("#StausMsg").removeClass().addClass("alert alert-warning");
        $("#StausMsg").html("<p><b>Warning!</b> " + Msg + "</p>");
    }
    else if (MsgType == "4") {
        $("#StausMsg").removeClass().addClass("alert alert-info");
        $("#StausMsg").html("<p><b>Info!</b> " + Msg + "</p>");
    }
    $("#StausMsg").show("fade");
    setTimeout("hideStatusMsg()", 3000);
}
function hideStatusMsg() {
    $("#StausMsg").hide('fade');
}
function disabledModal(ModalName) {
    $("#" + ModalName + "").find('input,select,textarea').prop("disabled",true);
}
function enabledModal(ModalName) {
    $("#" + ModalName + "").find('input,select,textarea').prop("disabled", false);
}

function showhidecontrol(ControlID, Show) {
   
    if (Show == "False")
        $("[id$=" + ControlID + "]").hide();
    else
    $("[id$=" + ControlID + "]").show();
       
}

function CreateModalPopUp(divID, widthModal, heightModal, titleModal) {
    $(divID).dialog({
        autoOpen: false,
        draggable: true,
        modal: true,
        resizable: false,
        title: titleModal,
        width: widthModal,
        height: heightModal,
        open: function (type, data) {
            $(this).parent().appendTo("form");
        }
    });
}