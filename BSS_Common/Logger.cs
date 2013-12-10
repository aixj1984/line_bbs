using System;
using System.IO;
using System.Web;

namespace Trilink.Common
{
    /// <summary>
    /// 日志类
    /// </summary>
    public class Logger
    {
        /// <summary>
        /// 写日志
        /// </summary>
        /// <param name="msg">消息</param>
        public static void Write(string msg)
        {
            FileInfo fi = new FileInfo(HttpContext.Current.Server.MapPath("App_Data/Log_" + DateTime.Now.ToString("yyMMdd") + ".txt"));
            StreamWriter sw = fi.AppendText();
            sw.WriteLine(HttpContext.Current.Request.UserHostAddress + "  " + HttpContext.Current.Request.RawUrl + "  " + msg + "  " + DateTime.Now + "\n");
            sw.Close();
        }
    }
}
