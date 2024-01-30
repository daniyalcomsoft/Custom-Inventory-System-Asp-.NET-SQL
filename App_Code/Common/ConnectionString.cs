using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ConnectionString
/// </summary>
public class ConnectionString
{
	public ConnectionString()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static string PSMS
    {
        get
        {
            Sessions PSMSSession = (Sessions)HttpContext.Current.Session["PSMSSession"];
            if (HttpContext.Current.Session["PSMSSession"] == null)
            {
                return null;
            }
            string myCon = "Data Source=" + PSMSSession.Server + ";Initial Catalog=" + PSMSSession.Database + ";User ID=" + PSMSSession.dbUser + ";Password=" + PSMSSession.dbPassword + ";Connect Timeout=1000";
            return myCon;
        }
    }

    public static string ASCS
    {
        get
        {
            if (ConfigurationManager.ConnectionStrings["ASCS"] == null)
            {
                return null;
            }
            string myCon = ConfigurationManager.ConnectionStrings["ASCS"].ToString();
            return myCon;
        }
    }
}