using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for UserRole_BLL
/// </summary>
public class UserRole_BLL:UserRole_DAL
{
	public UserRole_BLL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public int CompanyID { get; set; }
    public int RoleID { get; set; }
    public string RoleName { get; set; }
    public string Description { get; set; }
    public bool Status { get; set; }
    public DateTime CreatedDate { get; set; }
    public int CreatedBy { get; set; }
    public DateTime UpdatedDate { get; set; }
    public int UpdatedBy { get; set; }

    public override System.Data.DataTable GetAllRole(int? RoleID)
    {
        return base.GetAllRole(RoleID);
    }

    public override int InsertRole(UserRole_BLL Role)
    {
        return base.InsertRole(Role);
    }

    public override int UpdateRole(UserRole_BLL Role)
    {
        return base.UpdateRole(Role);
    }

    public override int DeleteRole(int RoleID)
    {
        return base.DeleteRole(RoleID);
    }

    public override bool ChildRecordExistsByRole(int RoleID)
    {
        return base.ChildRecordExistsByRole(RoleID);
    }
}