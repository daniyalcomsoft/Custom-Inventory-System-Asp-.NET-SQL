using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using SW.SW_Common;
using SQLHelper;

/// <summary>
/// Summary description for GLCashRecVoucher_DAL
/// </summary>
public class GLCashRecVoucher_DAL
{
	public GLCashRecVoucher_DAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    
    public virtual DataTable GetSubAccNameCashRecievedVoucherLike(string Match)
    {
        DataTable dt = new DataTable();
        SqlParameter[] param = { new SqlParameter("@Match", Match) };
        return dt = SqlHelper.ExecuteDataset(ConnectionString.PSMS, "SP_GetSubCodeCashRecievedVoucherLike", param).Tables[0];
    }
    public virtual DataSet InsertUpdateTransaction(GLCashRecVoucher_BAL BO, Sessions PSMS, DataTable TransTable)
    {
        DataSet ds = new DataSet();
        DataSet dset = new DataSet();
        string VoucherNumber = string.Empty;
        using (SqlConnection con = new SqlConnection(ConnectionString.PSMS))
        {
            if (con.State == ConnectionState.Closed)
                con.Open();
            using (SqlTransaction trans = con.BeginTransaction())
            {
                try
                {
                    if (BO.VoucherNumber == "")
                    {
                        SqlParameter[] param = { new SqlParameter("@VoucherTypeID", BO.VoucherTypeID) };
                        VoucherNumber = SqlHelper.ExecuteScalar(trans, "SP_GetNewVoucherNumber", param).ToString();
                        BO.VoucherNumber = VoucherNumber;
                    }
                    SqlParameter[] _DebitParam = {new SqlParameter("@TransactionID",BO.TransactionID)
                                                   ,new SqlParameter("@Sno",null)
                                                   ,new SqlParameter("@VoucherTypeID",BO.VoucherTypeID) 
                                                   ,new SqlParameter("@VoucherTypeName",BO.VoucherTypeName) 
                                                   ,new SqlParameter("@VoucherNumber",BO.VoucherNumber) 
                                                   ,new SqlParameter("@ReferenceNo",BO.ReferenceNo)
                                                   ,new SqlParameter("@Narration",BO.Narration)
                                                   ,new SqlParameter("@VoucharDate",BO.VoucharDate)
                                                   ,new SqlParameter("@Dimension",BO.Dimension)
                                                   ,new SqlParameter("@Code",BO.Code) 
                                                   ,new SqlParameter("@Debit",BO.Debit) 
                                                   ,new SqlParameter("@Credit",BO.Credit) 
                                                   ,new SqlParameter("@CostCenterID",BO.CostCenterID) 
                                                   ,new SqlParameter("@Remarks",BO.Narration)
                                                   //,new SqlParameter("@Remarks",BO.Remarks) 
                                                   ,new SqlParameter("@ActivityBy",PSMS.UserID)
                                                   ,new SqlParameter("@ActivityDate",DateTime.UtcNow.ToString())
                                                   ,new SqlParameter("@SiteID",PSMS.SiteID)
                                                   ,new SqlParameter("@IP",PSMS.UserIP)
                                                   ,new SqlParameter("@IsActive",BO.IsActive) 
                                                   ,new SqlParameter("@IsPosted",BO.IsPosted)
                                                   ,new SqlParameter("@FinYearID",BO.FinYearID)
                                                   ,new SqlParameter("@JobID",BO.JobID)
                                                   ,new SqlParameter("@Name",BO.Name)
                                                   ,new SqlParameter("@ChequeNo", BO.ChequeNo)
                                                   ,new SqlParameter("@ChequeDate",BO.ChequeDate)
                                                   ,new SqlParameter("@MemoNo",BO.MemoNo)
                                                   ,new SqlParameter("@OnAccOff",BO.OnAccOff)
                                                   ,new SqlParameter("@ProjectID",BO.ProjectID)
                                                   ,new SqlParameter("@MaintanenceID",BO.MaintanenceID)
                                                   ,new SqlParameter("@Goods",BO.Goods)
                                                   ,new SqlParameter("@Services",BO.Services)
                                                   ,new SqlParameter("@VoucherType", BO.VoucherType)
                    };
                    // SqlHelper.ExecuteNonQuery(trans, "vt_SCGL_SpInsertGeneralVoucherTransaction", DebitParam);
                    dset = SqlHelper.ExecuteDataset(trans, "SP_InsertGeneralVoucherTransaction", _DebitParam);
                    foreach (DataRow Row in TransTable.Rows)
                    {
                        SqlParameter[] _prams = {new SqlParameter("@TransactionID",Row["TransactionID"])
                                                   ,new SqlParameter("@Sno",Row["Sno"])
                                                   ,new SqlParameter("@VoucherTypeID",BO.VoucherTypeID) 
                                                   ,new SqlParameter("@VoucherTypeName",BO.VoucherTypeName) 
                                                   ,new SqlParameter("@VoucherNumber",BO.VoucherNumber) 
                                                   ,new SqlParameter("@ReferenceNo",BO.ReferenceNo)
                                                   ,new SqlParameter("@Narration",BO.Narration)
                                                   ,new SqlParameter("@VoucharDate",BO.VoucharDate)
                                                   ,new SqlParameter("@Dimension",BO.Dimension)
                                                   //,new SqlParameter("@MainCode",Row["MainCode"]) // BO.MainCode
                                                   //,new SqlParameter("@ControlCode",Row["ControlCode"]) //BO.ControlCode
                                                   //,new SqlParameter("@SubsidiaryCode",Row["SubCode"])//BO.SubsidiaryCode
                                                   ,new SqlParameter("@Code",Row["Code"]) //BO.Code
                                                   ,new SqlParameter("@Debit",Row["Debit"].Equals("")?null:Row["Debit"]) //BO.Debit
                                                   ,new SqlParameter("@Credit",Row["Credit"].Equals("")?null:Row["Credit"]) //BO.Credit
                                                   ,new SqlParameter("@CostCenterID",Row["CostCenterID"]) //BO.CostCenterID
                                                   ,new SqlParameter("@Remarks",Row["Remarks"]) //BO.Remarks
                                                   ,new SqlParameter("@ActivityBy",PSMS.UserID)
                                                   ,new SqlParameter("@ActivityDate",DateTime.UtcNow.ToString())
                                                   ,new SqlParameter("@SiteID",PSMS.SiteID)
                                                   ,new SqlParameter("@IP",PSMS.UserIP)
                                                   ,new SqlParameter("@IsActive",BO.IsActive) 
                                                   ,new SqlParameter("@IsPosted",BO.IsPosted)
                                                   ,new SqlParameter("@FinYearID",BO.FinYearID)
                                                   ,new SqlParameter("@JobID",BO.JobID)
                                                   ,new SqlParameter("@Name",Row["Name"])
                                                   ,new SqlParameter("@ChequeNo", Row["ChequeNo"])
                                                   ,new SqlParameter("@ChequeDate",Row["ChequeDate"])
                                                   ,new SqlParameter("@MemoNo",Row["MemoNo"])
                                                   ,new SqlParameter("@OnAccOff",Row["OnAccOff"])
                                                   ,new SqlParameter("@ProjectID",Row["ProjectID"])
                                                   ,new SqlParameter("@MaintanenceID",Row["MaintanenceID"])
                                                   ,new SqlParameter("@Goods",Row["Goods"])
                                                   ,new SqlParameter("@Services",Row["Services"]) 
                                                   ,new SqlParameter("@VoucherType", BO.VoucherType)                                                
                                                  
                        };
                        SqlHelper.ExecuteNonQuery(trans, "SP_InsertGeneralVoucherTransaction", _prams);
                    }
                    trans.Commit();
                    SqlParameter[] pram = { new SqlParameter("@VoucherNumber", BO.VoucherNumber) };
                    ds = SqlHelper.ExecuteDataset(ConnectionString.PSMS, "SP_GetTransactionCashRecieptVoucher", pram);
                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    throw ex;
                }
                if (dset.Tables.Count > 0)
                {
                    ds.Merge(dset.Tables[0]);
                }
                else
                {
                    return ds;
                }
            }
        }
        return ds;
    }

