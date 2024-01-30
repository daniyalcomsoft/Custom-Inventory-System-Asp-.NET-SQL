using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for GLCashRecVoucher_BAL
/// </summary>
public class GLCashRecVoucher_BAL:GLCashRecVoucher_DAL
{
    public int TransactionID { get; set; }
    public int? VoucherTypeID { get; set; }
    public string VoucherTypeName { get; set; }
    public string VoucherNumber { get; set; }
    public string ReferenceNo { get; set; }
    public string Narration { get; set; }
    public DateTime VoucharDate { get; set; }
    public string Dimension { get; set; }
    public string MainCode { get; set; }
    public string ControlCode { get; set; }
    public string SubsidiaryCode { get; set; }
    public string Code { get; set; }
    public double? Debit { get; set; }
    public double? Credit { get; set; }
    public int? CostCenterID { get; set; }
    public string Remarks { get; set; }
    public Int16? IsActive { get; set; }
    public bool? IsPosted { get; set; }
    public int FinYearID { get; set; }
    public int JobID { get; set; }
    public string Name { get; set; }
    public string ChequeNo { get; set; }
    public DateTime? ChequeDate { get; set; }
    public string MemoNo { get; set; }
    public string OnAccOff { get; set; }
    public string ProjectID { get; set; }
    public string MaintanenceID { get; set; }
    public string Goods { get; set; }
    public string Services { get; set; }
    public decimal Total { get; set; }
    public string VoucherType { get; set; }






    public GLCashRecVoucher_BAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public override System.Data.DataSet GetCashRecVoucherRecord(string VoucherNumber)
    {
        return base.GetCashRecVoucherRecord(VoucherNumber);
    }
    public override System.Data.DataTable GetSubAccNameCashRecievedVoucherLike(string Match)
    {
        return base.GetSubAccNameCashRecievedVoucherLike(Match);
    }
    public override System.Data.DataSet InsertUpdateTransaction(GLCashRecVoucher_BAL BO, Sessions PSMS, System.Data.DataTable TransTable)
    {
        return base.InsertUpdateTransaction(BO, PSMS, TransTable);
    }
    
}
