using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using SW.SW_Common;
using SQLHelper;

/// <summary>
/// Summary description for GLControl_DAL
/// </summary>
public class GLControl_DAL
{
	public GLControl_DAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public virtual bool IsControlCodeExists(string MainCode, string ControlCode)
    {
        bool IsExists = false;
        SqlParameter[] param = {new SqlParameter("@MainCode", MainCode) 
                                   ,new SqlParameter("@ControlCode", ControlCode) };
        return IsExists = Convert.ToBoolean(SqlHelper.ExecuteScalar(ConnectionString.PSMS, "SP_IsControlCodeExists", param));
    }

    public virtual DataTable GetAllControlMainAccType(string MainCode)
    {
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConnectionString.PSMS))
        {
            if (con.State == ConnectionState.Closed)
                con.Open();
            using (SqlTransaction trans = con.BeginTransaction())
            {
                try
                {
                    SqlParameter[] param = { new SqlParameter("@MainCode", MainCode) };
                    dt = SqlHelper.ExecuteDataset(trans, "SP_GetAllControlMainAccType", param).Tables[0];
                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    throw ex;
                }
                finally
                {
                    trans.Dispose();
                    con.Dispose();
                }
            }
        }
        return dt;
    }

    public virtual GLControl_BAL GetControlAccType(string MainCode, string ControlCode)
    {

        GLControl_BAL CtrlBO = new GLControl_BAL();
        SqlParameter[] param = {new SqlParameter("@MainCode", MainCode) 
                                   ,new SqlParameter("@ControlCode",ControlCode)};
        using (SqlDataReader dr = SqlHelper.ExecuteReader(ConnectionString.PSMS, "SP_GetControlAccType", param))
        {
            if (dr.Read())
            {
                CtrlBO.MainCode = dr["MainCode"].ToString();
                CtrlBO.ControlCode = dr["ControlCode"].ToString();
                CtrlBO.Title = dr["Title"].ToString();
                CtrlBO.IsActive = Convert.ToInt16(dr["IsActive"]);
                CtrlBO.Deleteable = Convert.ToBoolean(dr["Deleteable"]);
            }
        }
        return CtrlBO;
    }

    public virtual int InsertUpdateGLControl(GLControl_BAL ControlBO, Sessions PSMS)
    {
        SqlConnection con = new SqlConnection(ConnectionString.PSMS);
        if (con.State == ConnectionState.Closed)
            con.Open();
        SqlTransaction trans = con.BeginTransaction();
        int ControlCode = int.MinValue;
        try
        {
            SqlParameter[] param = {new SqlParameter("@MainCode",ControlBO.MainCode)
                                       ,new SqlParameter("@ControlCode",ControlBO.ControlCode)
                                       //,new SqlParameter("@ControlCodeWhere",ControlBO.ControlCodeWhere)
                                       ,new SqlParameter("@Title",ControlBO.Title)
                                       ,new SqlParameter("@ActivityBy",PSMS.UserID)
                                       ,new SqlParameter("@ActivityDate",DateTime.UtcNow.ToString())
                                       ,new SqlParameter("@SiteID",PSMS.SiteID)
                                       ,new SqlParameter("@UserIP",PSMS.UserIP)
                                       ,new SqlParameter("@IsActive",ControlBO.IsActive)
                                       };
            ControlCode = Convert.ToInt32(SqlHelper.ExecuteScalar(trans, "SP_InsertUpdateGLControl", param));
            trans.Commit();
        }
        catch (Exception ex)
        {
            trans.Rollback();
            throw ex;
        }
        finally
        {
            trans.Dispose();
            if (con.State == ConnectionState.Open)
                con.Close();
            con.Dispose();
        }
        return ControlCode;
    }

    public virtual int DeleteControlCodeNotInUse(string MainCode, string ControlCode)
    {
        SqlParameter[] param = {new SqlParameter("@MainCode", MainCode)
                                   ,new SqlParameter("@ControlCode", ControlCode)};
        return Convert.ToInt32(SqlHelper.ExecuteScalar(ConnectionString.PSMS, "SP_DeleteControlCodeNotInUse", param));
    }
}
