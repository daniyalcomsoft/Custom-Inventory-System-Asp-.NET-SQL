using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using SQLHelper;
using System.Web.UI;
using System.Globalization;
using System.Text;
using System.Data.SqlClient;

/// <summary>
/// Summary description for PublicMethods
/// </summary>
public class PM
{
    public enum ModuleName { GeneralLedger = 1, Sales, Purchase, Inventory, m, Security, TermDeposite, Client }
    public enum VoucherType { General_Voucher = 1, Cash_Payment_Voucher, Cash_Recievalbe_Voucher, Bank_Payment_Voucher, Bank_Recievable_Voucher }
    public enum FormAction { Save = 1, Approve, Lock, Unlock, Cancel };
    public enum UserAction { Insert = 1, Update, Delete, Lock, Unlock, Cancel };
    public enum TransactionMode { Select_One = 0, Cheque = 1, Cash, Other };
    public enum TransactionType { Deposit = 1, Profit = 2, Withdrawl = 3 };

    public static void Bind_GridView(GridView GridViewName, DataTable DataSource)
    {
        GridViewName.DataSource = DataSource;
        GridViewName.DataBind();
    }

    public static DataTable getFinancialYearByID(int FinYearID)
    {
        SqlParameter param = new SqlParameter("@FinYearID", FinYearID);
        DataTable dt = SqlHelper.ExecuteDataset(ConnectionString.PSMS, "SP_GetFinYear", param).Tables[0];
        return dt;
    }
    public static void BindDataGrid(GridView Grid, DataTable dt)
    {
        Grid.DataSource = dt;
        Grid.DataBind();
    }

    public static void BindDropDown(DropDownList cmb, Enum EnumName)
    {
        List<int> NatureKey = Enum.GetValues(EnumName.GetType()).Cast<int>().ToList();
        List<string> NatureValue = Enum.GetNames(EnumName.GetType()).Cast<string>().ToList();
        DataTable dt = new DataTable();
        dt.Columns.Add("Value", typeof(int));
        dt.Columns.Add("Text", typeof(string));
        for (int i = 0; i < NatureKey.Count; i++)
        {
            int Key = NatureKey[i];
            string Value = NatureValue[i];
            Value = Value.Replace("Select_One", "- Select One -");
            Value = Value.Replace("_", " ");
            dt.Rows.Add(Key, Value);
        }
        cmb.DataSource = dt;
        cmb.DataValueField = "Value";
        cmb.DataTextField = "Text";
        cmb.DataBind();
    }

    public static void BindaDropDown(DropDownList cmb, DataTable dt, string ValueMember, string TextMember)
    {
        cmb.DataSource = dt;
        cmb.DataValueField = ValueMember;
        cmb.DataTextField = TextMember;
        cmb.DataBind();
    }


