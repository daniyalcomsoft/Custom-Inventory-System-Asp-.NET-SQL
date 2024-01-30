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
public class TaxInfo_DAL
{
    public TaxInfo_DAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}


    public virtual int InsertUpdateTax(TaxInfo_BLL BL)
    {
        SqlParameter[] param = {new SqlParameter("@TaxRuleID",BL.TaxRuleID)
                                    , new SqlParameter("@TaxRule",BL.TaxRule)  
                                    , new SqlParameter("@ProvinceID", BL.ProvinceID)                                                                                                 
                                      ,new SqlParameter("@Date",BL.Date)
                                       ,new SqlParameter("@User",BL.User)
                                       
                               };
        return Convert.ToInt32(SqlHelper.ExecuteNonQuery(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_InsertUpdateTax", param));
    }



    public virtual bool TaxDelete(int TaxRuleID)
    {
        SqlParameter[] Gparam = {
                                    new SqlParameter("@TaxRuleID",TaxRuleID)
                               };
        return Convert.ToBoolean(SqlHelper.ExecuteScalar(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_DeleteTax", Gparam));
    }

    public virtual DataTable GetTaxList(object TaxRuleID)
    {
        SqlParameter[] Gparam = {
                                    new SqlParameter("@TaxRuleID",TaxRuleID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetTaxList", Gparam).Tables[0];
    }
    public virtual DataTable GetCompanyList()
    {

        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetCompanyList").Tables[0];
    }
    public virtual DataTable GetTaxListbySearch(object TaxRuleID, object TaxRule, object Province)
    {
        SqlParameter[] Gparam = {

                                     new SqlParameter("@TaxRuleID",TaxRuleID),
                                    new SqlParameter("@TaxRule",TaxRule),
                                    new SqlParameter("@Province", Province)

                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetTaxListbySearch", Gparam).Tables[0];
    }
}