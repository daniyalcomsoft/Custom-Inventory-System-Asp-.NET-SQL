using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;


    public class SessionHelper
    {
        public static void AbandonSession(HttpContext Context)
        {
            Context.Session.Clear();
            Context.Session.Abandon();
            Context.Session.RemoveAll();
            if (Context.Request.Cookies["ASP.NET_SessionId"] != null)
            {
                Context.Response.Cookies["ASP.NET_SessionId"].Value = string.Empty;
                Context.Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddMonths(-20);
            }
        }

        public static string CreateSessionId(HttpContext Context)
        {
            var manager = new SessionIDManager();

            string newSessionId = manager.CreateSessionID(Context);

            return newSessionId;
        }

        public static void SetSessionId(HttpContext Context,string newSessionId)
        {
            var manager = new SessionIDManager();

            bool redirected;
            bool cookieAdded;

            manager.SaveSessionID(Context, newSessionId, out redirected, out cookieAdded);

        }
    }
