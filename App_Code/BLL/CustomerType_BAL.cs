using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Province_BLL
/// </summary>
public class CustomerType_BAL : CustomerType_DAL
{
    public CustomerType_BAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public int CustomerTypeID { get; set; }
    public string CustomerType { get; set; }    
    public int User { get; set; }
    public DateTime Date { get; set; }
 
  
}