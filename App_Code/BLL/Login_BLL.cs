using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for User_BLL
/// </summary>
public class Login_BLL : Login_DAL
{
	public Login_BLL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public int CompanyCode { get; set; }
    public string Company { get; set; }
    public string Server { get; set; }
    public string DatabaseName { get; set; }
    public string DbUser { get; set; }
    public string DbPassword { get; set; }
    public string ContactPerson { get; set; }
    public string Phone { get; set; }
    public string Email { get; set; }
    public DateTime Created { get; set; }
    public DateTime Last_login { get; set; }

    public override System.Data.DataTable GetCompanyInfo(string Code)
    {
        return base.GetCompanyInfo(Code);
    }
}