using System.Web;
using System.Collections.Specialized;

namespace Trilink.Common
{
    /// <summary>
    /// Url请求参数设置帮助类
    /// </summary>
    public class UrlHelper
    {
        private NameValueCollection nc = new NameValueCollection(HttpContext.Current.Request.QueryString);
        private string url = HttpContext.Current.Request.Url.AbsolutePath;

        /// <summary>
        /// 获取新的Url路径
        /// </summary>
        public string Url
        {
            get
            {
                nc.Remove(null);
                nc.Remove(string.Empty);
                if (nc.Count < 1)
                    return url;
                string query = "?";
                string[] keys = nc.AllKeys;
                for (int i = 0; i < nc.Count; i++)
                {
                    query += keys[i] + "=" + HttpContext.Current.Server.UrlEncode(nc.GetValues(keys[i])[0]) + "&";
                }
                query = query.Remove(query.Length - 1);
                return url + query;
            }
        }

        /// <summary>
        /// 设置Url请求参数
        /// </summary>
        /// <param name="name">参数名</param>
        /// <param name="value">参数值</param>
        public void SetQuery(string name, string value)
        {
            nc.Set(name, value);
        }

        /// <summary>
        /// 获取某个Url参数的值
        /// </summary>
        /// <param name="name">参数名</param>
        /// <returns>返回参数值</returns>
        public string GetQuery(string name)
        {
            if (nc.GetValues(name) != null)
                return HttpContext.Current.Server.UrlDecode(nc.GetValues(name)[0]);
            else
                return "";
        }

        /// <summary>
        /// 移除Url请求参数
        /// </summary>
        /// <param name="name">参数名</param>
        public void RemoveQuery(string name)
        {
            nc.Remove(name);

        }

        /// <summary>
        /// 清空Url请求参数
        /// </summary>
        public void Reset()
        {
            nc.Clear();
        }
    }
}
