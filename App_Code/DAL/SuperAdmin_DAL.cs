using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using SW.SW_Common;
using System.Data;
using SQLHelper;

/// <summary>
/// Summary description for SuperAdmin_DAL
/// </summary>
public class SuperAdmin_DAL
{
	public SuperAdmin_DAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}


    public virtual int CreateModifySetup(SuperAdmin_BAL BO, Sessions PSMS)
    {
        SqlParameter[] param = {new SqlParameter("@SetupID",BO.SetupID)
                                   ,new SqlParameter("@SiteCode",BO.SiteCode)
                                   ,new SqlParameter("@Name", BO.Name)
                                   ,new SqlParameter("@SiteName",BO.SiteName)
                                   ,new SqlParameter("@Description",BO.Description)
                                   ,new SqlParameter("@CreatedDate",BO.CreatedDate)
                                   ,new SqlParameter("@Address",BO.Address)
                                   ,new SqlParameter("@ContactNumber",BO.ContactNumber)
                                   ,new SqlParameter("@ContactPerson",BO.ContactPerson)
                                   ,new SqlParameter("@ContactPersonDesg",BO.ContactPersonDesg)
                                   ,new SqlParameter("@ContactPersonEmail",BO.ContactPersonEmail)
                                   ,new SqlParameter("@CustomAgent",BO.CustomAgent)
                                   ,new SqlParameter("@SNTN",BO.SNTN)
                                   ,new SqlParameter("@SalesTaxRegNo",BO.SalesTaxRegNo)
                                   ,new SqlParameter("@Mod_Financials",BO.Mod_Financials)
                                   ,new SqlParameter("@Mod_DepositAccount",BO.Mod_DepositAccount)
                                   ,new SqlParameter("@Mod_TermDeposit",BO.Mod_TermDeposit)
                                   ,new SqlParameter("@Mod_Loan",BO.Mod_Loan)
                                   ,new SqlParameter("@CreatedBy",BO.CreatedBy)};
        return Convert.ToInt32(SqlHelper.ExecuteScalar(ConnectionString.PSMS, "SP_AddEditAdminSetup", param));
    }

    public virtual DataTable SelectSetupInfoBySetupID(SuperAdmin_BAL BO, Sessions PSMS)
    {
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, "SP_GetSetupInfoBySetupID").Tables[0];
    }
    public virtual DataTable GetSiteName()
    {
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, "SP_GetSitname").Tables[0];
    }
    public virtual int CreateModifyCostCenter(SuperAdmin_BAL BO, Sessions PSMS)
    {
        SqlParameter[] param = {new SqlParameter("@CostCenterID",BO.CostCenterID)
                                   ,new SqlParameter("@CostCenterName",BO.CostCenterName)
                                   ,new SqlParameter("@ActivityBy",PSMS.UserID)
                                   ,new SqlParameter("@ActivityDate",DateTime.UtcNow.ToString())
                                   ,new SqlParameter("@SiteID",PSMS.SiteID)
                                   ,new SqlParameter("@IP",PSMS.UserIP)
                                   ,new SqlParameter("@IsActive",BO.IsAction)};
        return Convert.ToInt32(SqlHelper.ExecuteScalar(ConnectionString.PSMS, "SP_CreateModifyCostCenter", param));
    }
    public virtual DataTable GetCostCenterTable()
    {
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetCostCenterTable").Tables[0];
    }
    public virtual DataTable GetCostCenterList()
    {
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetCostCenterList").Tables[0];
    }

    public virtual DataTable GetCostCenterListforProfitLoss()
    {
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetCostCenterListforProfitLoss").Tables[0];
    }

    public virtual string DeleteCostCenter(int CostCenterID)
    {
        SqlParameter[] param = { new SqlParameter("@CostCenterID", CostCenterID) };
        return SqlHelper.ExecuteScalar(ConnectionString.PSMS, "[SP_DeleteCostCenter]", param).ToString();
    }

    public virtual SuperAdmin_BAL GetCostCenterByID(int CostCenterID)
    {

        SuperAdmin_BAL BO = new SuperAdmin_BAL();
        SqlParameter[] param = { new SqlParameter("@CostCenterID", CostCenterID) };
        using (SqlDataReader dr = SqlHelper.ExecuteReader(ConnectionString.PSMS, "[SP_GetCostCenterByCenterID]", param))
        {
            if (dr.Read())
            {
                BO.CostCenterID = Convert.ToInt32(dr["CostCenterID"]);
                BO.CostCenterName = dr["CostCenterName"].ToString();
                BO.IsAction = Convert.ToInt16(dr["IsActive"]);
            }
        }
        return BO;
    }



    
}
