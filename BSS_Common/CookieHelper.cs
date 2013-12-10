using System;
using System.Web;

namespace Trilink.Common
{
    /// <summary>
    /// cookie帮助类
    /// </summary>
    public class CookieHelper
    {
        /// <summary>
        /// 获得一个cookie变量
        /// </summary>
        /// <param name="CookieName">cookie的键名</param>
        /// <returns></returns>
        public static string get(string CookieName)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies[CookieName];
            if (cookie != null)
                return cookie.Value;
            else
                return null;
        }

        /// <summary>
        /// 获得一个cookie变量
        /// </summary>
        /// <param name="ParentName">cookie的父键名</param>
        /// <param name="CookieName">cookie的键名</param>
        /// <returns></returns>
        public static string get(string ParentName, string CookieName)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies[ParentName];
            if (cookie != null)
                return HttpContext.Current.Request.Cookies[ParentName][CookieName];
            else
                return null;
        }

        /// <summary>
        /// 设置一个cookie变量
        /// </summary>
        /// <param name="CookieName">cookie的键名</param>
        /// <param name="CookieValue">cookie的键值</param>
        /// <param name="ExpiresDay">cookie有效天数</param>
        public static void set(string CookieName, string CookieValue, int ExpiresDay)
        {
            HttpCookie cookie = new HttpCookie(CookieName);
            cookie.Value = CookieValue;
            if (ExpiresDay > 0)
                cookie.Expires = DateTime.Now.AddDays(ExpiresDay);
            HttpContext.Current.Response.AppendCookie(cookie);
        }

        /// <summary>
        /// 设置一个cookie变量
        /// </summary>
        /// <param name="ParentName">cookie的父键名</param>
        /// <param name="CookieName">cookie的键名</param>
        /// <param name="CookieValue">cookie的键值</param>
        /// <param name="ExpiresDay">cookie有效天数</param>
        public static void set(string ParentName, string CookieName, string CookieValue, int ExpiresDay)
        {
            HttpCookie cookie;
            if (get(ParentName) == null)
                cookie = new HttpCookie(ParentName);
            else
                cookie = HttpContext.Current.Request.Cookies[ParentName];

            cookie.Values[CookieName] = CookieValue;
            if (ExpiresDay > 0)
                cookie.Expires = DateTime.Now.AddDays(ExpiresDay);
            HttpContext.Current.Response.AppendCookie(cookie);
        }

        /// <summary>
        /// 移除一个cookie变量
        /// </summary>
        /// <param name="CookieName">cookie的键名</param>
        public static void remove(string CookieName)
        {
            System.Web.HttpContext.Current.Response.Cookies[CookieName].Value = null;

        }

        /// <summary>
        /// 移除一个cookie变量
        /// </summary>
        /// <param name="ParentName">cookie的父键名</param>
        /// <param name="CookieName">cookie的键名</param>
        public static void remove(string ParentName, string CookieName)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies[ParentName];
            cookie.Values.Remove(CookieName);
        }
    }
}