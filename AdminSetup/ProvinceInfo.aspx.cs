using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminSetup_ProvinceInfo : System.Web.UI.Page
{
    Province_BLL BL = new Province_BLL();
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
                if (dtRole.Rows[row]["PageUrl"].ToString() == "AdminSetup/ProvinceInfo.aspx")
                {
                    pageName = dtRole.Rows[row]["PageUrl"].ToString();
                    view = Convert.ToBoolean(dtRole.Rows[row]["Can_View"].ToString());
                    break;
                }
            }
            if (dtRole.Rows.Count > 0)
            {
                if (pageName == "AdminSetup/ProvinceInfo.aspx" && view == true)
                {
                    fillGrid();


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
        Sessions PSMSSession = (Sessions)Session["PSMSSession"];
        grd.DataSource = BL.GetProvinceListbySearch((object)DBNull.Value, (object)DBNull.Value);
        grd.DataBind();
    }
    protected void grd_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grd.PageIndex = e.NewPageIndex;
        int page = grd.PageSize;
        btnSearch_Click(null, null); ;
    }
    protected void btnEdit_Command(object sender, CommandEventArgs e)
    {
        var Province = BL.GetProvinceList(e.CommandArgument);
        if (Province.Rows.Count > 0)
        {

            hdID.Value = Province.Rows[0]["ProvinceID"].ToString();
            txtProvince.Text = Province.Rows[0]["Province"].ToString();
          


            btnSave.Visible = true;
            JQ.ShowModal(this, "ModalProvince");
        }

    }



    protected void btnSave_Click(object sender, EventArgs e)
    {
        Sessions PSMSSession = (Sessions)Session["PSMSSession"];

        BL.ProvinceID = hdID.Value == "" ? 0 : Convert.ToInt32(hdID.Value);
        BL.Province = txtProvince.Text;
       
        BL.User = PSMSSession.UserID;
        BL.Date = DateTime.Now;

        BL.InsertUpdateProvince(BL);
        hdID.Value = "";
        fillGrid();
        JQ.CloseModal(this, "ModalProvince");
        JQ.ShowStatusMsg(this.Page, "1", "Province Saved Successfully.");






    }


    protected void btnDelete_Command(object sender, CommandEventArgs e)
    {

        int ProvinceID = Convert.ToInt32(e.CommandArgument);

        try
        {
            BL.ProvinceDelete(ProvinceID);
            fillGrid();
            JQ.ShowStatusMsg(this.Page, "1", "Province Deleted Successfully.");
        }
        catch(Exception ex)
        {
            JQ.ShowStatusMsg(this.Page, "4", "Province used in Branch.");
        }

       

    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        TextBox txtSearchProvinceID = (TextBox)grd.HeaderRow.FindControl("txtSearchProvinceID");
        TextBox txtSearchProvince = (TextBox)grd.HeaderRow.FindControl("txtSearchProvince");




        if (string.IsNullOrEmpty(txtSearchProvinceID.Text) && string.IsNullOrEmpty(txtSearchProvince.Text))

            fillGrid();
        else
        {
            grd.DataSource = BL.GetProvinceListbySearch(
               string.IsNullOrEmpty(txtSearchProvinceID.Text) ? (object)DBNull.Value : txtSearchProvinceID.Text,
               string.IsNullOrEmpty(txtSearchProvince.Text) ? (object)DBNull.Value : txtSearchProvince.Text);




            grd.DataBind();

            setValues(txtSearchProvinceID.Text, txtSearchProvince.Text);

        }
    }
    public void setValues(string ProvinceID, string Province)
    {
        TextBox txtSearchProvinceID = (TextBox)grd.HeaderRow.FindControl("txtSearchProvinceID");
        TextBox txtSearchProvince = (TextBox)grd.HeaderRow.FindControl("txtSearchProvince");
        txtSearchProvinceID.Text = ProvinceID;
        txtSearchProvince.Text = Province;

    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        setValues(string.Empty, string.Empty);
        fillGrid();
    }
}