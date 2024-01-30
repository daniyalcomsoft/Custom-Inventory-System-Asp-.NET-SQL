using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Province_BLL
/// </summary>
public class TaxInfo_BLL : TaxInfo_DAL
{
    public TaxInfo_BLL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public int TaxRuleID { get; set; }
    public string TaxRule { get; set; }  
    public int ProvinceID { get; set; }
    public string Province { get; set; }
    public int User { get; set; }
    public DateTime Date { get; set; }
 
  
}