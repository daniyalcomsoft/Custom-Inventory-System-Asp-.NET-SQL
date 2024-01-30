var validate;

(function ($) {

    validate = function (group) {
        var marker = true;
        $("*[ValidateName=" + group + "]").each(function (i, elm) {
            if (ValidateType(elm)) {
                marker = $(elm).highlight();
                if (marker) {
                    $(elm).find(":input").andSelf().focus();
                    $(elm).find("select").andSelf().focus();
                    marker = false;
                }
            }
            else {
                marker = $(elm).unhighlight();
            }
        });
        return marker;
    }

    function revalidate() {
        if (!ValidateType(this)) {
            $(this).unhighlight();
        }
        else {
            $(this).highlight();
        }
    }

    $.fn.highlight = function () {
        var jelm = $(this);
        jelm.parent().find('span').remove();
        jelm.after('<span class="Error" aria-hidden="true"></span>');
        this.css('border-color', '#a94442').focus(showAlert).blur(hideAlert).change(revalidate); return this;
    }

    $.fn.unhighlight = function () {
       
        var jelm = $(this);
        var Type = $(jelm).attr('ValidateType');
        if (Type != undefined) {
            jelm.parent().find('span').remove();
           // jelm.after('<span class="Success" aria-hidden="true"></span>');
            this.css('border-color', '#e0e0e0').unbind("focus", showAlert).unbind("blur", hideAlert).change(revalidate);
           //this.css('border-color', '#43a047').unbind("focus", showAlert).unbind("blur", hideAlert).change(revalidate); 
            return this;
        }
        else {
            return false;
        }
    }

    function showAlert() {
        var jelm = $(this);
        jelm.parent().find('span').remove();
        jelm.after('<span class="Error" aria-hidden="true"></span>');
        jelm.css('border-color', '#a94442');
    }

    function hideAlert() {
        var jelm = $(this);
        var Type = $(jelm).attr('ValidateType');
        switch (Type) {
            case 'TextBox':
                if ($.trim(jelm.val()) != "" && $.trim(jelm.val()) != null) {
                    jelm.parent().find('span').remove();
                    jelm.css('border-color', '#e0e0e0');
                }
                break;
            case 'DropDownList':
                if ($.trim(jelm.val()) != "" && $.trim(jelm.val()) != null) {
                    if (jelm.prop('selectedIndex') != 0) {
                        jelm.parent().find('span').remove();
                        jelm.css('border-color', '#e0e0e0');
                    }
                }
                break;
        }

    }

    function ValidateType(elm) {
        var valid = false;
        var jelm = $(elm);
        var Type = $(elm).attr('ValidateType');
        if (Type != undefined) {
            var listsize = jelm.find("input:radio, input:checkbox").size();
            if (jelm.attr("disabled") || jelm.attr("readonly") || listsize > 0 && listsize == jelm.find("input:radio:disabled, input:checkbox:disabled").size())
                return valid;
            switch (Type) {
                case 'TextBox':
                    if (($.trim(jelm.val()) == "" || $.trim(jelm.val()) == null) && jelm.find("input:radio:checked, input:checkbox:checked").size() == 0)
                        valid = true;
                    break;
                case 'DropDownList':
                    if (($.trim(jelm.val()) == "" || $.trim(jelm.val()) == null || $.trim(jelm.val()) == "0") && jelm.find("input:radio:checked, input:checkbox:checked").size() == 0)
                        valid = true;
                    if (jelm.prop('selectedIndex') == 0) {
                        valid = true;
                    }
                    break;
            }
        }
        else {
            return false;
        }

        return valid;
    }
})(jQuery);

function clearvalidate(group) {
    $("*[ValidateName=" + group + "]").each(function (i, elm) {
        var jelm = $(this);
        jelm.parent().find('span').remove();
        jelm.css('border-color', '#e0e0e0');
    });
}
