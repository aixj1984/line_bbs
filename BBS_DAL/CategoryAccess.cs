using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Trilink.Model;
using Trilink.Common;
using System.Data;

namespace Trilink.DAL
{
    public class CategoryAccess
    {
		private DBHelper db;

        public CategoryAccess()
		{
			db = new DBHelper();
		}

        //获取论坛板块信息
        public DataSet GetCategoryInfos(string BoardID, string CategoryID)
        {
            string SQL = @"SELECT  [CategoryID] ,[BoardID] ,[Name] ,[SortOrder],[IconName] FROM [yaf_Category] where 1=1 {0} order by SortOrder";
            string condition = "";
            if (BoardID.Length > 0)
            {
                condition = " and boardId = " + BoardID;
                 
            }
            if (CategoryID.Length > 0)
            {
                condition = " and CategoryID = " + CategoryID;
            }
            return  db.SelectDataEntLib_BBS(string.Format(SQL, condition));
        }

    }
}
