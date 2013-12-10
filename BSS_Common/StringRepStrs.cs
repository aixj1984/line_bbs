using System;
using System.Text;
using System.Text.RegularExpressions;

namespace Trilink.Common
{
    /// <summary>
    /// 字符串处理类
    /// </summary>
    public class StringRepStrs
    {
        public StringRepStrs() { }

        #region  普通替换字符串
        /// <summary>
        ///  普通替换字符串
        /// </summary>
        /// <param name="src">源字符串</param>
        /// <param name="pattern">要匹配的正则表达式模式</param>
        /// <param name="replacement">替换字符串</param>
        /// <returns>已修改的字符串</returns>
        public static string Replace(string src, string pattern, string replacement)
        {
            return Replace(src, pattern, replacement, RegexOptions.None);
        }
        #endregion

        #region 正则替换字符串
        /// <summary>
        ///  正则替换字符串
        /// </summary>
        /// <param name="src">要修改的字符串</param>
        /// <param name="pattern">要匹配的正则表达式模式</param>
        /// <param name="replacement">替换字符串</param>
        /// <param name="options">匹配模式</param>
        /// <returns>已修改的字符串</returns>
        public static string Replace(string src, string pattern, string replacement, RegexOptions options)
        {
            Regex regex = new Regex(pattern, options | RegexOptions.Compiled);
            return regex.Replace(src, replacement);
        }
        #endregion

        #region 不区分大小写替换字符串
        /// <summary>
        /// 不区分大小写替换字符串
        /// </summary>
        /// <param name="src">源字符串</param>
        /// <param name="pattern">要匹配的正则表达式模式</param>
        /// <param name="replacement">替换字符串</param>
        /// <returns>已修改的字符串</returns>
        public static string ReplaceIgnoreCase(string src, string pattern, string replacement)
        {
            return Replace(src, pattern, replacement, RegexOptions.IgnoreCase);
        }
        #endregion

        #region 删除字符串中指定的内容
        /// <summary>
        /// 删除字符串中指定的内容
        /// </summary>
        /// <param name="src">要修改的字符串</param>
        /// <param name="pattern">要删除的正则表达式模式</param>
        /// <returns>已删除指定内容的字符串</returns>
        public static string Drop(string src, string pattern)
        {
            return Replace(src, pattern, "");
        }
        #endregion

        #region 删除字符串中指定的内容,不区分大小写
        /// <summary>
        /// 删除字符串中指定的内容,不区分大小写
        /// </summary>
        /// <param name="src">要修改的字符串</param>
        /// <param name="pattern">要删除的正则表达式模式</param>
        /// <returns>已删除指定内容的字符串</returns>
        public static string DropIgnoreCase(string src, string pattern)
        {
            return ReplaceIgnoreCase(src, pattern, "");
        }
        #endregion

        #region 替换字符串到数据库可输入模式
        /// <summary>
        /// 替换字符串到数据库可输入模式
        /// </summary>
        /// <param name="src">待插入数据库的字符串</param>
        /// <returns>可插入数据库的字符串</returns>
        public static string ToSQL(string src)
        {
            if (src == null)
            {
                return null;
            }
            return Replace(src, "", "");
        }
        #endregion

        #region 去掉html内容中的指定的html标签
        /// <summary>
        /// 去掉html内容中的指定的html标签
        /// </summary>
        /// <param name="content">html内容</param>
        /// <param name="tagName">html标签</param>
        /// <returns>去掉标签的内容</returns>
        public static string DropHtmlTag(string content, string tagName)
        {
            //去掉<tagname>和</tagname>
            return DropIgnoreCase(content, "<[/]{0,1}" + tagName + "[^\\>]*\\>");
        }
        #endregion

        #region 去掉html内容中全部标签
        /// <summary>
        /// 去掉html内容中全部标签
        /// </summary>
        /// <param name="content">html内容</param>
        /// <returns>去掉html标签的内容</returns>
        public static string DropHtmlTag(string content)
        {
            //去掉<*>
            return Drop(content, "<[^\\>]*>");
        }
        #endregion

        #region 判断一个数据是不是数字
        /// <summary>
        /// 判断一个数据是不是数字
        /// </summary>
        /// <param name="inputData">字符串</param>
        /// <returns>结果</returns>
        public static bool IsNumeric(string inputData)
        {
            Regex _isNumber = new Regex(@"^\d+{$article$}quot;");
            Match m = _isNumber.Match(inputData);
            return m.Success;
        }
        #endregion

        #region 转换html标签为web页可见内容
        /// <summary>
        /// 转换html标签为web页可见内容
        /// </summary>
        /// <param name="src"></param>
        /// <returns></returns>
        public static string EscapeHtml(string src)
        {
            if (src == null)
            {
                return null;
            }
            string s = src;
            s = Replace(s, ">", "&gt;");
            s = Replace(s, "<", "&lt;");
            return s;
        }
        #endregion

        #region 将字符串格式化成HTML代码
        /// <summary>
        /// 将字符串格式化成HTML代码
        /// </summary>
        /// <param name="str">要格式化的字符串</param>
        /// <returns>格式化后的字符串</returns>
        public static String ToHtml(string str)
        {
            if (str == null || str.Equals(""))
            {
                return str;
            }

            StringBuilder sb = new StringBuilder(str);
            sb.Replace("&", "&amp;");
            sb.Replace("<", "&lt;");
            sb.Replace(">", "&gt;");
            sb.Replace("\r\n", "<br>");
            sb.Replace("\n", "<br>");
            sb.Replace("\t", " ");
            sb.Replace(" ", "&nbsp;");
            return sb.ToString();
        }
        #endregion

        #region 将HTML代码转化成文本格式
        /// <summary>
        /// 将HTML代码转化成文本格式
        /// </summary>
        /// <param name="str">要格式化的字符串</param>
        /// <returns>格式化后的字符串</returns>
        public static String ToTxt(String str)
        {
            if (str == null || str.Equals(""))
            {
                return str;
            }

            StringBuilder sb = new StringBuilder(str);
            sb.Replace("&nbsp;", " ");
            sb.Replace("<br>", "\r\n");
            sb.Replace("&lt;", "<");
            sb.Replace("&gt;", ">");
            sb.Replace("&amp;", "&");
            return sb.ToString();
        }
        #endregion

    }
}