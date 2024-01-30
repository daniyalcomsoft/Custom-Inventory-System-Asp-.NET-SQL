using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using SW.SW_Common;
using System.Data.SqlClient;
using SQLHelper;

/// <summary>
/// Summary description for SalesTax_DAL
/// </summary>
public class SalesTax_DAL
{
	public SalesTax_DAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public virtual DataTable getSalesTax()
    {
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, "SP_GetTaxDetailData").Tables[0];

    }


    //public virtual DataTable getalloverFinancialYear()
    //{
    //    return SqlHelper.ExecuteDataset(ConnectionString.PSMS, "vt_SCGL_SpGetallFinYear").Tables[0];

    //}

    public virtual SalesTax_BAL GetSalesTaxByID(int TaxDetialID)
    {
        SalesTax_BAL FBLL = new SalesTax_BAL();
        SqlParameter[] param = { new SqlParameter("@TaxDetialID", TaxDetialID) };
        using (SqlDataReader dr = SqlHelper.ExecuteReader(ConnectionString.PSMS, "SP_GetTaxDetailByID", param))
        {
            if (dr.Read())
            {
                FBLL.TaxDetailID = SCGL_Common.Convert_ToInt(dr["TaxDetailID"]);
                FBLL.FromDate = dr["FromDate"].ToString();
                FBLL.ToDate = dr["ToDate"].ToString();
                FBLL.ServiceTax = Convert.ToDecimal(dr["ServiceTax"]);
                FBLL.HoldTax = Convert.ToDecimal(dr["HoldTax"]);
                FBLL.IncomeTax = Convert.ToDecimal(dr["IncomeTax"]);
                FBLL.TaxRuleID = Convert.ToInt32(dr["TaxRuleID"]);
                FBLL.ProvinceID = Convert.ToInt32(dr["ProvinceID"]);
            }
        }
        return FBLL;
    }

    public virtual string DeleteSalesTax(int TaxDetailID)
    {
        SqlParameter[] param = {
            new SqlParameter("@TaxDetailID", TaxDetailID)
        };
        return SqlHelper.ExecuteScalar(ConnectionString.PSMS, "SP_DeleteTaxDetails", param).ToString();
    }

    public virtual int CreateModifySalesTax(SalesTax_BAL TD, Sessions PSMS)
    {
        SqlParameter[] param = {new SqlParameter("@TaxDetailID", TD.TaxDetailID)
                                   ,new SqlParameter("@FromDate", TD.FromDate)
                                   ,new SqlParameter("@ToDate", TD.ToDate)
                                   ,new SqlParameter("@ServiceTax", TD.ServiceTax)
                                   ,new SqlParameter("@HoldTax", TD.HoldTax)
                                   ,new SqlParameter("@IncomeTax", TD.IncomeTax)
                                   ,new SqlParameter("@Date", TD.Date)
                                   ,new SqlParameter("@User", TD.User)
                                   ,new SqlParameter("@TaxRuleID", TD.TaxRuleID)
                                   ,new SqlParameter("@ProvinceID", TD.ProvinceID)
        };
        return Convert.ToInt32(SqlHelper.ExecuteScalar(ConnectionString.PSMS, "SP_InsertUpdateTaxDetails", param));
    }


    //public virtual int SetDefaultSalesTaxYear(int SalesTaxID)
    //{
    //    SqlParameter[] param = { new SqlParameter("@SalesTaxID", SalesTaxID) };
    //    return Convert.ToInt32(SqlHelper.ExecuteScalar(ConnectionString.PSMS, "vt_SCGL_SetDefaultYear", param));
    //}

    public virtual int CountSalesTaxOverlapPeriods(int TaxDetailID, DateTime FromDate, DateTime ToDate)
    {
        SqlParameter[] param = {new SqlParameter("@TaxDetailID", TaxDetailID)
                                ,new SqlParameter("@FromDate", FromDate)
                                ,new SqlParameter("@ToDate", ToDate)};
        return Convert.ToInt32(SqlHelper.ExecuteScalar(ConnectionString.PSMS, "SP_CounttaxDetailOverlapPeriod", param));
    }

    //public virtual int CreateModifySalesTaxInvoice(SalesTax_BAL BALSalesTax, SqlTransaction Trans)
    //{
    //    SqlParameter[] param = {
    //                                new SqlParameter("@SalesTaxID", BALSalesTax.SalesTaxID)
    //                               ,new SqlParameter("@SalesTaxInvoiceID", BALSalesTax.SalesTaxInvoiceID)
    //                               ,new SqlParameter("@Date", BALSalesTax.Date)
    //                               ,new SqlParameter("@JobID",BALSalesTax.JobID)
    //                               ,new SqlParameter("@Packages",BALSalesTax.Packages)
    //                               ,new SqlParameter("@RefNo",BALSalesTax.RefNo)
    //                               ,new SqlParameter("@ServiceCharges",BALSalesTax.ServiceCharges)
    //                               ,new SqlParameter("@OUE",BALSalesTax.OUE)
    //                               ,new SqlParameter("@AmtAT",BALSalesTax.AmtAT)
                                 
    //                           };
    //    int i = Convert.ToInt32(SqlHelper.ExecuteScalar(Trans, CommandType.StoredProcedure, "SP_CreateModifySalesTaxInvoice", param));
    //    return i;
    //}

    //public virtual bool CreateSalesTaxInvoiceGLTrans(SalesTax_BAL BALSalesTax, SqlTransaction Trans)
    //{
    //    SqlParameter[] param = {
    //                                new SqlParameter("@SalesTaxID", BALSalesTax.SalesTaxID)
    //                               ,new SqlParameter("@Date", BALSalesTax.Date)
    //                               ,new SqlParameter("@JobID",BALSalesTax.JobID)
    //                               ,new SqlParameter("@ServiceCharges",BALSalesTax.ServiceCharges)
    //                               ,new SqlParameter("@AmtAT",BALSalesTax.AmtAT)
                                 
    //                           };
    //    int i = SqlHelper.ExecuteNonQuery(Trans, "SP_CreateSalesTaxInvoiceGLTrans", param);
    //    return i > 0;
    //}

    public virtual int DeleteTransaction_SalesTaxInvoice(int SalesTaxInvoiceID, SqlTransaction Trans)
    {
        SqlParameter param = new SqlParameter("@SalesTaxInvoiceID", SalesTaxInvoiceID);
        return Convert.ToInt32(SqlHelper.ExecuteScalar(Trans, "SP_DeleteTransaction_SalesTaxInvoice", param));
    }

    public virtual DataTable getSalesTaxInvoiceByID(int SalesTaxID)
    {
        SqlParameter param = new SqlParameter("@SalesTaxID", SalesTaxID);
        DataTable dt = SqlHelper.ExecuteDataset(ConnectionString.PSMS, "SP_GetSalesTaxInvoice", param).Tables[0];
        return dt;
    }

    public virtual DataTable getallSalesTaxInvoices()
    {
        DataTable dt = SqlHelper.ExecuteDataset(ConnectionString.PSMS, "SP_GetallSalesTaxInvoices").Tables[0];
        return dt;
    }

    public virtual bool DeleteSalesTaxInvoice(int SalesTaxID, SqlTransaction Trans)
    {
        SqlParameter param = new SqlParameter("@SalesTaxID", SalesTaxID);
        int i = SqlHelper.ExecuteNonQuery(Trans, "SP_DeleteSalesTaxInvoice", param);
        return i > 0;
    }
    //public virtual int CountAlreadyExistsSTI(SalesTax_BAL BALSalesTax)
    //{
    //    SqlParameter[] param = {new SqlParameter("@SalesTaxID", BALSalesTax.SalesTaxID)
    //                            ,new SqlParameter("@SalesTaxInvoiceID", BALSalesTax.SalesTaxInvoiceID)
    //                           };
    //    return Convert.ToInt32(SqlHelper.ExecuteScalar(ConnectionString.PSMS, "SP_CountAlreadyExistsSTI", param));
    //}

    public virtual DataTable GetSalesTax(object TaxRuleID)
    {
        SqlParameter[] Gparam = {
                                    new SqlParameter("@TaxRuleID",TaxRuleID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetSalesTax", Gparam).Tables[0];
    }

    public virtual DataTable GetTaxDetailByTaxRule(object TaxRuleID)
    {
        SqlParameter[] Gparam = {
                                    new SqlParameter("@TaxRuleID",TaxRuleID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetTaxDetailDataByTaxRule", Gparam).Tables[0];
    }

}
