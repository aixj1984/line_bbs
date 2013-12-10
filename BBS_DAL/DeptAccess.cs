using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Trilink.Model;
using Trilink.Common;
using System.Data;

namespace Trilink.DAL
{
    public class DeptAccess
    {
		private DBHelper db;

		public DeptAccess()
		{
			db = new DBHelper();
		}


		public DataSet DeptSelectByPage(string searchType, string searchCondition, int page_index, int page_size)
        {
            int start_Size = (page_index - 1) * page_size + 1;
            int end_Size = page_size * page_index;
            string select_sql = "select * from ({0}) as temp where temp.row_num between {1} and {2} ";
			select_sql = string.Format(select_sql, GetDeptReturnSQL(searchType, searchCondition), start_Size, end_Size);
            return db.SelectDataCospace(select_sql);
        }

        //因为这里每次都分页，所以直接返回数值
		public DataSet DeptSelectAmount(string searchType, string searchCondition)
        {
			string select_sql = "select count (*) as amount from ({0})as T";
			select_sql = string.Format(select_sql, GetDeptReturnSQL(searchType, searchCondition));
            return  db.SelectDataCospace(select_sql);
        }


        public string GetDeptReturnSQL(string searchType, string searchCondition)
        {
            string return_sql = @"select row_number ()over(order by temp.id asc)as row_num ,
                        *
                        from (
                        SELECT [cospace].[dbo].[sys_dept].[id] ,
                        [cospace].[dbo].[sys_dept].[name]  ,
                        [cospace].[dbo].[sys_dept].[fullname] ,
                        [cospace].[dbo].[sys_dept].[type]  ,
                        COUNT([workno])AS userMember
                         FROM [cospace].[dbo].[sys_dept],[cospace].[dbo].[sys_user],[cospace].[dbo].[sys_deptmember]
                        WHERE [cospace].[dbo].[sys_dept].[id] = [cospace].[dbo].[sys_deptmember].[deptid]
                        {0}
                        AND [cospace].[dbo].[sys_deptmember].[userid] = [cospace].[dbo].[sys_user].[id]
                        GROUP BY [cospace].[dbo].[sys_dept].[id],
                        [cospace].[dbo].[sys_dept].[name],
                        [cospace].[dbo].[sys_dept].[fullname],
                        [cospace].[dbo].[sys_dept].[type]
                        UNION ALL
                        SELECT
                        [cospace].[dbo].[sys_dept].[id]  ,
                        [cospace].[dbo].[sys_dept].[name] ,
                        [cospace].[dbo].[sys_dept].[fullname] ,
	                    [cospace].[dbo].[sys_dept].[type] ,
                        0 AS userMember
                        FROM [cospace].[dbo].[sys_dept]
                        WHERE 1=1 {1}
                        and [cospace].[dbo].[sys_dept].[id] not in
                        (select distinct deptid from [cospace].[dbo].[sys_deptmember])
                        )as temp";
            string condition_sql = "";
            if (searchType != "")
            {
                if (searchType == "name")
                {
                    condition_sql = condition_sql + "and  [cospace].[dbo].[sys_dept].[name] in (" + getDeptName(searchCondition) + ")";
                }
            }
            return_sql = string.Format(return_sql, condition_sql, condition_sql);
            return return_sql;

        }

        //得到部门
        public string getDeptName(string deptName)
        {
            string sql = @" WITH ShowTree(ID, parentid, [name],fullname)AS 
                        (SELECT id, parentid, [name],fullname FROM [cospace].[dbo].[sys_dept]
                        WHERE (name like '%" + deptName + @"%')
                        UNION ALL
                        SELECT cospace.dbo.sys_dept.id,cospace.dbo.sys_dept.parentid, cospace.dbo.sys_dept.[name], cospace.dbo.sys_dept.fullname
                        FROM ShowTree AS s 
                        INNER JOIN  cospace.dbo.sys_dept ON  s.ID = [cospace].[dbo].[sys_dept].parentid)
                        SELECT distinct [name]
                        FROM ShowTree ";
            DataSet dateSet = db.SelectDataCospace(sql);
            string deptStr = "";

            int dataLen = dateSet.Tables[0].Rows.Count;
            if (dataLen == 0)
            {
                return "NULL";
            }
            for (int i = 0; i < dataLen; i++)
            {
                deptStr += "'";
                deptStr += dateSet.Tables[0].Rows[i][0].ToString();
                if (i < dataLen - 1)
                {
                    deptStr += "',";
                }

            }
            deptStr += "'";
            return deptStr;
        }



