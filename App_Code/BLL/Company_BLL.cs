using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Company_BLL
/// </summary>
public class Company_BLL:Company_DAL
{
	public Company_BLL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public override System.Data.DataTable BindCompany()
    {
        return base.BindCompany();
    }
}