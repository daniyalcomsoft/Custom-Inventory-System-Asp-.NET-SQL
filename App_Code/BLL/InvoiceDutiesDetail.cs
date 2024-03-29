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
using SCGL.DAL;


namespace SCGL.BAL
{
    
    
    public class InvoiceDutiesDetail : DAL_InvoiceDutiesDetail
    {
        
        #region Private Properties
        // ======================== Properties ========================
        private int _InvoiceDutiesDetailID;
        
        private int _InvoiceID;

        private int _InvoiceDutiesDescID;

        private string _DutiesNumber;

        private string _DutiesRemarks;

        private string _DutiesDate;

        private decimal _DutiesByParty;

        private decimal _DutiesByUS;
        #endregion
        
        #region Constructor
        public InvoiceDutiesDetail()
        {
        }
        #endregion
        
        #region Property Method
        // ======================= Property Method ======================
        public int InvoiceDutiesDetailID
        {
            get
            {
                return this._InvoiceDutiesDetailID;
            }
            set
            {
                this._InvoiceDutiesDetailID = value;
            }
        }
        
        public int InvoiceID
        {
            get
            {
                return this._InvoiceID;
            }
            set
            {
                this._InvoiceID = value;
            }
        }

        public int InvoiceDutiesDescID
        {
            get
            {
                return this._InvoiceDutiesDescID;
            }
            set
            {
                this._InvoiceDutiesDescID = value;
            }
        }

        public string DutiesNumber
        {
            get
            {
                return this._DutiesNumber;
            }
            set
            {
                this._DutiesNumber = value;
            }
        }

        public string DutiesRemarks
        {
            get
            {
                return this._DutiesRemarks;
            }
            set
            {
                this._DutiesRemarks = value;
            }
        }

        public string DutiesDate
        {
            get
            {
                return this._DutiesDate;
            }
            set
            {
                this._DutiesDate = value;
            }
        }

        public decimal DutiesByParty
        {
            get
            {
                return this._DutiesByParty;
            }
            set
            {
                this._DutiesByParty = value;
            }
        }

        public decimal DutiesByUS
        {
            get
            {
                return this._DutiesByUS;
            }
            set
            {
                this._DutiesByUS = value;
            }
        }
        #endregion
        
        #region Public Method
        // =========================== Public Method =========================
        public override int Create(InvoiceDutiesDetail p)
        {
            try
            {
                return base.Create(p);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override InvoiceDutiesDetail Read(int p)
        {
            try
            {
                return base.Read(p);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
        public override DataTable ReadDataTable()
        {
            try
            {
                return base.ReadDataTable();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override List<InvoiceDutiesDetail> Read()
        {
            try
            {
                return base.Read();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override List<InvoiceDutiesDetail> ReadByInvoiceID(int InvoiceID)
        {
            try
            {
                return base.ReadByInvoiceID(InvoiceID);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override bool Update(InvoiceDutiesDetail p)
        {
            try
            {
                return base.Update(p);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
        public override bool Delete(int p)
        {
            try
            {
                return base.Delete(p);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion
    }
}