        public DataSet GetUserAmount(string searchType, string searchCondition)
        {
            string select_sql = "select count (*) as amount from ({0})as T";
            select_sql = string.Format(select_sql, GetDeptReturnSQL(searchType, searchCondition));
            return db.SelectDataCospace(select_sql);
        }

        //因为这里每次都分页，所以直接返回数值
        public DataSet StaffSelectByPage(string searchType, string searchCondition, int page_index, int pageSize)
        {
            int Size = Convert.ToInt32(pageSize);
            int Nowpage = Convert.ToInt32(page_index);
            int start_Size = (Nowpage - 1) * Size + 1;
            int end_Size = Size * Nowpage;
            string sql = "select * from ({0}) as Temp_user where Temp_user.row_number between {1} and {2}";
            sql = string.Format(sql, GetUserReturnSQL(searchCondition, searchType), start_Size, end_Size);
            return db.SelectDataCospace(sql);
        }

        public string GetUserReturnSQL(string searchCondition, string searchType)
        {
            string returnSQL = @"SELECT ROW_NUMBER() OVER(ORDER BY [cospace].[dbo].[sys_user_base_info].[staff_id] asc)AS row_number,
                       [staff_id],[user_true_name],[dept_name],[user_sex],
                       [user_duty_name],[user_tle_office],[user_disable],[user_idcard],[user_id]
                       FROM [cospace].[dbo].[sys_user_base_info] where 1=1 {0}";
            string sql_condition = "";
            if (searchType != "")
            {
                if (searchCondition == "输入查询条件")
                {
                    searchCondition = "";
                }
                if (searchType == "id")
                {

                    sql_condition = sql_condition + " and cospace.dbo.sys_user_base_info.staff_id like '%" + searchCondition + "%'";

                }
                if (searchType == "truename")
                {
                    string trueName = getNameStr(searchCondition);
                    sql_condition = sql_condition + " and cospace.dbo.sys_user_base_info.user_true_name like " + trueName + "";
                }
                if (searchType == "fullname")
                {
                    sql_condition = sql_condition + " and cospace.dbo.sys_user_base_info.dept_name in (" + getDeptName(searchCondition) + ")";
                }

            }
            returnSQL = string.Format(returnSQL, sql_condition);
            return returnSQL;
        }

        //考勤，按姓名查询，名字处理
        public string getNameStr(string name)
        {
            string trimName = name.Trim();
            string[] nameArr = trimName.Split(" ".ToCharArray());
            string nameStr = "'%";
            for (int i = 0; i < nameArr.Length; i++)
            {
                if (!string.IsNullOrEmpty(nameArr[i]))
                {
                    nameStr += nameArr[i];
                    if (i < nameArr.Length - 1)
                    {
                        nameStr += "%";
                    }
                }
            }
            nameStr += "%'";
            return nameStr;
        }


        //获取用户相信信息
        public DataSet GetDetailUserInfos(string userId)
        {
            string SQL = @"SELECT [dept_name],[dept_fullname],[staff_id],[user_true_name]
                           ,[user_sex],[user_idcard],[user_duty_name],[user_tel_mobile],[user_tle_office]
                           ,[user_email],[user_disable],[user_political_type],[pic_file_name]
                      FROM [sys_user_base_info] 
                     WHERE [sys_user_base_info].[staff_id] = '" + userId + "'";
            return  db.SelectDataCospace(SQL);

            
        }

    }
}
