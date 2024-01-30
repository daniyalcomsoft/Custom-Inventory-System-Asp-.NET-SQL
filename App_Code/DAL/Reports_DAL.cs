using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using SQLHelper;
using System.Data.SqlClient;

/// <summary>
/// Summary description for Reports_DAL
/// </summary>
public class Reports_DAL
{
    public Reports_DAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public virtual DataTable CurrentStockReport()
    {
       
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_CurrentStockReport").Tables[0];
    }
    public virtual DataTable CurrentPriceListReport(string Status)
    {
        SqlParameter[] param = {new SqlParameter("@Status",Status)                                  
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_CurrentPriceListReport", param).Tables[0];
    }
    public virtual DataTable GetMeasurementReport(int ProjectID,int? WorkCategoryID)
    {
        SqlParameter[] param = {new SqlParameter("@ProjectID",ProjectID)   ,new SqlParameter("@WorkCategoryID",WorkCategoryID == 0 ? null: WorkCategoryID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetMeasurementsReport", param).Tables[0];
    }
    public virtual DataTable GetBillActualReport(int ProjectID)
    {
        SqlParameter[] param = {new SqlParameter("@ProjectID",ProjectID)                                  
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetBillActualReport", param).Tables[0];
    }
    public virtual DataTable GetConsumptionReport(int ItemID, int Year)
    {
        SqlParameter[] param = {new SqlParameter("@ItemID",ItemID) ,new SqlParameter("@Year",Year)                                  
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetConsumptionReport", param).Tables[0];
    }
    public virtual DataTable GetMaintenanceConsumptionReport(int ItemID, int Year)
    {
        SqlParameter[] param = {new SqlParameter("@ItemID",ItemID) ,new SqlParameter("@Year",Year)                                  
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetMaintenanceConsumptionReport", param).Tables[0];
    }

    public virtual DataTable GetBillMaterialReport(int ProjectID)
    {
        SqlParameter[] param = {new SqlParameter("@ProjectID",ProjectID)                                  
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetBillMaterialReport", param).Tables[0];
    }
    public virtual DataTable GetBillServiceReport(int ProjectID)
    {
        SqlParameter[] param = {new SqlParameter("@ProjectID",ProjectID)                                  
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetBillServiceReport", param).Tables[0];
    }

    public virtual DataTable GetBudgetMemoReport(int Year)
    {
        SqlParameter[] param = {new SqlParameter("@Year",Year)                                  
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetBudgetMemoReport", param).Tables[0];
    }
    public virtual DataTable GetNonBudgetMemoReport(int Year)
    {
        SqlParameter[] param = {new SqlParameter("@Year",Year)                                  
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetNonBudgetMemoReport", param).Tables[0];
    }
    public virtual DataTable GetPaymentRequestReport(string RequestNo)
    {
        SqlParameter[] Gparam = {
                                    
                                     new SqlParameter("@RequestNo",RequestNo)                              
                                   
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetPaymentRequestDetailsReport", Gparam).Tables[0];
    }

    //////

    public virtual DataTable GetMaintenanceMeasurementReport(int MaintenanceID)
    {
        SqlParameter[] param = {new SqlParameter("@MaintenanceID",MaintenanceID)                                  
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetMaintenanceMeasurementsReport", param).Tables[0];
    }
    public virtual DataTable GetShortBillActualReport(int MaintenanceID)
    {
        SqlParameter[] param = {new SqlParameter("@MaintenanceID",MaintenanceID)                                  
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetShortBillActualReport", param).Tables[0];
    }
    public virtual DataTable GetShortBillMaterialReport(int MaintenanceID)
    {
        SqlParameter[] param = {new SqlParameter("@MaintenanceID",MaintenanceID)                                  
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetShortBillMaterialReport", param).Tables[0];
    }

    public virtual DataTable GetShortBillServiceReport(int MaintenanceID)
    {
        SqlParameter[] param = {new SqlParameter("@MaintenanceID",MaintenanceID)                                  
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetShortBillServiceReport", param).Tables[0];
    }

    public virtual DataTable GetBudgetReport(int ProjectID)
    {
        SqlParameter[] param = {new SqlParameter("@ProjectID",ProjectID)                                  
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetBudgetReport", param).Tables[0];
    }

    public virtual DataTable GetShortPaymentRequestReport(string RequestNo)
    {
        SqlParameter[] Gparam = {
                                    
                                     new SqlParameter("@RequestNo",RequestNo)                              
                                   
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetShortPaymentRequestDetailsReport", Gparam).Tables[0];
    }

    public virtual DataTable GetBudgetDifferenceList(int ProjectID)
    {
        SqlParameter[] param = {new SqlParameter("@ProjectID",ProjectID)                                  
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetBudgetDifferenceList", param).Tables[0];
    }
    public virtual DataSet GetPaymentDetails()
    {

        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetPaymentDetailsReport");
    }
    public virtual DataSet GetShortPaymentDetailsReport()
    {

        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetShortPaymentDetailsReport");
    }
    public virtual DataTable GetBillActualMSReport(int ProjectID)
    {
        SqlParameter[] param = {new SqlParameter("@ProjectID",ProjectID)                                  
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetBillActualMSReport", param).Tables[0];
    }
    public virtual DataTable GetMaintenancePriceRangeReport(decimal PriceFrom, decimal PriceTo,string Status)
    {
        SqlParameter[] param = {new SqlParameter("@PriceFrom",PriceFrom)     ,new SqlParameter("@PriceTo",PriceTo)        ,new SqlParameter("@Status",Status)                               
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_GetMaintenancePriceRange]", param).Tables[0];
    }
    public virtual DataTable GetProjectPriceRangeReport(decimal PriceFrom, decimal PriceTo, string Status)
    {
        SqlParameter[] param = {new SqlParameter("@PriceFrom",PriceFrom)     ,new SqlParameter("@PriceTo",PriceTo)        ,new SqlParameter("@Status",Status)                               
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_GetProjectPriceRange]", param).Tables[0];
    }
    public virtual DataTable GetShortMeasurementsByDate(object FromDate, object ToDate, string Measurement)
    {
        SqlParameter[] param = {new SqlParameter("@FromDate",FromDate),new SqlParameter("@ToDate",ToDate) ,new SqlParameter("@Measurement",Measurement)                                                      
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetShortMeasurementsByDate", param).Tables[0];
    }
    public virtual DataTable GetDuplicateItemsReport()
    {
      
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetDuplicateItemReport").Tables[0];
    }

    public virtual DataTable GetMeasurementReportEmpty()
    {
       
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetEmptyItemListMeasurment").Tables[0];
    }

    public virtual DataTable GetProjectPaymentReport(int? PaymentTypeID, int? Year, int? Post)
    {
        SqlParameter[] param = {new SqlParameter("@PaymentTypeID",PaymentTypeID == 0 ? null : PaymentTypeID)
        ,new SqlParameter("@Year",Year == 0 ? null : Year )
        ,new SqlParameter("@IsPost",Post == -1 ? null : Post)
        
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_GetProjectPaymentReport]", param).Tables[0];
    }
    public virtual DataTable GetProjectWisePaymentReport(int ProjectID, int? Post)
    {
        SqlParameter[] param = {new SqlParameter("@ProjectID",ProjectID)
        ,new SqlParameter("@IsPost",Post == -1 ? null : Post)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_GetProjectWisePaymentReport]", param).Tables[0];
    }

    public virtual DataTable GetFullPaymentStatusReport(int? Year, int? CityID)
    {
        SqlParameter[] param = {
        new SqlParameter("@Year",Year == 0 ? null : Year )        
         ,new SqlParameter("@CityID",CityID == 0 ? null : CityID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_GetFullPaymentStatusReport]", param).Tables[0];
    }

    public virtual DataTable GetMaintenanceReport(object MaintenanceID, object BranchID, object Year)
    {
        SqlParameter[] param = {
        new SqlParameter("@MaintenanceID",MaintenanceID )
        ,new SqlParameter("@BranchID",BranchID )
          ,new SqlParameter("@Year",Year )

                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_GetMaintenanceReport]", param).Tables[0];
    }
    public virtual DataTable BranchDetailReport()
    {
        
                              
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_BranchDetailReport]").Tables[0];
    }

    public virtual DataTable GetWorkCategoryList(object WorkCategory)
    {
        SqlParameter[] Gparam = {
                                    new SqlParameter("@WorkCategoryID",WorkCategory)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetWorkCategoryList", Gparam).Tables[0];
    }
    public virtual DataTable GetQuotationReport(int ProjectID)
    {
        SqlParameter[] param = {new SqlParameter("@ProjectID",ProjectID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_GetQuotationReport]", param).Tables[0];
    }
    public virtual DataTable GetProjectforQuotationreport()
    {

        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_GetProjectforQuotationreport]").Tables[0];
    }

    public virtual DataTable GetCertificateReport(int ProjectID)
    {
        SqlParameter[] param = {new SqlParameter("@ProjectID",ProjectID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetCertificateReport", param).Tables[0];
    }
    public virtual DataTable GetMobilizationCertificateReport(int ProjectID)
    {
        SqlParameter[] param = {new SqlParameter("@ProjectID",ProjectID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_GetMobilizationCertificateReport]", param).Tables[0];
    }
    public virtual DataTable GetQuotationMeasureReport(int ProjectID, int? WorkCategoryID)
    {
        SqlParameter[] param = {new SqlParameter("@ProjectID",ProjectID)   ,new SqlParameter("@WorkCategoryID",WorkCategoryID == 0 ? null: WorkCategoryID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetQuotationMeasureReport", param).Tables[0];
    }

    public virtual DataTable GetProjects (object Search)
    {
        SqlParameter[] param = {new SqlParameter("@Search",Search)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_GetProject]", param).Tables[0];
    }
  public virtual DataTable GetProjectMeasurementLocked (object Search)
    {
        SqlParameter[] param = {new SqlParameter("@Search",Search)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_GetProjectMeasurementLocked]", param).Tables[0];
    }
    public virtual DataTable GetMaintenance (object Search)
    {
        SqlParameter[] param = {new SqlParameter("@Search",Search)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_GetMaintenance]", param).Tables[0];
    }
    public virtual DataTable GetBranchs (object Search)
    {
        SqlParameter[] param = {new SqlParameter("@Search",Search)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_GetBranchs]", param).Tables[0];
    }
    public virtual DataTable GetItem (object Search)
    {
        SqlParameter[] param = {new SqlParameter("@Search",Search)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_GetItem]", param).Tables[0];
    }
    public virtual DataTable GetCity(object Search)
    {
        SqlParameter[] Gparam = {
                                    new SqlParameter("@Search",Search)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetCity", Gparam).Tables[0];
    }
    public virtual DataTable GetWithinBudgetBillActualReport(int ProjectID)
    {
        SqlParameter[] param = {new SqlParameter("@ProjectID",ProjectID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetWithinBudgetBillActualReport", param).Tables[0];
    }
    public virtual DataTable GetAboveBudgetBillActualReport(int ProjectID)
    {
        SqlParameter[] param = {new SqlParameter("@ProjectID",ProjectID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetAboveBudgetBillActualReport", param).Tables[0];
    }



    // UnVerified Bill

    public virtual DataTable GetUnVerifiedBillActualReport(int ProjectID)
    {
        SqlParameter[] param = {new SqlParameter("@ProjectID",ProjectID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetUnVerifiedBillActualReport", param).Tables[0];
    }
    public virtual DataTable GetUnVerifiedBillMaterialReport(int ProjectID)
    {
        SqlParameter[] param = {new SqlParameter("@ProjectID",ProjectID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetUnVerifiedBillMaterialReport", param).Tables[0];
    }
    public virtual DataTable GetUnVerifiedBillServiceReport(int ProjectID)
    {
        SqlParameter[] param = {new SqlParameter("@ProjectID",ProjectID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetUnVerifiedBillServiceReport", param).Tables[0];
    }

    public virtual DataTable GetUnVerifiedWithinBudgetBillActualReport(int ProjectID)
    {
        SqlParameter[] param = {new SqlParameter("@ProjectID",ProjectID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetUnVerifiedWithinBudgetBillActualReport", param).Tables[0];
    }
    public virtual DataTable GetUnVerifiedAboveBudgetBillActualReport(int ProjectID)
    {
        SqlParameter[] param = {new SqlParameter("@ProjectID",ProjectID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetUnVerifiedAboveBudgetBillActualReport", param).Tables[0];
    }

    public virtual DataTable GetUnVerifiedMeasurementReport(int ProjectID, int? WorkCategoryID)
    {
        SqlParameter[] param = {new SqlParameter("@ProjectID",ProjectID)   ,new SqlParameter("@WorkCategoryID",WorkCategoryID == 0 ? null: WorkCategoryID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetUnVerifiedMeasurementReport", param).Tables[0];
    }

    public virtual DataTable TrialBalanceReport(string FromDate, int BranchID, int VendorID, string Status, int ProjectID)
    {
        SqlParameter[] param = {
             new SqlParameter("@FromDate",FromDate) 
            ,new SqlParameter("@BranchID",BranchID)
            ,new SqlParameter("@VendorID", VendorID)            
            ,new SqlParameter("@Status", Status)
            ,new SqlParameter("@ProjectID", ProjectID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_TrailBalanceReport", param).Tables[0];
    }


    public virtual DataTable SummaryofSalesTaxAdvanceIncomeTax(string Company, string PeriodFrom, string PeriodTo)
    {

        SqlParameter[] param = {new SqlParameter("@Company",Company)
                               ,new SqlParameter("@PeriodFrom",PeriodFrom)
                                ,new SqlParameter("@PeriodTo",PeriodTo)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_SummaryofSalesTaxAdvanceIncomeTax", param).Tables[0];
    }

    public virtual DataTable SalesIncomeTaxVendorWiseAndDetailsofReceipt(string Vendor, string PeriodFrom, string PeriodTo)
    {
        SqlParameter[] param = {new SqlParameter("@Vendor",Vendor)
                               ,new SqlParameter("@PeriodFrom",PeriodFrom)
                               ,new SqlParameter("@PeriodTo",PeriodTo)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_SalesIncomeTaxVendorWiseAndDetailsofReceipt", param).Tables[0];
    }

}