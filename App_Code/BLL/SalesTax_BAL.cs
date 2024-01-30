using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

/// <summary>
/// Summary description for SalesTax_BAL
/// </summary>
public class SalesTax_BAL : SalesTax_DAL
{
    public int TaxDetailID { get; set; }
    public string FromDate { get; set; }
    public string ToDate { get; set; }
    public decimal ServiceTax { get; set; }
    public decimal HoldTax { get; set; }
    public decimal IncomeTax { get; set; }
    public DateTime Date { get; set; }
    public int User { get; set; }
    public int TaxRuleID { get; set; }
    public string TaxRule { get; set; }
    public int ProvinceID { get; set; }
    public string Province { get; set; }




    public int SalesTaxInvoiceID { get; set; }








    //Sales Tax Invoice
   
    public int JobID { get; set; }
    public string Packages { get; set; }
    public string RefNo { get; set; }
    public decimal ServiceCharges { get; set; }
    public decimal OUE { get; set; }
    public decimal AmtAT { get; set; }
   
    public SalesTax_BAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public override DataTable getSalesTax()
    {
        return base.getSalesTax();
    }
    public override SalesTax_BAL GetSalesTaxByID(int SalesTaxID)
    {
        return base.GetSalesTaxByID(SalesTaxID);
    }
    public override string DeleteSalesTax(int TaxDetailID)
    {
        return base.DeleteSalesTax(TaxDetailID);
    }
    public override int CreateModifySalesTax(SalesTax_BAL FY, Sessions PSMS)
    {
        return base.CreateModifySalesTax(FY, PSMS);
    }
    public override int CountSalesTaxOverlapPeriods(int SalesTaxID, DateTime StartDate, DateTime EndDate)
    {
        return base.CountSalesTaxOverlapPeriods(SalesTaxID, StartDate, EndDate);
    }
    //public override int CreateModifySalesTaxInvoice(SalesTax_BAL BALSalesTax, System.Data.SqlClient.SqlTransaction Trans)
    //{
    //    return base.CreateModifySalesTaxInvoice(BALSalesTax, Trans);
    //}
    //public override bool CreateSalesTaxInvoiceGLTrans(SalesTax_BAL BALSalesTax, System.Data.SqlClient.SqlTransaction Trans)
    //{
    //    return base.CreateSalesTaxInvoiceGLTrans(BALSalesTax, Trans);
    //}
    public override int DeleteTransaction_SalesTaxInvoice(int SalesTaxInvoiceID, System.Data.SqlClient.SqlTransaction Trans)
    {
        return base.DeleteTransaction_SalesTaxInvoice(SalesTaxInvoiceID, Trans);
    }
    public override DataTable getSalesTaxInvoiceByID(int SalesTaxID)
    {
        return base.getSalesTaxInvoiceByID(SalesTaxID);
    }
    public override DataTable getallSalesTaxInvoices()
    {
        return base.getallSalesTaxInvoices();
    }
    public override bool DeleteSalesTaxInvoice(int SalesTaxID, System.Data.SqlClient.SqlTransaction Trans)
    {
        return base.DeleteSalesTaxInvoice(SalesTaxID, Trans);
    }
    //public override int CountAlreadyExistsSTI(SalesTax_BAL BALSalesTax)
    //{
    //    return base.CountAlreadyExistsSTI(BALSalesTax);
    //}
}
