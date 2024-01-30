using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using SQLHelper;

/// <summary>
/// Summary description for Province_DAL
/// </summary>
public class CustomerType_DAL
{
    public CustomerType_DAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}


    public virtual int InsertUpdateCustomerType(CustomerType_BAL BL)
    {
        SqlParameter[] param = {new SqlParameter("@CustomerTypeID",BL.CustomerTypeID)
                                    , new SqlParameter("@CustomerType",BL.CustomerType)
                                    ,new SqlParameter("@User",BL.User)
                                    ,new SqlParameter("@Date",BL.Date)
                               };
        return Convert.ToInt32(SqlHelper.ExecuteNonQuery(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_InsertUpdateCustomerType]", param));
    }



    public virtual bool DeleteCustomerType(int CustomerTypeID)
    {
        SqlParameter[] Gparam = {
                                    new SqlParameter("@CustomerTypeID",CustomerTypeID)
                               };
        return Convert.ToBoolean(SqlHelper.ExecuteScalar(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_DeleteCustomerType", Gparam));
    }

    public virtual DataTable GetCustomerTypeList(object CustomerTypeID)
    {
        SqlParameter[] Gparam = {
                                    new SqlParameter("@CustomerTypeID",CustomerTypeID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetCustomerTypeList", Gparam).Tables[0];
    }

    public virtual DataTable GetCustomerTypeListbySearch(object CustomerTypeID, object CustomerType)
    {
        SqlParameter[] Gparam = {

                                     new SqlParameter("@CustomerTypeID",CustomerTypeID),
                                    new SqlParameter("@CustomerType",CustomerType),

                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetCustomerTypeListbySearch", Gparam).Tables[0];
    }
}