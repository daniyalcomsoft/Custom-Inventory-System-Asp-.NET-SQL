using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Project_BLL
/// </summary>
public class Project_BLL : Project_DAL
{
    public Project_BLL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public int ProjectID { get; set; }
    public int BranchID { get; set; }
    public int NatureWorkID { get; set; }
    public string Description { get; set; }
    public string Floor { get; set; }
    public int VendorID { get; set; }
    public int Year { get; set; }
    public int VerificationStatus { get; set; }
    public DateTime BudgetDate { get; set; }
    public int TotalArea { get; set; }
    public decimal? BudgetAmount { get; set; }
    public string Status { get; set; }
    public string Department { get; set; }
    public DateTime Blocked { get; set; }
    public string BlockReason { get; set; } 
    public DateTime Date { get; set; }
    public int User { get; set; }
   
}