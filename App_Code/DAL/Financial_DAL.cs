﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using SW.SW_Common;
using System.Data.SqlClient;
using SQLHelper;

/// <summary>
/// Summary description for Financial_DAL
/// </summary>
public class Financial_DAL
{
	public Financial_DAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public virtual DataTable getFinancialYear()
    {
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, "SP_GetFinYearData").Tables[0];
      
    }


    public virtual DataTable getalloverFinancialYear()
    {
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, "SP_GetallFinYear").Tables[0];

    }

    public virtual Financial_BAL GetFinancialYearByID(int FinYearID)
    {
        Financial_BAL FBLL = new Financial_BAL();
        SqlParameter[] param = { new SqlParameter("@FID", FinYearID)};
        using (SqlDataReader dr = SqlHelper.ExecuteReader(ConnectionString.PSMS, "SP_GetFinancialYearByID", param))
        {
            if (dr.Read())
            {
                FBLL.FinYearID = SCGL_Common.Convert_ToInt(dr["FinYearID"]);
                FBLL.FinYearTitle = dr["FinYearTitle"].ToString();
                //FBLL.YearFrom = Convert.ToDateTime(dr["YearFrom"]);
                FBLL.YearFrom = dr["YearFrom"].ToString();
                //FBLL.YearTo = Convert.ToDateTime(dr["YearTo"]);
                FBLL.YearTo = dr["YearTo"].ToString();
            }
        }
        return FBLL;
    }

    public virtual string DeleteFinancialYear(int FinYearID, string StartDate, string EndDate)
    {
        SqlParameter[] param = { new SqlParameter("@FID", FinYearID)                               
                               ,new SqlParameter("@StartDate", StartDate)
                               ,new SqlParameter("@EndDate", EndDate)};
        return SqlHelper.ExecuteScalar(ConnectionString.PSMS, "SP_DeleteFinancialYear", param).ToString();
    }
       
    public virtual int CreateModifyFinancial(Financial_BAL FY, Sessions PSMS)
    {
        SqlParameter[] param = {new SqlParameter("@FID",FY.FinYearID)
                                   ,new SqlParameter("@FYearTital",FY.FinYearTitle)
                                   ,new SqlParameter("@YearFrom",FY.YearFrom)
                                   ,new SqlParameter("@YearTo",FY.YearTo)};
        return Convert.ToInt32(SqlHelper.ExecuteScalar(ConnectionString.PSMS, "SP_CreateModifyFinancialYear", param));
    }

   
    public virtual int SetDefaultFinancialYear(int FinYearID)
    {
        SqlParameter[] param = { new SqlParameter("@mFinYearID", FinYearID) };
        return Convert.ToInt32(SqlHelper.ExecuteScalar(ConnectionString.PSMS, "SP_SetDefaultYear", param));
    }

    public virtual int CountOverlapPeriods(int FinYearID,DateTime StartDate, DateTime EndDate)
    {
        SqlParameter[] param = {new SqlParameter("@FinYearID", FinYearID)
                                ,new SqlParameter("@StartDate", StartDate)
                                ,new SqlParameter("@EndDate", EndDate)};
        return Convert.ToInt32(SqlHelper.ExecuteScalar(ConnectionString.PSMS, "SP_CountOverlapPeriod", param));
    }
}
