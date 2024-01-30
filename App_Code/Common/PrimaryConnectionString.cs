using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ConnectionString
/// </summary>
public class PrimaryConnectionString
{
	public PrimaryConnectionString()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static string PrimaryCon
    {
        get
        {
            if (ConfigurationManager.ConnectionStrings["PSMS"] == null)
            {
                return null;
            }
            string myCon = ConfigurationManager.ConnectionStrings["PSMS"].ToString();
            return myCon;
        }
    }

    public static string Conn
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