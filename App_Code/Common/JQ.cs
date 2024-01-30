using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

/// <summary>
/// Summary description for JQ
/// </summary>
public class JQ
{
    public JQ()
    {
        
    }
    public static void ShowDialog(Page page, string DivID)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), Guid.NewGuid().ToString(), "ShowDialog('" + DivID + "');", true);
    }
    public static void CloseDialog(Page page, string DivID)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), Guid.NewGuid().ToString(), "CloseDialog('" + DivID + "');", true);
    }
    public static void ShowModal(Page page, string DivID)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), Guid.NewGuid().ToString(), "ShowModal('" + DivID + "');", true);
    }
    public static void CloseModal(Page page, string DivID)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), Guid.NewGuid().ToString(), "HideModal('" + DivID + "');", true);
    }
    public static void RecallJS(Page page,string FunctionName)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), Guid.NewGuid().ToString(),FunctionName, true);
    }
    public static void ShowStatusMsg(Page page,string MsgType, string Msg)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), Guid.NewGuid().ToString(), "showStatusMsg('" + MsgType + "','" + Msg + "');", true);
    }
    public static void DatePicker(Page page)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), Guid.NewGuid().ToString(), "DateTimePicker();", true);
    }

    public static void YearPicker(Page page)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), Guid.NewGuid().ToString(), "YearPicker();", true);
    }
    public static void ShowStatusMsgPopup(Page page, string MsgType, string Msg)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), Guid.NewGuid().ToString(), "showStatusMsgPopup('" + MsgType + "','" + Msg + "');", true);
    }

    public static void ShowStatusMsgPopupFind(Page page, string MsgType, string Msg)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), Guid.NewGuid().ToString(), "showStatusMsgPopupFind('" + MsgType + "','" + Msg + "');", true);
    }

    public static void ShowStatusMsgFreeze(Page page, string MsgType, string Msg)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), Guid.NewGuid().ToString(), "showStatusMsgFreeze('" + MsgType + "','" + Msg + "');", true);
    }

    public static void ToastMsg(Page page, string MsgType, string Msg, string Position)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), Guid.NewGuid().ToString(), "ToastMsg('" + MsgType + "','" + Msg + "','" + Position + "');", true);
    }

    public static void disabledControl(Page page, string DivID)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), Guid.NewGuid().ToString(), "disabledModal('" + DivID + "');", true);
    }
    public static void ShowHideControl(Page page, string ControlID,bool Show)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), Guid.NewGuid().ToString(), "showhidecontrol('" + ControlID + "','" + Show + "');", true);
    }
    public static void ValidateIniti(Page page, string ControlID)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), Guid.NewGuid().ToString(), "validate('" + ControlID + "');", true);
    }
    public static void showStatusMsg(Page page, string MsgType, string Msg)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), Guid.NewGuid().ToString(), "showStatusMsg('" + MsgType + "','" + Msg + "');", true);
    }
}
