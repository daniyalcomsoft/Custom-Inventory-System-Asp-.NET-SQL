using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for RolePermission_BLL
/// </summary>
public class RolePermission_BLL:RolePermission_DAL
{
	public RolePermission_BLL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public int ModulePermissionID { get; set; }
    public int PermissionID { get; set; }
    public int PageID { get; set; }
    public int RoleID { get; set; }
    public int ModuleID { get; set; }
    public bool Can_View { get; set; }
    public bool Can_Insert { get; set; }
    public bool Can_Update { get; set; }
    public bool Can_Delete { get; set; }
    public bool Active { get; set; }

    public override System.Data.DataTable GetAllModule(int? ModuleID)
    {
        return base.GetAllModule(ModuleID);
    }

    public override System.Data.DataTable GetAllPageByModuleID(int? ModuleID)
    {
        return base.GetAllPageByModuleID(ModuleID);
    }
}