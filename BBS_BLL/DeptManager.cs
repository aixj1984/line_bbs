using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Trilink.Model;
using Trilink.DAL;
using System.Data;

namespace Trilink.BLL
{
    public class DeptManager
    {
	    private DeptAccess da;
	    public DeptManager()
		{
			da = new DeptAccess();
		}

		//按照部门名称-查出记录
		public List<Amount> GetDeptAmountByTwo(string searchType, string searchCondition)
		{
            List<Amount> amounts = new List<Amount>();
            Amount amount = default(Amount);
            
            DataSet dataSet = da.DeptSelectAmount(searchType,  searchCondition);
            amount = new Amount();
            amount.Amounts = Convert.ToInt32(dataSet.Tables[0].Rows[0][0]);
            amounts.Add(amount);
            return amounts;
		}


		//按照部门名称查出记录--分页
		public List<DeptInfo> GetDeptByTwoCondition(string page, string pageSize, string searchType, string searchCondition)
		{
            List<DeptInfo> depts = new List<DeptInfo>();
            DeptInfo dept = default(DeptInfo);
			DataSet ds = da.DeptSelectByPage(searchType, searchCondition, Convert.ToInt32(page), Convert.ToInt32(pageSize));
			foreach (DataRow dr in ds.Tables[0].Rows)
			{
                dept = new DeptInfo();
                dept.Id = dr["id"].ToString();
                dept.Name = dr["name"].ToString();
                dept.Fullname = dr["fullname"].ToString();
                dept.Members = dr["userMember"].ToString();
                dept.Type = dr["type"].ToString();
                depts.Add(dept);
			}
			return depts;
		}

        //按照部门名称-查出记录
        public List<Amount> GetStaffAmount(string searchType, string searchCondition)
        {
            List<Amount> amounts = new List<Amount>();
            Amount amount = default(Amount);

            DataSet dataSet = da.GetUserAmount(searchType, searchCondition);
            amount = new Amount();
            amount.Amounts = Convert.ToInt32(dataSet.Tables[0].Rows[0][0]);
            amounts.Add(amount);
            return amounts;
        }
    }
}
