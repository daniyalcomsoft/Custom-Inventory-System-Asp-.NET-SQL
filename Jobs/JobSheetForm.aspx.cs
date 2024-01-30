﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SW.SW_Common;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.HtmlControls;
using System.Threading;
using SCGL.BAL;

public partial class Jobs_JobSheetForm : System.Web.UI.Page
{
    //Invoice_BAL_Temp BALInvoice = new Invoice_BAL_Temp();
    JobSheet_BAL BALInvoice = new JobSheet_BAL();
    //decimal CurrentInventory = 0;
    int InventoryID = 0;
    int CostCenterID = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["PSMSSession"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }

        if (!IsPostBack)
        {
            RolePermission_BLL PP = new RolePermission_BLL();
            DataTable dtRole = new DataTable();
            Sessions PSMSSession = (Sessions)Session["PSMSSession"];
            dtRole = PP.GetPagePermissionpPagesByRole(PSMSSession.RoleID);
            string pageName = null;
            bool view = false;
            foreach (DataRow dr in dtRole.Rows)
            {
                int row = dtRole.Rows.IndexOf(dr);
                if (dtRole.Rows[row]["PageUrl"].ToString() == "Jobs/JobSheetForm.aspx")
                {
                    pageName = dtRole.Rows[row]["PageUrl"].ToString();
                    view = Convert.ToBoolean(dtRole.Rows[row]["Can_View"].ToString());
                    break;
                }
            }
            if (dtRole.Rows.Count > 0)
            {
                if (pageName == "Jobs/JobSheetForm.aspx" && view == true)
                {

                    Bind_JobNo();
                    if (Request.QueryString["Id"] != null)
                    {
                        Gv_GetRows1();
                        SetInitialRow_For_Edit();
                        BindControl(Convert.ToInt32(Request.QueryString["Id"]));

                    }

                    else
                    {
                        SetInitialRow();
                    }
                }
                else
                {
                    Response.Redirect("Default.aspx", false);
                }
            }

        }
        Reload_JS();
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        DataTable dt = PM.getFinancialYearByID(PSMS.FinYearID);
        hdnMinDate.Value = SCGL_Common.CheckDateTime(dt.Rows[0]["yearFrom"]).ToShortDateString();
        hdnMaxDate.Value = SCGL_Common.CheckDateTime(dt.Rows[0]["YearTo"]).ToShortDateString();

    }

    //public void Bind_Product_Dropdown()
    //{
    //    for (int i = 0; i < GV_CommercialInvoiceDetail.Rows.Count; i++)
    //    {
    //        DropDownList ddlProduct = GV_CommercialInvoiceDetail.Rows[i].FindControl("ddlInventory") as DropDownList;
    //        if (Request.QueryString["ID"] != null)
    //        {
                
    //            DataTable dtInvoiceDetail = BALInvoice.getInvoiceDetail(SCGL_Common.Convert_ToInt(Request.QueryString["ID"]));
                
    //            InventoryID = SCGL_Common.Convert_ToInt(dtInvoiceDetail.Rows[0]["InventoryID"].ToString());
    //        }
    //        SCGL_Common.Bind_DropDown(ddlProduct, "vt_SCGL_Sp_GetInventory", "InventoryName", "InventoryID");
    //    }

    //}

    public void Bind_PaymentThrough_Dropdown()
    {
        for (int i = 0; i < GV_CommercialInvoiceDetail.Rows.Count; i++)
        {
            DropDownList ddlPaymentThrough = GV_CommercialInvoiceDetail.Rows[i].FindControl("ddlPaymentThrough") as DropDownList;
            if (Request.QueryString["ID"] != null)
            {

                DataTable dtInvoiceDetail = BALInvoice.getJobSheetDetail(SCGL_Common.Convert_ToInt(Request.QueryString["ID"]));

                InventoryID = SCGL_Common.Convert_ToInt(dtInvoiceDetail.Rows[0]["PaymentThrough"].ToString());
            }
            PM.Bind_DropDown(ddlPaymentThrough, "SP_BindDepositAccount", "Title", "Code");
        }

    }

    public void Bind_Expense_Dropdown()
    {
        for (int i = 0; i < GV_CommercialInvoiceDetail.Rows.Count; i++)
        {
            DropDownList ddlExpense = GV_CommercialInvoiceDetail.Rows[i].FindControl("ddlExpense") as DropDownList;
            if (Request.QueryString["ID"] != null)
            {

                DataTable dtInvoiceDetail = BALInvoice.getJobSheetDetail(SCGL_Common.Convert_ToInt(Request.QueryString["ID"]));

                InventoryID = SCGL_Common.Convert_ToInt(dtInvoiceDetail.Rows[0]["ExpenseAcc"].ToString());
            }
            PM.Bind_DropDown(ddlExpense, "SP_BindExpenseAccount", "Title", "Code");
        }

    }

    //public void Bind_CostCenter_Dropdown()
    //{
    //    for (int i = 0; i < GV_CommercialInvoiceDetail.Rows.Count; i++)
    //    {
    //        DropDownList ddlCostCenter = GV_CommercialInvoiceDetail.Rows[i].FindControl("ddlCostCenter") as DropDownList;
    //        if (Request.QueryString["ID"] != null)
    //        {
              
    //            DataTable dtInvoiceDetail = BALInvoice.getInvoiceDetail(SCGL_Common.Convert_ToInt(Request.QueryString["ID"]));
            

    //            CostCenterID = SCGL_Common.Convert_ToInt(dtInvoiceDetail.Rows[0]["CostCenterID"].ToString());
    //        }
    //        SCGL_Common.Bind_DropDown(ddlCostCenter, "vt_SCGL_Sp_GetCostCenter", "CostCenter", "CostCenterID");
    //    }

    //}

    public void BindControl(int Id)
    {
        if (Request.QueryString["view"] != null)
        {
            btnSave.Visible = false;
            btnAddLines.Visible = btnClearAllLines.Visible = false;

        }
        Invoice_BAL_Temp invoiceBal = new Invoice_BAL_Temp();
        JobSheet_BAL BALinvoice = new JobSheet_BAL();
        DataTable dt = BALinvoice.getjobSheet(Id);
        if (dt.Rows.Count > 0)
        {
            ddlJobNo.SelectedValue = dt.Rows[0]["JobNo"].ToString();
            txtCustomer.Text = dt.Rows[0]["DisplayName"].ToString();
            hdnCustomerID.Value = dt.Rows[0]["CustomerID"].ToString();
            txtDescription2.Text = dt.Rows[0]["Description"].ToString();
            txtOtherDetails.Text = dt.Rows[0]["OtherDetails"].ToString();
            txttotal2.Value = dt.Rows[0]["Total"].ToString();
            
            btnSave.Text = "Update";
        }
        DataTable dtInvoiceDetail = BALInvoice.getJobSheetDetail(Id);

        for (int i = 0; i < dtInvoiceDetail.Rows.Count; i++)
        {

            TextBox txtDate = (TextBox)GV_CommercialInvoiceDetail.Rows[i].Cells[1].FindControl("txtDate");
            DropDownList ddlPaymentType = (DropDownList)GV_CommercialInvoiceDetail.Rows[i].Cells[2].FindControl("ddlPaymentType");
            DropDownList ddlInfoType = (DropDownList)GV_CommercialInvoiceDetail.Rows[i].Cells[3].FindControl("ddlInfoType");
            TextBox txtPONo = (TextBox)GV_CommercialInvoiceDetail.Rows[i].Cells[4].FindControl("txtPONo");
            DropDownList ddlExpense = (DropDownList)GV_CommercialInvoiceDetail.Rows[i].Cells[5].FindControl("ddlExpense");
            DropDownList ddlPaymentThrough = (DropDownList)GV_CommercialInvoiceDetail.Rows[i].Cells[6].FindControl("ddlPaymentThrough");
            TextBox txtDescription = (TextBox)GV_CommercialInvoiceDetail.Rows[i].Cells[7].FindControl("txtDescription");
            HtmlInputText txtAmount = GV_CommercialInvoiceDetail.Rows[i].Cells[8].FindControl("txtAmount") as HtmlInputText;

            txtDate.Text = SCGL_Common.CheckDateTime(dtInvoiceDetail.Rows[i]["Date"]).ToShortDateString();
            ddlPaymentType.SelectedValue = dtInvoiceDetail.Rows[i]["PaymentType"].ToString();
            ddlInfoType.SelectedValue = dtInvoiceDetail.Rows[i]["InfoType"].ToString();
          
            if (ddlPaymentType.SelectedValue == "1")
            {
                txtPONo.Enabled = true;
                txtPONo.Text = dtInvoiceDetail.Rows[i]["PONo"].ToString();
                ddlExpense.Enabled = false;
                ddlExpense.SelectedIndex = 0;
            }
            else if (ddlPaymentType.SelectedValue == "2")
            {
                txtPONo.Enabled = false;
                txtPONo.Text = "";
                ddlExpense.Enabled = true;
                ddlExpense.SelectedValue = dtInvoiceDetail.Rows[i]["ExpenseAcc"].ToString();
            }
            else 
            {
                txtPONo.Enabled = true;
                ddlExpense.Enabled = true;
            }
            //txtPONo.Text = dtInvoiceDetail.Rows[i]["PONo"].ToString();
            //ddlExpense.SelectedValue = dtInvoiceDetail.Rows[i]["ExpenseAcc"].ToString();
            ddlPaymentThrough.SelectedValue = dtInvoiceDetail.Rows[i]["PaymentThrough"].ToString();
            txtDescription.Text = dtInvoiceDetail.Rows[i]["Description"].ToString();
            txtAmount.Value = dtInvoiceDetail.Rows[i]["Amount"].ToString();
       
            btnSave.Text = "Update";
        }
    }

    public void Bind_JobNo()
    {
        PM.Bind_DropDown(ddlJobNo, "SP_BindJobNumber", "JobNumber", "ID");
    }




    public void Reload_JS()
    {
        SCGL_Common.ReloadJS(this, "MyDate();");
        //SCGL_Common.ReloadJS(this, "calculateSum();");
        //SCGL_Common.ReloadJS(this, "vale();");
        SCGL_Common.ReloadJS(this, "GrossTotalDeduction();");
        //SCGL_Common.ReloadJS(this, "TxtBlur();");
        SCGL_Common.ReloadJS(this, "TotalGridAmount();");
        //SCGL_Common.ReloadJS(this, "ChangeConversionRate();");

    }

    public void Gv_GetRows1()
    {
        SqlDataReader dr = BALInvoice.Get_Rows_JobSheetDetail_byID(SCGL_Common.Convert_ToInt(Request.QueryString["ID"]));
        while (dr.Read())
        {
            Session["GV1"] = dr["RowNumber"].ToString();
        }
    }

    private void SetInitialRow_For_Edit()
    {
        DataTable dt = new DataTable();
        DataRow dr = null;
        dt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
        dt.Columns.Add(new DataColumn("txtDate", typeof(string)));
        dt.Columns.Add(new DataColumn("ddlPaymentType", typeof(string)));
        dt.Columns.Add(new DataColumn("ddlPaymentType_value", typeof(string)));
        dt.Columns.Add(new DataColumn("ddlInfoType", typeof(string)));
        dt.Columns.Add(new DataColumn("ddlInfoType_value", typeof(string)));
        dt.Columns.Add(new DataColumn("txtPONo", typeof(string)));
        dt.Columns.Add(new DataColumn("ddlExpense", typeof(string)));
        dt.Columns.Add(new DataColumn("ddlExpense_value", typeof(string)));
        dt.Columns.Add(new DataColumn("ddlPaymentThrough", typeof(string)));
        dt.Columns.Add(new DataColumn("ddlPaymentThrough_value", typeof(string)));
        dt.Columns.Add(new DataColumn("txtDescription", typeof(string)));
        dt.Columns.Add(new DataColumn("txtAmount", typeof(string)));

        if (Convert.ToInt32(Session["GV1"]) < 1)
        {
            for (int i = 0; i < 1; i++)
            {
                dr = dt.NewRow();
                dt.Rows.Add(dr);
            }
        }
        else
        {
            for (int i = 0; i < Convert.ToInt32(Session["GV1"]); i++)
            {
                dr = dt.NewRow();
                dt.Rows.Add(dr);
            }
        }
        ViewState["CurrentTable"] = dt;
        GV_CommercialInvoiceDetail.DataSource = dt;
        GV_CommercialInvoiceDetail.DataBind();
        //Bind_Product_Dropdown();
        //Bind_CostCenter_Dropdown();
        Bind_PaymentThrough_Dropdown();
        Bind_Expense_Dropdown();
    }

    private void SetInitialRow()
    {

        DataTable dt = new DataTable();
        DataRow dr = null;
        dt.Columns.Add(new DataColumn("txtDate", typeof(string)));
        dt.Columns.Add(new DataColumn("ddlPaymentType", typeof(string)));
        dt.Columns.Add(new DataColumn("ddlPaymentType_value", typeof(string)));
        dt.Columns.Add(new DataColumn("ddlInfoType", typeof(string)));
        dt.Columns.Add(new DataColumn("ddlInfoType_value", typeof(string)));
        dt.Columns.Add(new DataColumn("txtPONo", typeof(string)));
        dt.Columns.Add(new DataColumn("ddlExpense", typeof(string)));
        dt.Columns.Add(new DataColumn("ddlExpense_value", typeof(string)));
        dt.Columns.Add(new DataColumn("ddlPaymentThrough", typeof(string)));
        dt.Columns.Add(new DataColumn("ddlPaymentThrough_value", typeof(string)));
        dt.Columns.Add(new DataColumn("txtDescription", typeof(string)));
        dt.Columns.Add(new DataColumn("txtAmount", typeof(string)));

        for (int i = 0; i < 1; i++)
        {
            dr = dt.NewRow();
            dt.Rows.Add(dr);
        }


        ViewState["CurrentTable"] = dt;



        GV_CommercialInvoiceDetail.DataSource = dt;
        GV_CommercialInvoiceDetail.DataBind();
        //Bind_Product_Dropdown();
        //Bind_CostCenter_Dropdown();
        Bind_PaymentThrough_Dropdown();
        Bind_Expense_Dropdown();
    }

    protected void btnAddLines_Click(object sender, EventArgs e)
    {
        AddNewRowToGrid();
        }

    public void AddNewRowToGrid()
    {
        try
        {
            Product_Table.Rows.Clear();
            for (int i = 0; i < GV_CommercialInvoiceDetail.Rows.Count; i++)
            {
                if (GV_CommercialInvoiceDetail.Rows[i].Visible)
                {
                    DataRow drCurrentRow = Product_Table.NewRow();

                    TextBox txtDate = (TextBox)GV_CommercialInvoiceDetail.Rows[i].Cells[1].FindControl("txtDate");
                    DropDownList ddlPaymentType = (DropDownList)GV_CommercialInvoiceDetail.Rows[i].Cells[2].FindControl("ddlPaymentType");
                    DropDownList ddlInfoType = (DropDownList)GV_CommercialInvoiceDetail.Rows[i].Cells[3].FindControl("ddlInfoType");
                    TextBox txtPONo = (TextBox)GV_CommercialInvoiceDetail.Rows[i].Cells[4].FindControl("txtPONo");
                    DropDownList ddlExpense = (DropDownList)GV_CommercialInvoiceDetail.Rows[i].Cells[5].FindControl("ddlExpense");
                    DropDownList ddlPaymentThrough = (DropDownList)GV_CommercialInvoiceDetail.Rows[i].Cells[6].FindControl("ddlPaymentThrough");
                    TextBox txtDescription = (TextBox)GV_CommercialInvoiceDetail.Rows[i].Cells[7].FindControl("txtDescription");
                    HtmlInputText txtAmount = GV_CommercialInvoiceDetail.Rows[i].Cells[8].FindControl("txtAmount") as HtmlInputText;

                    drCurrentRow["txtDate"] = txtDate.Text;
                    drCurrentRow["ddlPaymentType"] = ddlPaymentType.SelectedItem.Text;
                    drCurrentRow["ddlPaymentType_value"] = ddlPaymentType.SelectedValue;
                    drCurrentRow["ddlInfoType"] = ddlInfoType.SelectedItem.Text;
                    drCurrentRow["ddlInfoType_value"] = ddlInfoType.SelectedValue;
                    drCurrentRow["txtPONo"] = txtPONo.Text;
                    drCurrentRow["ddlExpense"] = ddlExpense.SelectedItem.Text;
                    drCurrentRow["ddlExpense_value"] = ddlExpense.SelectedValue;
                    //if (ddlPaymentType.SelectedValue == "1")
                    //{
                    //    txtPONo.Enabled = true;
                    //    //drCurrentRow["txtPONo"] = txtPONo.Text;
                    //    ddlExpense.Enabled = false;
                    //    //drCurrentRow["ddlExpense_value"] = 0;
                    //}
                    //else if (ddlPaymentType.SelectedValue == "2")
                    //{
                    //    txtPONo.Enabled = false;
                    //    //drCurrentRow["txtPONo"] = "";
                    //    ddlExpense.Enabled = true;
                    //    //drCurrentRow["ddlExpense"] = ddlExpense.SelectedItem.Text;
                    //    //drCurrentRow["ddlExpense_value"] = ddlExpense.SelectedValue;
                    //}
                    //else
                    //{
                    //    txtPONo.Enabled = true;
                    //    ddlExpense.Enabled = true;
                    //}
                    drCurrentRow["ddlPaymentThrough"] = ddlPaymentThrough.SelectedItem.Text;
                    drCurrentRow["ddlPaymentThrough_value"] = ddlPaymentThrough.SelectedValue;
                    drCurrentRow["txtDescription"] = txtDescription.Text;
                    drCurrentRow["txtAmount"] = txtAmount.Value;


                    Product_Table.Rows.Add(drCurrentRow);
                }
            }
            DataRow dr = Product_Table.NewRow();
            //dr[0] = "--Select Item--";
            Product_Table.Rows.Add(dr);
            GV_CommercialInvoiceDetail.DataSource = Product_Table;
            GV_CommercialInvoiceDetail.DataBind();
            Bind_PaymentThrough_Dropdown();
            Bind_Expense_Dropdown();
            //Bind_Product_Dropdown();
            //Bind_CostCenter_Dropdown();
            //for (int i = 0; i < GV_CommercialInvoiceDetail.Rows.Count; i++)
            //{
            //    DropDownList cbox = GV_CommercialInvoiceDetail.Rows[i].FindControl("ddlInventory") as DropDownList;
            //    cbox.SelectedIndex = cbox.Items.IndexOf(cbox.Items.FindByText(Product_Table.Rows[i]["ddlInventory"].ToString()));
            //}
            //for (int i = 0; i < GV_CommercialInvoiceDetail.Rows.Count; i++)
            //{
            //    DropDownList cbox = GV_CommercialInvoiceDetail.Rows[i].FindControl("ddlCostCenter") as DropDownList;
            //    cbox.SelectedIndex = cbox.Items.IndexOf(cbox.Items.FindByText(Product_Table.Rows[i]["ddlCostCenter"].ToString()));
            //}
            for (int i = 0; i < GV_CommercialInvoiceDetail.Rows.Count; i++)
            {
                DropDownList cbox = GV_CommercialInvoiceDetail.Rows[i].FindControl("ddlPaymentType") as DropDownList;
                cbox.SelectedIndex = cbox.Items.IndexOf(cbox.Items.FindByText(Product_Table.Rows[i]["ddlPaymentType"].ToString()));
            }
            for (int i = 0; i < GV_CommercialInvoiceDetail.Rows.Count; i++)
            {
                DropDownList cbox = GV_CommercialInvoiceDetail.Rows[i].FindControl("ddlInfoType") as DropDownList;
                cbox.SelectedIndex = cbox.Items.IndexOf(cbox.Items.FindByText(Product_Table.Rows[i]["ddlInfoType"].ToString()));
            }
            for (int i = 0; i < GV_CommercialInvoiceDetail.Rows.Count; i++)
            {
                DropDownList cbox = GV_CommercialInvoiceDetail.Rows[i].FindControl("ddlExpense") as DropDownList;
                cbox.SelectedIndex = cbox.Items.IndexOf(cbox.Items.FindByText(Product_Table.Rows[i]["ddlExpense"].ToString()));
            }
            for (int i = 0; i < GV_CommercialInvoiceDetail.Rows.Count; i++)
            {
                DropDownList cbox = GV_CommercialInvoiceDetail.Rows[i].FindControl("ddlPaymentThrough") as DropDownList;
                cbox.SelectedIndex = cbox.Items.IndexOf(cbox.Items.FindByText(Product_Table.Rows[i]["ddlPaymentThrough"].ToString()));
            }

            for (int i = 0; i < GV_CommercialInvoiceDetail.Rows.Count; i++)
            {
                DropDownList ddlPaymentType = (DropDownList)GV_CommercialInvoiceDetail.Rows[i].Cells[2].FindControl("ddlPaymentType");
                TextBox txtPONo = (TextBox)GV_CommercialInvoiceDetail.Rows[i].Cells[4].FindControl("txtPONo");
                DropDownList ddlExpense = (DropDownList)GV_CommercialInvoiceDetail.Rows[i].Cells[5].FindControl("ddlExpense");
                if (ddlPaymentType.SelectedValue == "1")
                {
                    txtPONo.Enabled = true;
                    ddlExpense.Enabled = false;
                }
                else if (ddlPaymentType.SelectedValue == "2")
                {
                    txtPONo.Enabled = false;
                    ddlExpense.Enabled = true;
                }
                else
                {
                    txtPONo.Enabled = true;
                    ddlExpense.Enabled = true;
                }
            }

        }

        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }


    public DataTable Product_DataSource()
    {
        DataTable dtProduct = Product_Table; dtProduct.Rows.Clear();
        for (int i = 0; i < GV_CommercialInvoiceDetail.Rows.Count; i++)
        {
            if (GV_CommercialInvoiceDetail.Rows[i].Visible)
            {
                TextBox txtDate = (TextBox)GV_CommercialInvoiceDetail.Rows[i].Cells[1].FindControl("txtDate");
                DropDownList ddlPaymentType = (DropDownList)GV_CommercialInvoiceDetail.Rows[i].Cells[2].FindControl("ddlPaymentType");
                DropDownList ddlInfoType = (DropDownList)GV_CommercialInvoiceDetail.Rows[i].Cells[3].FindControl("ddlInfoType");
                TextBox txtPONo = (TextBox)GV_CommercialInvoiceDetail.Rows[i].Cells[4].FindControl("txtPONo");
                DropDownList ddlExpense = (DropDownList)GV_CommercialInvoiceDetail.Rows[i].Cells[5].FindControl("ddlExpense");
                DropDownList ddlPaymentThrough = (DropDownList)GV_CommercialInvoiceDetail.Rows[i].Cells[6].FindControl("ddlPaymentThrough");
                TextBox txtDescription = (TextBox)GV_CommercialInvoiceDetail.Rows[i].Cells[7].FindControl("txtDescription");
                HtmlInputText txtAmount = GV_CommercialInvoiceDetail.Rows[i].Cells[8].FindControl("txtAmount") as HtmlInputText;


                dtProduct.Rows.Add(dtProduct.NewRow());

                dtProduct.Rows[i]["txtDate"] = txtDate.Text;
                dtProduct.Rows[i]["ddlPaymentType"] = ddlPaymentType.SelectedItem.Text;
                dtProduct.Rows[i]["ddlPaymentType_value"] = ddlPaymentType.SelectedValue;
                dtProduct.Rows[i]["ddlInfoType"] = ddlInfoType.SelectedItem.Text;
                dtProduct.Rows[i]["ddlInfoType_value"] = ddlInfoType.SelectedValue;
                dtProduct.Rows[i]["txtPONo"] = txtPONo.Text;
                dtProduct.Rows[i]["ddlExpense"] = ddlExpense.SelectedItem.Text;
                dtProduct.Rows[i]["ddlExpense_value"] = ddlExpense.SelectedValue;
                dtProduct.Rows[i]["ddlPaymentThrough"] = ddlPaymentThrough.SelectedItem.Text;
                dtProduct.Rows[i]["ddlPaymentThrough_value"] = ddlPaymentThrough.SelectedValue;
                dtProduct.Rows[i]["txtDescription"] = txtDescription.Text;
                dtProduct.Rows[i]["txtAmount"] = txtAmount.Value;


            }
            else
            {
                dtProduct.Rows.Add(dtProduct.NewRow());
            }
        }
        for (int pr = 0; pr < Product_Table.Rows.Count; pr++)
        {
            //if (Product_Table.Rows[pr]["ddlInventory"].ToString() == "" || Product_Table.Rows[pr]["txtDescription"].ToString() == "" || Product_Table.Rows[pr]["txtItemSize"].ToString() == "")
            //{
            //    Product_Table.Rows.RemoveAt(pr);
            //    pr--;
            //}

            if (Product_Table.Rows[pr]["ddlPaymentType"].ToString() == "")
            {
                Product_Table.Rows.RemoveAt(pr);
                pr--;
            }


        }

        return dtProduct;
    }

    private DataTable Product_Table
    {
        get
        {
            DataTable dt = (DataTable)ViewState["CurrentTable"];
            if (dt == null)
            {

                dt.Columns.Add(new DataColumn("txtDate", typeof(string)));
                dt.Columns.Add(new DataColumn("ddlPaymentType", typeof(string)));
                dt.Columns.Add(new DataColumn("ddlPaymentType_value", typeof(string)));
                dt.Columns.Add(new DataColumn("ddlInfoType", typeof(string)));
                dt.Columns.Add(new DataColumn("ddlInfoType_value", typeof(string)));
                dt.Columns.Add(new DataColumn("txtPONo", typeof(string)));
                dt.Columns.Add(new DataColumn("ddlExpense", typeof(string)));
                dt.Columns.Add(new DataColumn("ddlExpense_value", typeof(string)));
                dt.Columns.Add(new DataColumn("ddlPaymentThrough", typeof(string)));
                dt.Columns.Add(new DataColumn("ddlPaymentThrough_value", typeof(string)));
                dt.Columns.Add(new DataColumn("txtDescription", typeof(string)));
                dt.Columns.Add(new DataColumn("txtAmount", typeof(string)));

                for (int i = 0; i < 10; i++)
                {
                    dt.Rows.Add(dt.NewRow());
                }
            }
            ViewState["CurrentTable"] = dt;
            return dt;
        }
        set
        {
            ViewState["CurrentTable"] = value;
        }
    }

    protected void GV_CommercialInvoiceDetail_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int index = e.RowIndex;
        if (index != 0)
        {
            GV_CommercialInvoiceDetail.Rows[e.RowIndex].Visible = false;

            TextBox txtDate = (TextBox)GV_CommercialInvoiceDetail.Rows[e.RowIndex].Cells[1].FindControl("txtDate");
            DropDownList ddlPaymentType = (DropDownList)GV_CommercialInvoiceDetail.Rows[e.RowIndex].Cells[2].FindControl("ddlPaymentType");
            DropDownList ddlInfoType = (DropDownList)GV_CommercialInvoiceDetail.Rows[e.RowIndex].Cells[3].FindControl("ddlInfoType");
            TextBox txtPONo = (TextBox)GV_CommercialInvoiceDetail.Rows[e.RowIndex].Cells[4].FindControl("txtPONo");
            DropDownList ddlExpense = (DropDownList)GV_CommercialInvoiceDetail.Rows[e.RowIndex].Cells[5].FindControl("ddlExpense");
            DropDownList ddlPaymentThrough = (DropDownList)GV_CommercialInvoiceDetail.Rows[e.RowIndex].Cells[6].FindControl("ddlPaymentThrough");
            TextBox txtDescription = (TextBox)GV_CommercialInvoiceDetail.Rows[e.RowIndex].Cells[7].FindControl("txtDescription");
            HtmlInputText txtAmount = GV_CommercialInvoiceDetail.Rows[e.RowIndex].Cells[8].FindControl("txtAmount") as HtmlInputText;

            if (txtAmount.Value == "") { txtAmount.Value = "0"; }

            txtDate.Text = "";
            ddlPaymentType.SelectedIndex = 0;
            ddlInfoType.SelectedIndex = 0;
            txtPONo.Text = "";
            ddlExpense.SelectedIndex = 0;
            ddlPaymentThrough.SelectedIndex = 0;
            txtDescription.Text = "";
            txtAmount.Value = "";
            Reload_JS();
        }



    }


    public DataTable Record_for_Insert()
    {
        Product_Table = Product_DataSource();


        int Product_Rows = Product_Table.Rows.Count;


        int TotalRows = 0;
        if (Product_Rows > 0)
        {
            TotalRows = Product_Rows;
        }


        DataTable dtInsert = new DataTable();
        dtInsert.Merge(Product_Table);

        dtInsert.Rows.Clear();
        for (int r = 0; r < TotalRows; r++)
        {
            dtInsert.Rows.Add(dtInsert.NewRow());
        }
        for (int p = 0; p < Product_Rows; p++)
        {
            if (Product_Table.Rows[p]["ddlPaymentType"].ToString() != null && Product_Table.Rows[p]["ddlPaymentType"].ToString() != "")
            {
                dtInsert.Rows[p]["txtDate"] = Product_Table.Rows[p]["txtDate"].ToString();
                dtInsert.Rows[p]["ddlPaymentType"] = Product_Table.Rows[p]["ddlPaymentType"].ToString();
                dtInsert.Rows[p]["ddlPaymentType_value"] = Product_Table.Rows[p]["ddlPaymentType_value"].ToString();
                dtInsert.Rows[p]["ddlInfoType"] = Product_Table.Rows[p]["ddlInfoType"].ToString();
                dtInsert.Rows[p]["ddlInfoType_value"] = Product_Table.Rows[p]["ddlInfoType_value"].ToString();
                dtInsert.Rows[p]["txtPONo"] = Product_Table.Rows[p]["txtPONo"].ToString();
                dtInsert.Rows[p]["ddlExpense"] = Product_Table.Rows[p]["ddlExpense"].ToString();
                dtInsert.Rows[p]["ddlExpense_value"] = Product_Table.Rows[p]["ddlExpense_value"].ToString();
                dtInsert.Rows[p]["ddlPaymentThrough"] = Product_Table.Rows[p]["ddlPaymentThrough"].ToString();
                dtInsert.Rows[p]["ddlPaymentThrough_value"] = Product_Table.Rows[p]["ddlPaymentThrough_value"].ToString();
                dtInsert.Rows[p]["txtDescription"] = Product_Table.Rows[p]["txtDescription"].ToString();
                dtInsert.Rows[p]["txtAmount"] = Product_Table.Rows[p]["txtAmount"].ToString();
     
            }


        }

        return dtInsert;
    }

    protected void btnClearAllLines_Click(object sender, EventArgs e)
    {
        SetInitialRow();
    }



    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            Sessions PSMS = (Sessions)Session["PSMSSession"];
            if (PSMS.Can_Insert == true)
            {
                if (Check_Validation())
                {
                    if (Insert_Invoice())
                    {
                        if (btnSave.Text == "Save")
                        {
                            btnSave.Visible = false;
                            lblSuccessMsg.InnerHtml = "Job Sheet Created Successfully";
                        }
                        else
                        {
                            lblSuccessMsg.InnerHtml = "Job Sheet Updated Successfully";
                        }
                        SCGL_Common.Success_Message(this.Page, "JobSheetForm_Views.aspx");
                    }
                }
            }
            else
                JQ.showStatusMsg(this, "3", "User not Allowed to Insert New Record");
        }
        catch (Exception ex)
        {
            lblNewError.InnerHtml = ex.Message;
            SCGL_Common.Error_Message(this.Page);
        }
    }

    public bool Insert_Invoice()
    {
        SqlConnection con = new SqlConnection(ConnectionString.PSMS);
        con.Open();
        SqlTransaction trans = con.BeginTransaction();

        bool isCreated = false;
        decimal CogRate = 0;
        try
        {
            Sessions PSMS = (Sessions)Session["PSMSSession"];
            if (btnSave.Text == "Save")
            {
                BALInvoice.JobID = -1;
            }
            else
            {
                BALInvoice.JobID = SCGL_Common.Convert_ToInt(Request.QueryString["Id"]);
            }


            BALInvoice.JobNo = Convert.ToInt32(ddlJobNo.SelectedValue);
            BALInvoice.CustomerID = Convert.ToInt32(hdnCustomerID.Value);
            BALInvoice.Description2 = txtDescription2.Text;
            BALInvoice.OtherDetails = txtOtherDetails.Text;
            BALInvoice.Total = SCGL_Common.Convert_ToDecimal(txttotal2.Value);
           
            
            //BALInvoice.LoginID = SBO.UserID;
            //BALInvoice.FinYearID = SBO.FinYearID;

            int JobID = BALInvoice.CreateModifyJobSheet(BALInvoice, trans);
            if (JobID > 0)
            {
                BALInvoice.JobID = SCGL_Common.Convert_ToInt(JobID);
                if (btnSave.Text == "Update")
                {
                    BALInvoice.Delete_JobSheetDetail(BALInvoice.JobID, trans);
                    BALInvoice.Delete_JobSheetTrans(BALInvoice.JobID, trans);
                }
                //trans.Commit();
                int Counter = 0;
                DataTable dt = Record_for_Insert();
                for (int i = 0; i < dt.Rows.Count; i++)
                {

                    BALInvoice.JobID = SCGL_Common.Convert_ToInt(JobID);
                    BALInvoice.Date = SCGL_Common.CheckDateTime(dt.Rows[i]["txtDate"].ToString());
                    BALInvoice.PaymentType = SCGL_Common.Convert_ToInt(dt.Rows[i]["ddlPaymentType_value"].ToString());
                    BALInvoice.InfoType = SCGL_Common.Convert_ToInt(dt.Rows[i]["ddlInfoType_value"].ToString());
                    BALInvoice.PONo = dt.Rows[i]["txtPONo"].ToString();
                    BALInvoice.ExpenseAcc = dt.Rows[i]["ddlExpense_value"].ToString();
                    BALInvoice.PaymentThrough = dt.Rows[i]["ddlPaymentThrough_value"].ToString();
                    BALInvoice.Description = dt.Rows[i]["txtDescription"].ToString();
                    BALInvoice.Amount = SCGL_Common.Convert_ToDecimal(dt.Rows[i]["txtAmount"].ToString());
                                    
                    if (BALInvoice.CreateModifyJobSheetDetail(BALInvoice, trans))
                    {

                        Counter++;
                    }
                    else
                    {
                        Counter = 0;
                        break;
                    }
                }
                //BALInvoice.GetCOGS(BALInvoice, trans);
                if (Counter > 0)
                {
                    trans.Commit();
                    isCreated = true;
                }
                else
                {
                    trans.Rollback();
                    isCreated = false;
                }
            }
            else
            {
                isCreated = false;
            }
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
        catch (Exception e)
        {
            trans.Rollback();
            isCreated = false;
            throw;
        }
        return isCreated;
    }

    public bool Check_Validation()
    {
        bool IsValid = true;


        //for (int i = 0; i < GV_CommercialInvoiceDetail.Rows.Count; i++)
        //{
        //    DropDownList ddlProduct = GV_CommercialInvoiceDetail.Rows[i].FindControl("ddlInventory") as DropDownList;
        //    TextBox txtDescription = (TextBox)GV_CommercialInvoiceDetail.Rows[i].FindControl("txtDescription");
        //    TextBox txtQuantity = (TextBox)GV_CommercialInvoiceDetail.Rows[i].FindControl("txtQuantity");
        //    TextBox txtRate = (TextBox)GV_CommercialInvoiceDetail.Rows[i].FindControl("txtRate");
        //    DropDownList ddlCostCenter = GV_CommercialInvoiceDetail.Rows[i].FindControl("ddlCostCenter") as DropDownList;
        //    if (ddlProduct.SelectedValue != "0")
        //    {
        //        if (ddlCostCenter.SelectedValue == "0")
        //        {
        //            SCGL_Common.Error_Message(this);
        //            return false;
        //        }
        //    }

        //}

        return IsValid;
    }





    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("JobSheetForm_Views.aspx");
    }

    protected void ddlJobNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlJobNo.SelectedValue != "0")
        {
            DataTable dt = BALInvoice.getCustomerNamebyJobNumber(Convert.ToInt32(ddlJobNo.SelectedValue));
            txtCustomer.Text = dt.Rows[0]["DisplayName"].ToString();
            hdnCustomerID.Value = dt.Rows[0]["CustomerID"].ToString();
        }
        //if (ddlJobNo.SelectedValue != "0")
        //{
        //    DataTable dt = BALInvoice.getCustomerNamebyJobNumber(SCGL_Common.Convert_ToInt(ddlJobNo.SelectedValue));
        //    txtCustomer.Text = dt.Rows[0]["DisplayName"].ToString();
        //    hdnCustomerID.Value = dt.Rows[0]["CustomerID"].ToString();
        //}
    }

    protected void ddlPaymentType_SelectedIndexChanged(object sender, EventArgs e)
    {
        //int index = SCGL_Common.Convert_ToInt(e);
        //if (e != 0)
        //{

            DropDownList ddl = (DropDownList)sender;
            GridViewRow row = (GridViewRow)ddl.Parent.Parent;
            int idx = row.RowIndex;

            DropDownList ddlPaymentType = (DropDownList)row.Cells[0].FindControl("ddlPaymentType");
            TextBox txtPONo = (TextBox)row.Cells[0].FindControl("txtPONo");
            DropDownList ddlExpense = (DropDownList)row.Cells[0].FindControl("ddlExpense");
         

            //DropDownList ddlPaymentType = (DropDownList)GV_CommercialInvoiceDetail.Rows[e].Cells[2].FindControl("ddlPaymentType");
            ////DropDownList ddlInfoType = (DropDownList)GV_CommercialInvoiceDetail.Rows[index].Cells[3].FindControl("ddlInfoType");
            //TextBox txtPONo = (TextBox)GV_CommercialInvoiceDetail.Rows[e].Cells[4].FindControl("txtPONo");
            //DropDownList ddlExpense = (DropDownList)GV_CommercialInvoiceDetail.Rows[index].Cells[5].FindControl("ddlExpense");



            if (ddlPaymentType.SelectedValue == "1")
            {
                txtPONo.Enabled = true;
                ddlExpense.Enabled = false;
                //ddlExpense.SelectedIndex = 0;
            }
            else if (ddlPaymentType.SelectedValue == "2")  
            {
                txtPONo.Enabled = false;
                txtPONo.Text = "";
                ddlExpense.Enabled = true;
            }
            else
            {
                txtPONo.Enabled = true;
                ddlExpense.Enabled = true;
            }
        //}
    }
   


    
}
