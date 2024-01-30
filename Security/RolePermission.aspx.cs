using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Security_RolePermission : System.Web.UI.Page
{

    RolePermission_BLL Mod = new RolePermission_BLL();
    private int RoleID;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["ID"] != null && Request.QueryString["Name"] != null)
            {
                RoleID = Convert.ToInt32(EncryptDecrypt.Decrypt(Request.QueryString["ID"]));
                string RoleName = EncryptDecrypt.Decrypt(Request.QueryString["Name"]);
                lblRoleName.Text = RoleName;
                BindAllGrid();
                GetModulPermission(RoleID);
                GetRolePagePermission(RoleID);
                hddRoleID.Value = RoleID.ToString();
            }
            else
            {
                Response.Redirect("~/Default.aspx");
            }
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "TabActive", "TabActive();", true);
    }

    public void BindAllGrid()
    {
        GridAllModule.DataSource = Mod.GetAllModule(null); // All Module
        GridAllModule.DataBind();
         
        GridSecurity.DataSource = Mod.GetAllPageByModuleID(4); // Setup
        GridSecurity.DataBind();
        GridReports.DataSource = Mod.GetAllPageByModuleID(5); //Reports
        GridReports.DataBind();
        GridMaintenance.DataSource = Mod.GetAllPageByModuleID(7); //Maintenance
        GridMaintenance.DataBind();

        GridVendors.DataSource = Mod.GetAllPageByModuleID(8); //Vendors
        GridVendors.DataBind();
        GridItems.DataSource = Mod.GetAllPageByModuleID(9); //Items
        GridItems.DataBind();
        GridProjects.DataSource = Mod.GetAllPageByModuleID(10); //Projects
        GridProjects.DataBind();
        GridPayments.DataSource = Mod.GetAllPageByModuleID(11); //Payments
        GridPayments.DataBind();
      
        GridQuotation.DataSource = Mod.GetAllPageByModuleID(14); //Quotation
        GridQuotation.DataBind();
    }

    protected void chkAllSelect_CheckedChanged(object sender, EventArgs e)
    {
        hddTabID.Value = "LIAllModule";
        CheckBox chk = (CheckBox)sender;
        GridViewRow dr = (GridViewRow)chk.Parent.Parent;
        Label lblModID = (Label)dr.FindControl("lblModuleID");      
        CheckBox chkView = (CheckBox)dr.FindControl("ChkView");
        CheckApply(Convert.ToInt32(lblModID.Text), chkView.ID, chk.Checked);
      
    }

    protected void ChkView_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chk = (CheckBox)sender;
        GridViewRow dr = (GridViewRow)chk.Parent.Parent;
        Label lblModID = (Label)dr.FindControl("lblModuleID");
        CheckBox ChkSelected = (CheckBox)dr.FindControl("chkAllSelect");     
            CheckApply(Convert.ToInt32(lblModID.Text), chk.ID, chk.Checked);
    }

   
    protected void GridAllModule_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            CheckBox chk = (CheckBox)e.Row.FindControl("ChkView") as CheckBox;
            ScriptManager.GetCurrent(this).RegisterAsyncPostBackControl(chk);
        }
    }

    private void CheckApply(int ModuleID, string CheckBoxName, bool IsCheck)
    {
        GridView Grid = GetGridName(ModuleID);
        for (int i = 0; i < Grid.Rows.Count; i++)
        {
            CheckBox chk = (CheckBox)Grid.Rows[i].FindControl(CheckBoxName);
            chk.Checked = IsCheck;
        }
    }

    private GridView GetGridName(int ModuleID)
    {
        GridView Grid = null;

         if (ModuleID == (int)4)
        {
            Grid = GridSecurity;
        }
        else if (ModuleID == (int)5)
        {
            Grid = GridReports;
        }       
        else if (ModuleID == (int)7)
        {
            Grid = GridMaintenance;
        }

        else if (ModuleID == (int)8)
        {
            Grid = GridVendors;
        }
        else if (ModuleID == (int)9)
        {
            Grid = GridItems;
        }
        else if (ModuleID == (int)10)
        {
            Grid = GridProjects;
        }
        else if (ModuleID == (int)11)
        {
            Grid = GridPayments;
        }       
        else if (ModuleID == (int)14)
        {
            Grid = GridQuotation;
        }
        return Grid;
    }

  

    protected void lbtnSave_Click(object sender, EventArgs e)
    {
        if (SaveUserRolePermission(Convert.ToInt32(hddRoleID.Value)) == true)
        {
            JQ.ShowStatusMsg(this.Page, "1", "Permission Saved Successfully.");
        }
        else
        {

        }
    }

    private bool SaveUserRolePermission(int RoleID)
    {
        bool IsTrue = false;
        Sessions PSMSSession = (Sessions)Session["PSMSSession"];
        if (PSMSSession != null)
        {
            SqlConnection con = new SqlConnection(ConnectionString.PSMS);
            con.Open();
            SqlTransaction trans = con.BeginTransaction();
            try
            {
                Mod.DeletePagePermissionPagesByRole(RoleID, trans);
                Mod.DeleteModulePermissionByRoleID(RoleID, trans);
                InsertUpdateModulePermission(RoleID, trans, PSMSSession);                
                
                InsertUpdateRolePagePermission(GridSecurity, RoleID, trans, PSMSSession);
                InsertUpdateRolePagePermission(GridReports, RoleID, trans, PSMSSession);
             
                InsertUpdateRolePagePermission(GridMaintenance, RoleID, trans, PSMSSession);

                InsertUpdateRolePagePermission(GridVendors, RoleID, trans, PSMSSession);
                InsertUpdateRolePagePermission(GridItems, RoleID, trans, PSMSSession);
                InsertUpdateRolePagePermission(GridProjects, RoleID, trans, PSMSSession);
                InsertUpdateRolePagePermission(GridPayments, RoleID, trans, PSMSSession);
               
                InsertUpdateRolePagePermission(GridQuotation, RoleID, trans, PSMSSession);
                trans.Commit();
                IsTrue = true;
            }
            catch (Exception)
            {
                trans.Rollback();
                IsTrue = false;

            }
        }
        return IsTrue;
    }

    #region InsertUpdateModulePermission
    private void InsertUpdateModulePermission(int RoleID, SqlTransaction Tran, Sessions Sess)
    {
        for (int i = 0; i < GridAllModule.Rows.Count; i++)
        {
         
            CheckBox ChkView = (CheckBox)GridAllModule.Rows[i].FindControl("ChkView");
          
                if (ChkView.Checked) 
                {
                    Mod.RoleID = RoleID;
                    Mod.ModuleID = Convert.ToInt32(((Label)GridAllModule.Rows[i].FindControl("lblModuleID")).Text);
                    Mod.Can_View = ChkView.Checked;
                    Mod.Can_Insert = ChkView.Checked;
                    Mod.Can_Update = ChkView.Checked;
                    Mod.Can_Delete = ChkView.Checked;
                    Mod.Active = true;
                    Mod.InsertUpdateModulePermissionByRoleID(Mod, Tran, Sess);

                }
           
        }
    }
    #endregion

    #region InsertUpdateRolePagePermission
    private void InsertUpdateRolePagePermission(GridView Grid, int RoleID, SqlTransaction Tran, Sessions Sess)
    {
        for (int i = 0; i < Grid.Rows.Count; i++)
        {
         
            CheckBox ChkView = (CheckBox)Grid.Rows[i].FindControl("ChkView");
          
                if (ChkView.Checked)
                {
                    Mod.RoleID = RoleID;
                    Mod.PageID = Convert.ToInt32(((Label)Grid.Rows[i].FindControl("lblPageID")).Text);
                    Mod.Can_View = ChkView.Checked;
                    Mod.Can_Insert = ChkView.Checked;
                    Mod.Can_Update = ChkView.Checked;
                    Mod.Can_Delete = ChkView.Checked;
                    Mod.Active = true;
                    Mod.InsertUpdatePagePermission(Mod, Tran, Sess);
                }
          
        }
    }
    #endregion

    private void GetModulPermission(int RoleID)
    {
        DataTable dt = Mod.GetModuleRightsByRoleID(RoleID);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            for (int j = 0; j < GridAllModule.Rows.Count; j++)
            {
                Label lblModulID = (Label)GridAllModule.Rows[j].FindControl("lblModuleID");
                if (lblModulID.Text == dt.Rows[i]["ModuleID"].ToString())
                {
                   
                    CheckBox ChkView = (CheckBox)GridAllModule.Rows[j].FindControl("ChkView");
                    ChkView.Checked = Convert.ToBoolean(dt.Rows[i]["Can_View"]);
                  
                }
                else
                {
                   
                }
            }
        }
    }

    private void GetRolePagePermission(int RoleID)
    {
        DataTable dt = Mod.GetPagePermissionpPagesByRole(RoleID);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            bool Continue;           
           
            Continue = SetRolePagePermissionOnGrid(GridSecurity, dt.Rows[i]);
            if (Continue)
                continue;
            Continue = SetRolePagePermissionOnGrid(GridReports, dt.Rows[i]);
            if (Continue)
                continue;           
            Continue = SetRolePagePermissionOnGrid(GridMaintenance, dt.Rows[i]);
            if (Continue)
                continue;

            Continue = SetRolePagePermissionOnGrid(GridVendors, dt.Rows[i]);
            if (Continue)
                continue;
            Continue = SetRolePagePermissionOnGrid(GridItems, dt.Rows[i]);
            if (Continue)
                continue;
            Continue = SetRolePagePermissionOnGrid(GridProjects, dt.Rows[i]);
            if (Continue)
                continue;
            Continue = SetRolePagePermissionOnGrid(GridPayments, dt.Rows[i]);
            if (Continue)
                continue;
           
            Continue = SetRolePagePermissionOnGrid(GridQuotation, dt.Rows[i]);
        }
    }

    private bool SetRolePagePermissionOnGrid(GridView Grid, DataRow Drow)
    {
        for (int i = 0; i < Grid.Rows.Count; i++)
        {
            Label lblPageID = (Label)Grid.Rows[i].FindControl("lblPageID");
            if (lblPageID.Text == Drow["PageID"].ToString())
            {
              
                CheckBox ChkView = (CheckBox)Grid.Rows[i].FindControl("ChkView");
                ChkView.Checked = Convert.ToBoolean(Drow["Can_View"]);
               

                return true;
            }
        }
        return false;
    }

    protected void chkAll_CheckedChanged(object sender, EventArgs e)
    {
        hddTabID.Value = "LIAllModule";
        CheckBox chk = (CheckBox)sender;
        foreach (GridViewRow AllModule in GridAllModule.Rows)
        {
          
            ((CheckBox)AllModule.FindControl("ChkView")).Checked = chk.Checked;
          
        }

      
        
       
        foreach (GridViewRow AllModule in GridSecurity.Rows)
        {
         
            ((CheckBox)AllModule.FindControl("ChkView")).Checked = chk.Checked;
           
        }
        foreach (GridViewRow AllModule in GridReports.Rows)
        {

            ((CheckBox)AllModule.FindControl("ChkView")).Checked = chk.Checked;

        }
     
        foreach (GridViewRow AllModule in GridMaintenance.Rows)
        {

            ((CheckBox)AllModule.FindControl("ChkView")).Checked = chk.Checked;

        }

        foreach (GridViewRow AllModule in GridVendors.Rows)
        {

            ((CheckBox)AllModule.FindControl("ChkView")).Checked = chk.Checked;

        }
        foreach (GridViewRow AllModule in GridItems.Rows)
        {

            ((CheckBox)AllModule.FindControl("ChkView")).Checked = chk.Checked;

        }
        foreach (GridViewRow AllModule in GridProjects.Rows)
        {

            ((CheckBox)AllModule.FindControl("ChkView")).Checked = chk.Checked;

        }
        foreach (GridViewRow AllModule in GridPayments.Rows)
        {

            ((CheckBox)AllModule.FindControl("ChkView")).Checked = chk.Checked;

        }
      
        foreach (GridViewRow AllModule in GridQuotation.Rows)
        {

            ((CheckBox)AllModule.FindControl("ChkView")).Checked = chk.Checked;

        }
    }
}