    public static string GetMsgListFromMsgTable(DataTable dt)
    {
        StringBuilder str = new StringBuilder();
        str.Append("<ul class='successmsg'>" + Environment.NewLine);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (dt.Rows[i]["MsgType"].ToString() == "1")
            {
                str.Append("<li><div class='succmsg succmsg-ok'><p>" + dt.Rows[i]["Msg"] + "</p></div></li>" + Environment.NewLine);
            }
            else if (dt.Rows[i]["MsgType"].ToString() == "2")
            {
                str.Append("<li><div class='succmsg succmsg-error'><p>" + dt.Rows[i]["Msg"] + "</p></div></li>" + Environment.NewLine);
            }
            else if (dt.Rows[i]["MsgType"].ToString() == "3")
            {
                str.Append("<li><div class='succmsg succmsg-warn'><p>" + dt.Rows[i]["Msg"] + "</p></div></li>" + Environment.NewLine);
            }
        }
        str.Append("</ul>");
        return str.ToString();
    }

    public static void Bind_DropDown(DropDownList ComboboxName, string SpName, string DataTextField, string DataValueField)
    {
        DataTable dt = new DataTable();
        dt = SqlHelper.ExecuteDataset(ConnectionString.PSMS, SpName).Tables[0];
        ComboboxName.DataTextField = DataTextField;
        ComboboxName.DataValueField = DataValueField;
        DataRow row = dt.NewRow();
        row[DataTextField] = "--Please Select---";
        row[DataValueField] = 0;
        dt.Rows.InsertAt(row, 0);
        ComboboxName.DataSource = dt;
        ComboboxName.DataBind();
        ComboboxName.SelectedIndex = 0;
    }

    public static void Bind_DropDown(DropDownList ComboboxName, DataTable DataSource, string DataTextField, string DataValueField)
    {
        DataTable dt = new DataTable();
        dt = DataSource;
        ComboboxName.DataTextField = DataTextField;
        ComboboxName.DataValueField = DataValueField;
        DataRow row = dt.NewRow();
        row[DataTextField] = "--Please Select---";
        row[DataValueField] = 0;
        dt.Rows.InsertAt(row, 0);
        ComboboxName.DataSource = dt;
        ComboboxName.DataBind();
        ComboboxName.SelectedIndex = 0;
    }
    public static void Bind_DropDownAll(DropDownList ComboboxName, DataTable DataSource, string DataTextField, string DataValueField)
    {
        DataTable dt = new DataTable();
        dt = DataSource;
        ComboboxName.DataTextField = DataTextField;
        ComboboxName.DataValueField = DataValueField;
        DataRow row = dt.NewRow();
        row[DataTextField] = "All";
        row[DataValueField] = 0;
        dt.Rows.InsertAt(row, 0);
        ComboboxName.DataSource = dt;
        ComboboxName.DataBind();
        ComboboxName.SelectedIndex = 0;
    }
    public static void Bind_DropDown1(DropDownList ComboboxName, DataTable DataSource, string DataTextField, string DataValueField)
    {
        DataTable dt = new DataTable();
        dt = DataSource;
        ComboboxName.DataTextField = DataTextField;
        ComboboxName.DataValueField = DataValueField;       
        ComboboxName.DataSource = dt;
        ComboboxName.DataBind();
        ComboboxName.SelectedIndex = 0;
    }
    public static void Bind_DropDown(DropDownList ComboboxName, DataTable DataSource)
    {
        DataTable dt = new DataTable();
        dt = DataSource;
        ComboboxName.DataValueField = dt.Columns[0].ColumnName;
        ComboboxName.DataTextField = dt.Columns[1].ColumnName;
        DataRow row = dt.NewRow();
        row[dt.Columns[1].ColumnName] = "--Please Select--";
        row[dt.Columns[0].ColumnName] = 0;
        dt.Rows.InsertAt(row, 0);
        ComboboxName.DataSource = dt;
        ComboboxName.DataBind();
        ComboboxName.SelectedIndex = 0;
    }
    public static void ToastMsg(Page page, string MsgType, string Msg, string Position)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), Guid.NewGuid().ToString(), "ToastMsg('" + MsgType + "','" + Msg + "','" + Position + "');", true);
    }

    public static bool CheckInt(object value)
    {
        int parseVal;
        return ((value == null) || (value == DBNull.Value)) ? false : int.TryParse(value.ToString(), out parseVal) ? true : false;
    }
    public static bool Checklong(object value)
    {
        long parseVal;
        return ((value == null) || (value == DBNull.Value)) ? false : long.TryParse(value.ToString(), out parseVal) ? true : false;
    }
    public static bool CheckDouble(object value)
    {
        double parseVal;
        return ((value == null) || (value == DBNull.Value)) ? false : double.TryParse(value.ToString(), out parseVal) ? true : false;
    }

    public static bool Checkdecimal(object value)
    {
        decimal parseVal;
        return ((value == null) || (value == DBNull.Value)) ? false : decimal.TryParse(value.ToString(), out parseVal) ? true : false;
    }

    public static bool CheckDateTime(object value)
    {
        DateTime parseVal;
        return ((value == null) || (value == DBNull.Value)) ? false : DateTime.TryParseExact(value.ToString(),"MM/dd/yyyy",CultureInfo.InvariantCulture,
            DateTimeStyles.None, out parseVal) ? true : false;
    }
}