//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:2.0.50727.5420
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using SCGL.BAL;
using SW.SW_Common;
using SCGL.BAL;
using SQLHelper;

namespace SCGL.DAL
{
    
    
    public class DAL_InvoiceDetail
    {
        
        #region Constructor
        public DAL_InvoiceDetail()
        {
        }
        #endregion
        
        #region Public Method
        // =========================== Public Method =========================
        public virtual int Create(InvoiceDetail p)
        {
            try
            {
                SqlParameter[] SqlParam = new SqlParameter[] {
                        new SqlParameter("InvoiceID", p.InvoiceID),
                        new SqlParameter("InvoiceDescID", p.InvoiceDescID),
                        new SqlParameter("Number", p.Number),
                        new SqlParameter("Remarks", p.Remarks),
                        new SqlParameter("Date", p.Date),
                        new SqlParameter("ByParty", p.ByParty),
                        new SqlParameter("ByUS", p.ByUS)};
                return Convert.ToInt32(SqlHelper.ExecuteScalar(ConnectionString.PSMS, "VT_SP_InvoiceDetail_Insert", SqlParam));
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
        public virtual InvoiceDetail Read(int p)
        {
            try
            {
                SqlParameter SqlParam = new SqlParameter("InvoiceDetailID", p);
                InvoiceDetail obj = new InvoiceDetail();
                using (SqlDataReader dr = SqlHelper.ExecuteReader(ConnectionString.PSMS, "VT_SP_InvoiceDetail_Read", SqlParam))
                {
                obj = DataReader(dr);
                }
                return obj;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
        public virtual DataTable ReadDataTable()
        {
            try
            {
                return SqlHelper.ExecuteDataset(ConnectionString.PSMS, "VT_SP_InvoiceDetail_Read").Tables[0];
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
        public virtual List<InvoiceDetail> Read()
        {
            try
            {
                List<InvoiceDetail> obj = new List<InvoiceDetail>();
                using (SqlDataReader dr = SqlHelper.ExecuteReader(ConnectionString.PSMS, "VT_SP_InvoiceDetail_Read"))
                {
                obj = ListDataReader(dr);
                }
                return obj;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public virtual List<InvoiceDetail> ReadByInvoiceID(int InvoiceID)
        {
            try
            {
                SqlParameter p = new SqlParameter("InvoiceID", InvoiceID);
                string query = "SELECT * FROM vt_SCGL_InvoiceDetail WHERE InvoiceID = @InvoiceID";
                List<InvoiceDetail> obj = new List<InvoiceDetail>();
                using (SqlDataReader dr = SqlHelper.ExecuteReader(ConnectionString.PSMS, CommandType.Text, query, p))
                {
                    obj = ListDataReader(dr);
                }
                return obj;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
        public virtual bool Update(InvoiceDetail p)
        {
            try
            {
                SqlParameter[] SqlParam = new SqlParameter[] {
                        new SqlParameter("InvoiceDetailID", p.InvoiceDetailID),
                        new SqlParameter("InvoiceID", p.InvoiceID),
                        new SqlParameter("InvoiceDescID", p.InvoiceDescID),
                        new SqlParameter("Number", p.Number),
                        new SqlParameter("Remarks", p.Remarks),
                        new SqlParameter("Date", p.Date),
                        new SqlParameter("ByParty", p.ByParty),
                        new SqlParameter("ByUS", p.ByUS)};
                int i = SqlHelper.ExecuteNonQuery(ConnectionString.PSMS, "VT_SP_InvoiceDetail_Update", SqlParam);
                return i >= 1;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
        public virtual bool Delete(int p)
        {
            try
            {
                SqlParameter SqlParam = new SqlParameter("InvoiceDetailID", p);
                int i = SqlHelper.ExecuteNonQuery(ConnectionString.PSMS, "VT_SP_InvoiceDetail_Delete", SqlParam);
                return i >= 1;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion
        
        #region Helper Method
        // =========================== Helper Method =========================
        private InvoiceDetail DataReader(SqlDataReader dr)
        {
            InvoiceDetail obj = new InvoiceDetail();
            try
            {
                if (dr.Read())
                {
                    obj.InvoiceDetailID = SCGL_Common.CheckInt(dr["InvoiceDetailID"]);
                    obj.InvoiceID = SCGL_Common.CheckInt(dr["InvoiceID"]);
                    obj.InvoiceDescID = SCGL_Common.CheckInt(dr["InvoiceDescID"]);
                    obj.Number = SCGL_Common.CheckString(dr["Number"]);
                    obj.Remarks = SCGL_Common.CheckString(dr["Remarks"]);
                    obj.Date = SCGL_Common.CheckString(dr["Date"]);
                    obj.ByParty = SCGL_Common.Convert_ToDecimal(dr["ByParty"]);
                    obj.ByUS = SCGL_Common.Convert_ToDecimal(dr["ByUS"]);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return obj;
        }
        
        private List<InvoiceDetail> ListDataReader(SqlDataReader dr)
        {
            List<InvoiceDetail> objList = new List<InvoiceDetail>();
            try
            {
               while(dr.Read())
               {
                InvoiceDetail obj = new InvoiceDetail();
                obj.InvoiceDetailID = SCGL_Common.CheckInt(dr["InvoiceDetailID"]);
                obj.InvoiceID = SCGL_Common.CheckInt(dr["InvoiceID"]);
                obj.InvoiceDescID = SCGL_Common.CheckInt(dr["InvoiceDescID"]);
                obj.Number = SCGL_Common.CheckString(dr["Number"]);
                obj.Remarks = SCGL_Common.CheckString(dr["Remarks"]);
                obj.Date = SCGL_Common.CheckString(dr["Date"]);
                obj.ByParty = SCGL_Common.Convert_ToDecimal(dr["ByParty"]);
                obj.ByUS = SCGL_Common.Convert_ToDecimal(dr["ByUS"]);
                objList.Add(obj);
               }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return objList;
        }
        #endregion
    }
}
