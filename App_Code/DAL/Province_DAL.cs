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
public class Province_DAL
{
    public Province_DAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}


    public virtual int InsertUpdateProvince(Province_BLL BL)
    {
        SqlParameter[] param = {new SqlParameter("@ProvinceID",BL.ProvinceID)
                                    , new SqlParameter("@Province",BL.Province)                                                                                                   
                                      ,new SqlParameter("@Date",BL.Date)
                                       ,new SqlParameter("@User",BL.User)
                               };
        return Convert.ToInt32(SqlHelper.ExecuteNonQuery(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_InsertUpdateProvince]", param));
    }



    public virtual bool ProvinceDelete(int ProvinceID)
    {
        SqlParameter[] Gparam = {
                                    new SqlParameter("@ProvinceID",ProvinceID)
                               };
        return Convert.ToBoolean(SqlHelper.ExecuteScalar(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_DeleteProvince", Gparam));
    }

    public virtual DataTable GetProvinceList(object ProvinceID)
    {
        SqlParameter[] Gparam = {
                                    new SqlParameter("@ProvinceID",ProvinceID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetProvinceList", Gparam).Tables[0];
    }
    public virtual DataTable GetCompanyList()
    {

        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetCompanyList").Tables[0];
    }
    public virtual DataTable GetProvinceListbySearch(object ProvinceID, object Province)
    {
        SqlParameter[] Gparam = {

                                     new SqlParameter("@ProvinceID",ProvinceID),
                                    new SqlParameter("@Province",Province),

                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetProvinceListbySearch", Gparam).Tables[0];
    }
}