using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
///DateManage 的摘要说明
/// </summary>
public class DateManage
{
    public DateManage()
    {
        //
        //TODO: 在此处添加构造函数逻辑
        //
    }

    //根据提交到后台的数据，获取月份
    public string getMonth(string[] twoMonth)
    {
        List<string> getTwoMonth = new List<string>();
        for (int i = 0; i < twoMonth.Length; i++)
        {
            string monthStr = twoMonth[i];
            if (!string.IsNullOrEmpty(monthStr))
            {
                if (getTwoMonth.Contains(monthStr.Substring(5, 2)))
                {
                    continue;
                }
                getTwoMonth.Add(monthStr.Substring(5, 2));
            }
        }

        string month = "";
        for (int i = 0; i < getTwoMonth.Count; i++)
        {
            month += "'";
            month += getTwoMonth[i].ToString();
            if (i < getTwoMonth.Count - 1)
            {
                month += "',";
            }
        }
        month += "'";
        return month;
    }
}