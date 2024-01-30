using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Province_BLL
/// </summary>
public class Province_BLL : Province_DAL
{
    public Province_BLL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public int ProvinceID { get; set; }
    public string Province { get; set; }    
    public int User { get; set; }
    public DateTime Date { get; set; }
 
  
}