using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Session
/// </summary>
public class Sessions
{
	public Sessions()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public DataTable PermissionTable = new DataTable();
    public DataTable MenuTable = new DataTable();
    public DataTable SubMenuTable = new DataTable();
    public DataTable PageTable = new DataTable();
    public int RoleID { get; set; }
    public int UserID { get; set; }  
    public string UserName { get; set; }
    public string UserFullName { get; set; }
    public string RoleName { get; set; }
    public bool Can_Insert { get; set; }
    public bool Can_Update { get; set; }
    public bool Can_Delete { get; set; }
    public bool Can_View { get; set; }
    public string Permission { get; set; }
    public string PageRefrence { get; set; }
    public string rptColor { get; set; }
    public string FolderName { get; set; }
    public string Server { get; set; }
    public string Database { get; set; }
    public string dbUser { get; set; }
    public string dbPassword { get; set; }
    public string CompanyName { get; set; }
    public string Theme { get; set; }

    public int FinYearID { get; set; }
    public string UserIP { get; set; }
    public int? SiteID { get; set; }
    public bool isRoot { get; set; }
}