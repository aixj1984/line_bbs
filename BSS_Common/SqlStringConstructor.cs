using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;

namespace Trilink.Common
{
    public class SqlStringConstructor
    {
        public static string GetQueotedString(String pStr)
        {
            return ("'" + pStr + "'");
        }
        public static String GetConditionClause(Hashtable queryItems)
        {
            int Count = 0;
            string Where = "";
            foreach (DictionaryEntry item in queryItems)
            {
                if (Count == 0)
                    Where = " where ";
                else
                    Where += " and ";
                if (item.Value.GetType().ToString() == "System.String")
                {
                    Where += item.Key.ToString() + " like " + SqlStringConstructor.GetQueotedString("%" + item.Value.ToString() + "%");
                }
                else if (item.Value.GetType().ToString() == "System.DateTime[]")
                {
                    string[] time = item.Value.ToString().Split(',');
                    Where += item.Key.ToString() + " between " + SqlStringConstructor.GetQueotedString(((DateTime[])item.Value)[0].ToString()) + " and " + SqlStringConstructor.GetQueotedString(((DateTime[])item.Value)[1].ToString());
                }
                else
                {
                    Where += item.Key.ToString() + "=" + item.Value.ToString();
                }
                Count++;
            }
            return Where;
        }
    }
}
