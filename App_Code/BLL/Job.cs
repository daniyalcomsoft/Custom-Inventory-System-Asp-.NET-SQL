//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:2.0.50727.5420
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using SCGL.DAL;
using System;
using System.Collections.Generic;
using System.Data;


namespace SCGL.BAL
{


    public class Job : DAL_Job
    {
        
        #region Private Properties
        // ======================== Properties ========================
        private int _JobID;
        
        private string _JobNumber;
        
        private string _JobDescription;
        
        private int _CustomerID;

        private string _CustomerName;
        
        private string _ContactNo;
        
        private string _Container;

        private string _ContainerNo;

        private DateTime _ContainerDate;
        
        private string _IGMNo;

        private DateTime _IGMDate;
        
        private string _IndexNo;
        
        private string _SS;

        private string _QTY;
        
        private string _BECashNo;

        private string _MachineNo;

        private DateTime _MachineDate;
        
        private DateTime _DeliveryDate;

        private decimal _CNFValue;

        private decimal _ImportValue;

        private string _LCNo;

        private string _BLNo;

        private int _ShippingLineID;
        
        private DateTime _StartDate;
        
        private DateTime _EndDate;
        
        private bool _Completed;

        #endregion
        
        #region Constructor
        public Job()
        {
        }
        #endregion
        
        #region Property Method
        // ======================= Property Method ======================
        public int JobID
        {
            get
            {
                return this._JobID;
            }
            set
            {
                this._JobID = value;
            }
        }
        
        public string JobNumber
        {
            get
            {
                return this._JobNumber;
            }
            set
            {
                this._JobNumber = value;
            }
        }
        
        public string JobDescription
        {
            get
            {
                return this._JobDescription;
            }
            set
            {
                this._JobDescription = value;
            }
        }
        
        public int CustomerID
        {
            get
            {
                return this._CustomerID;
            }
            set
            {
                this._CustomerID = value;
            }
        }

        public string CustomerName
        {
            get
            {
                return this._CustomerName;
            }
            set
            {
                this._CustomerName = value;
            }
        }
        
        public string ContactNo
        {
            get
            {
                return this._ContactNo;
            }
            set
            {
                this._ContactNo = value;
            }
        }
        
        public string Container
        {
            get
            {
                return this._Container;
            }
            set
            {
                this._Container = value;
            }
        }

        public string ContainerNo
        {
            get
            {
                return this._ContainerNo;
            }
            set
            {
                this._ContainerNo = value;
            }
        }

        public DateTime ContainerDate
        {
            get
            {
                return this._ContainerDate;
            }
            set
            {
                this._ContainerDate = value;
            }
        }
        
        public string IGMNo
        {
            get
            {
                return this._IGMNo;
            }
            set
            {
                this._IGMNo = value;
            }
        }

        public DateTime IGMDate
        {
            get
            {
                return this._IGMDate;
            }
            set
            {
                this._IGMDate = value;
            }
        }
        
        public string IndexNo
        {
            get
            {
                return this._IndexNo;
            }
            set
            {
                this._IndexNo = value;
            }
        }
        
        public string SS
        {
            get
            {
                return this._SS;
            }
            set
            {
                this._SS = value;
            }
        }

        public string QTY
        {
            get
            {
                return this._QTY;
            }
            set
            {
                this._QTY = value;
            }
        }
        
        public string BECashNo
        {
            get
            {
                return this._BECashNo;
            }
            set
            {
                this._BECashNo = value;
            }
        }

        public string MachineNo
        {
            get
            {
                return this._MachineNo;
            }
            set
            {
                this._MachineNo = value;
            }
        }

        public DateTime MachineDate
        {
            get
            {
                return this._MachineDate;
            }
            set
            {
                this._MachineDate = value;
            }
        }
        
        public DateTime DeliveryDate
        {
            get
            {
                return this._DeliveryDate;
            }
            set
            {
                this._DeliveryDate = value;
            }
        }

        public decimal CNFValue
        {
            get
            {
                return this._CNFValue;
            }
            set
            {
                this._CNFValue = value;
            }
        }

        public decimal ImportValue
        {
            get
            {
                return this._ImportValue;
            }
            set
            {
                this._ImportValue = value;
            }
        }

        public string LCNo
        {
            get
            {
                return this._LCNo;
            }
            set
            {
                this._LCNo = value;
            }
        }

        public string BLNo
        {
            get
            {
                return this._BLNo;
            }
            set
            {
                this._BLNo = value;
            }
        }

        public int ShippingLineID
        {
            get
            {
                return this._ShippingLineID;
            }
            set
            {
                this._ShippingLineID = value;
            }
        }
        
        public DateTime StartDate
        {
            get
            {
                return this._StartDate;
            }
            set
            {
                this._StartDate = value;
            }
        }
        
        public DateTime EndDate
        {
            get
            {
                return this._EndDate;
            }
            set
            {
                this._EndDate = value;
            }
        }
        
        public bool Completed
        {
            get
            {
                return this._Completed;
            }
            set
            {
                this._Completed = value;
            }
        }
        #endregion
        
        #region Public Method
        // =========================== Public Method =========================
        public override int Create(Job p)
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

        public override Job Read(int p)
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
        
        public override List<Job> Read()
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

        public override List<Job> ReadByJobNumber(string Number)
        {
            try
            {
                return base.ReadByJobNumber(Number);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override Job GetJobByJobNumber(string JobNumber)
        {
            try
            {
                return base.GetJobByJobNumber(JobNumber);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override bool Update(Job p)
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
        public override int CheckExsistingJob(int JobID)
        {
            return base.CheckExsistingJob(JobID);
        }
        public override int CheckExsistingJobNumber(string JobNumber)
        {
            return base.CheckExsistingJobNumber(JobNumber);
        }
    }
}
