using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using SQLHelper;
using System.Data.SqlClient;

/// <summary>
/// Summary description for Dashboard_DAL
/// </summary>
public class Dashboard_DAL
{
    public Dashboard_DAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public virtual DataTable GetKPIInfo()
    {
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetKPIInfo").Tables[0];
    }
    public virtual DataSet InsertYear()
    {

        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_InsertYear");
    }
    public virtual DataTable GetCompanyPercentage()
    {
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetCompanyPercentage").Tables[0];
    }
    public virtual int UpdatePercentage(int PaymentTypeID, decimal Percentage)
    {
        SqlParameter[] param = {new SqlParameter("@PaymentTypeID",PaymentTypeID)
                                    ,new SqlParameter("@Percentage",Percentage)

                               };
        return Convert.ToInt32(SqlHelper.ExecuteNonQuery(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_UpdatePercentage]", param));
    }
}