    public virtual DataSet GetCashRecVoucherRecord(string VoucherNumber)
    {
        SqlParameter[] pram = { new SqlParameter("@VoucherNumber", VoucherNumber) };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, "SP_GetTransactionCashRecieptVoucher", pram);
    }

    //public virtual DataSet GetTaxList(int SalesTaxID)
    //{
    //    SqlParameter[] pram = { new SqlParameter("@SalesTaxID", SalesTaxID) };
    //    return SqlHelper.ExecuteDataset(ConnectionString.PSMS, "Sp_GetSalesTaxList", pram);
    //}

    public virtual DataTable GetTaxList(object SalesTaxID)
    {
        SqlParameter[] Gparam = {
                                    new SqlParameter("@SalesTaxID",SalesTaxID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "Sp_GetSalesTaxList", Gparam).Tables[0];
    }

    //public virtual DataSet GetSalesTaxAmount()
    //{
    //    //SqlParameter[] pram = { new SqlParameter("@SalesTaxID", SalesTaxID) };
    //    //return SqlHelper.ExecuteDataset(ConnectionString.PSMS, "SP_GetSalesTaxAmount", pram);
    //    return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetSalesTaxAmount").Tables[0];
    //}

    public virtual DataTable GetSalesTaxAmount()
    {
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetSalesTaxAmount").Tables[0];
    }
}
