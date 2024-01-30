using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Security_Users : System.Web.UI.Page
{
    User_BLL BL = new User_BLL();
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
                if (dtRole.Rows[row]["PageUrl"].ToString() == "Security/Users.aspx")
                {
                    pageName = dtRole.Rows[row]["PageUrl"].ToString();
                    view = Convert.ToBoolean(dtRole.Rows[row]["Can_View"].ToString());
                    break;
                }
            }
            if (dtRole.Rows.Count > 0)
            {
                if (pageName == "Security/Users.aspx" && view == true)
                {
                    fillGrid();
                    PM.Bind_DropDown(cmbRole, new UserRole_BLL().GetAllRole(null), "RoleName", "RoleID");
                }
                else
                {
                    Response.Redirect("Default.aspx", false);
                }
            }

        }
    }

    public void fillGrid()
    {
        grdUsers.DataSource = ViewState["UserList"] = BL.GetUserList(DBNull.Value);
        grdUsers.DataBind();
  

    
    
    }
    protected void grdUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdUsers.PageIndex = e.NewPageIndex;
        if (string.IsNullOrEmpty(txtSearch.Text))
            fillGrid();
        else
            btnSearch_Click(null, null);
    }
    protected void btnEdit_Command(object sender, CommandEventArgs e)
    {
        var User = BL.GetUserList(e.CommandArgument);
        if (User.Rows.Count > 0)
        {
            hdID.Value = User.Rows[0]["UserID"].ToString();
            cmbRole.SelectedValue = User.Rows[0]["RoleID"].ToString();
            txtName.Text = User.Rows[0]["Name"].ToString();
            txtUserID.Text = User.Rows[0]["UserName"].ToString();
            txtPassword.Attributes.Add("Value", EncryptDecrypt.Decrypt(User.Rows[0]["Password"].ToString()));
            txtPhone.Text = User.Rows[0]["Phone"].ToString();
            txtEmail.Text = User.Rows[0]["Email"].ToString();
            txtAddress.Text = User.Rows[0]["Address"].ToString();
            chkActive.Checked = Convert.ToBoolean(User.Rows[0]["Status"]);
            JQ.ShowHideControl(this, "btnSave", true);
            JQ.ShowModal(this, "ModalUser");
        }
        
    }
    protected void btnDelete_Command(object sender, CommandEventArgs e)
    {
        hdDeleteID.Value = e.CommandArgument.ToString();
        JQ.ShowModal(this, "ModalConfirmation");
      

    }
    protected void btnView_Command(object sender, CommandEventArgs e)
    {
        var User = BL.GetUserList(e.CommandArgument);
        if(User.Rows.Count > 0)
        {
        cmbRole.SelectedValue = User.Rows[0]["RoleID"].ToString();
        txtName.Text=User.Rows[0]["Name"].ToString();
        txtUserID.Text = User.Rows[0]["UserName"].ToString();
        txtPassword.Attributes.Add("Value",EncryptDecrypt.Decrypt(User.Rows[0]["Password"].ToString()));
        txtPhone.Text = User.Rows[0]["Phone"].ToString();
        txtEmail.Text = User.Rows[0]["Email"].ToString();
        txtAddress.Text = User.Rows[0]["Address"].ToString();
        chkActive.Checked = Convert.ToBoolean(User.Rows[0]["Status"]);
        JQ.ShowHideControl(this, "btnSave", false);
        JQ.ShowModal(this, "ModalUser");
        JQ.disabledControl(this, "ModalUser");
        }
        

    }
  
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Sessions PSMSSession = (Sessions)Session["PSMSSession"];
        BL.Name = txtName.Text;
        BL.UserName = txtUserID.Text;
        BL.Password = EncryptDecrypt.Encrypt(txtPassword.Text);
        BL.Phone = txtPhone.Text;
        BL.Email = txtEmail.Text;
        BL.Address = txtAddress.Text;
        BL.RoleID = Convert.ToInt32(cmbRole.SelectedValue);
        BL.Status = Convert.ToBoolean(chkActive.Checked);
        BL.User = PSMSSession.UserID;
        BL.Date = DateTime.Now;
        BL.UserID = hdID.Value == "" ? 0 : Convert.ToInt32(hdID.Value);
        BL.InsertUpdateUser(BL);
        hdID.Value = "";      
        fillGrid();
        JQ.CloseModal(this, "ModalUser");
        JQ.ShowStatusMsg(this.Page, "1", "User Saved Successfully.");
    }





    protected void btnSearch_Click(object sender, EventArgs e)
    {
        DataTable dt = (DataTable)ViewState["UserList"];
        string text = txtSearch.Text;
        DataRow[] dr = dt.Select("Name like '%" + text + "%' Or UserName like '%" + text + "%' Or Phone like '%" + text + "%' Or Email like '%" + text + "%' Or Address like '%" + text + "%'");
        DataTable dtnew = new DataTable();
        if (dr.Count() > 0)
        {
           
            dtnew = dr.CopyToDataTable();
            grdUsers.DataSource = dtnew;
            grdUsers.DataBind();
        }
        else
        {
            grdUsers.DataSource = dtnew;
            grdUsers.DataBind();
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        txtSearch.Text = "";
        grdUsers.DataSource = (DataTable)ViewState["UserList"];
            grdUsers.DataBind(); 
    }
    protected void btnConfirmation_Click(object sender, EventArgs e)
    {
        if (Convert.ToInt32(hdDeleteID.Value) > 1)
        {
            BL.DeleteUser(Convert.ToInt32(hdDeleteID.Value));
            JQ.ShowStatusMsg(this.Page, "1", "User Deleted Successfully!");
            fillGrid();
        }
        else
        {
            JQ.ShowStatusMsg(this.Page, "3", "You can not delete admin user.");
        }
        hdDeleteID.Value = "";
        JQ.CloseModal(this, "ModalConfirmation");  
    }
    protected void grdUsers_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
           
            if (e.Row.Cells[0].Text == "1")
            {
                e.Row.FindControl("btnView").Visible = false;
                e.Row.FindControl("btnEdit").Visible = false;
                e.Row.FindControl("btnDelete").Visible = false;
            }

        }
    }
}