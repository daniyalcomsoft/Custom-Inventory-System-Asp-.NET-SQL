using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using SQLHelper;

/// <summary>
/// Summary description for Project_DAL
/// </summary>
public class Project_DAL
{
    public Project_DAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public virtual int InsertUpdateProject(Project_BLL BL)
    {
        SqlParameter[] param = {new SqlParameter("@ProjectID",BL.ProjectID)
                                    , new SqlParameter("@BranchID",BL.BranchID)
                                    ,new SqlParameter("@VendorID",BL.VendorID)
                                     ,new SqlParameter("@NatureWorkID",BL.NatureWorkID)
                                      ,new SqlParameter("@Year",BL.Year)
                                       ,new SqlParameter("@VerificationStatus",BL.VerificationStatus)
                                     ,new SqlParameter("@TotalArea",BL.TotalArea)
                                      ,new SqlParameter("@Floor",BL.Floor)
                                      ,new SqlParameter("@Department",BL.Department)
                                      ,new SqlParameter("@Description",BL.Description)                                                                  
                                      ,new SqlParameter("@Date",BL.Date)
                                       ,new SqlParameter("@User",BL.User)
                                 
                               };
        return Convert.ToInt32(SqlHelper.ExecuteNonQuery(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_InsertUpdateProject", param));
    }


    public virtual DataTable GetProjectbySearch(object Project, object branch, object ven, object NatureOfWork, object Year, object Floor, object Description, object VerificationStatus, object Status)
    {
        SqlParameter[] Gparam = {
                                    
                                     new SqlParameter("@Project",Project),
                                    new SqlParameter("@Branch",branch),
                                     new SqlParameter("@Vendor",ven),
                                    new SqlParameter("@NatureOfWork",NatureOfWork),
                                     new SqlParameter("@Year",Year),
                                    new SqlParameter("@Floor",Floor),
                                    new SqlParameter("@Description",Description),
                                     new SqlParameter("@VerificationStatus",VerificationStatus),
                                    new SqlParameter("@Status",Status)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetProjectListbySearch", Gparam).Tables[0];
    }
    public virtual int DeleteProject(int ProjectID)
    {
        SqlParameter[] Gparam = {
                                    new SqlParameter("@ProjectID",ProjectID)
                               };
        return Convert.ToInt32(SqlHelper.ExecuteScalar(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_DeleteProject", Gparam));

    }
    public virtual DataTable GetProjectbyID(int ProjectID)
    {
        SqlParameter[] Gparam = {
                                    new SqlParameter("@ProjectID",ProjectID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_GetProjectByID]", Gparam).Tables[0];
    }
    public virtual DataTable GetNatureofWork()
    {

        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_GetNatureofWork]").Tables[0];
    }
    public virtual DataTable GetYearList()
    {

        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_GetProjectYearList]").Tables[0];
    }
    public virtual DataTable GetProjectStatusList()
    {

        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_GetProjectStatus]").Tables[0];
    }
    public virtual int BlockProject(int ProjectID, string Reason,DateTime Date,int User)
    {
        SqlParameter[] Gparam = {
                                    new SqlParameter("@ProjectID",ProjectID),
                                     new SqlParameter("@Reason",Reason),
                                      new SqlParameter("@Date",Date),
                                       new SqlParameter("@User",User)
                               };
        return Convert.ToInt32(SqlHelper.ExecuteScalar(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_BlockProject", Gparam));

    }
    public virtual int UnBlockProject(int ProjectID, DateTime Date, int User)
    {
        SqlParameter[] Gparam = {
                                    new SqlParameter("@ProjectID",ProjectID),                                     
                                      new SqlParameter("@Date",Date),
                                       new SqlParameter("@User",User)
                               };
        return Convert.ToInt32(SqlHelper.ExecuteScalar(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_UnBlockProject", Gparam));

    }

    public virtual DataTable GetAllProjectList(string Search)
    {
        SqlParameter[] Gparam = {

                                    new SqlParameter("@Search",Search)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_GetProjectAllList]", Gparam).Tables[0];

    }
}