using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using SQLHelper;

/// <summary>
/// Summary description for Company_DAL
/// </summary>
public class Company_DAL
{
	public Company_DAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public virtual DataTable BindCompany()
    {
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_BindCompany").Tables[0];
    }
}