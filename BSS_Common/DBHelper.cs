 using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.IO;
using System.Data.OleDb;
using System.Web;


//[WebService(Namespace = "http://tempuri.org/")]
//[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]

namespace Trilink.Common
{
    public class DBHelper
    {

        private Dictionary<string, string> DataBaseConnectMap = null;
        public enum ErrorCode
        {
            Success = 0,
            Failed = 0xFFFF01,
            Exception = 0xFFFF02,
        }

        public DBHelper()
        {
            DataBaseConnectMap = new Dictionary<string, string>();
            DataBaseConnectMap.Add("EntLib_BBS", "Data Source=192.168.186.237;Initial Catalog=EntLib_BBS;Persist Security Info=True;User ID=sa;Password=intple"); //BBS
            DataBaseConnectMap.Add("TPH", "Data Source=192.168.1.111;Initial Catalog=TPH;Persist Security Info=True;User ID=sa;Password=trilink123!@#");         //TPH数据库
            DataBaseConnectMap.Add("TPH_ATT", "Data Source=192.168.1.111;Initial Catalog=TPH_ATT;Persist Security Info=True;User ID=sa;Password=trilink123!@#");//考勤数据库
            DataBaseConnectMap.Add("Park_V1902W", "Data Source=192.168.1.111;Initial Catalog=Park_V1902W;Persist Security Info=True;User ID=sa;Password=trilink123!@#");//停车数据库
            DataBaseConnectMap.Add("TPH_Consumption", "Data Source=192.168.1.111;Initial Catalog=TPH_Consumption;Persist Security Info=True;User ID=sa;Password=trilink123!@#");//消费数据库
        }

        private SqlConnection Connect(string connectString)
        {
            SqlConnection conn = null;
            string strconn = connectString;//System.Web.Configuration.WebConfigurationManager.ConnectionStrings[connectString].ToString();
            if (strconn != null)
            {
                conn = new SqlConnection(strconn);
            }
            return conn;
        }

        #region 查询接口

        public DataSet SelectDataTPH(string sql)
        {
            return ExecuteQuery(sql, "TPH");
        }


        public DataSet SelectDataCospace(string sql)
        {
            return ExecuteQuery(sql, "TPH");
        }


        public DataSet SelectDataEntLib_BBS(string sql)
        {
            return ExecuteQuery(sql, "EntLib_BBS");
        }

        public DataSet SelectDataTPH_ATT(string sql)
        {
            return ExecuteQuery(sql, "TPH_ATT");
        }


        public DataSet SelectDataPark_V1902W(string sql)
        {
            return ExecuteQuery(sql, "Park_V1902W");

        }

        public DataSet SelectDataTPH_Consumption(string sql)
        {
            return ExecuteQuery(sql, "TPH_Consumption");
        }

        public DataSet SelectDataXCB(string sql)
        {
            return ExecuteQuery(sql, "XCB");
        }

        public DataSet SelectDataLSDT(string sql)
        {
            return ExecuteQuery(sql, "LSDT");
        }

        public DataSet SelectDataTest(string sql)
        {
            return ExecuteQuery(sql, "test");
        }

        //判断表是否存在；1,否则返回0
        public string isExistTable(string tableName, string DataBaseName)
        {
            string select_sql = "select * from dbo.sysobjects where id = object_id(N'[dbo].[" + tableName + "]') and OBJECTPROPERTY(id, N'IsUserTable') = 1;";
            DataSet dataset = ExecuteQuery(select_sql, DataBaseName);
            if (dataset == null)
            {
                return "No";
            }
            if (dataset.Tables[0].Rows.Count > 0)
            {
                return "Yes";
            }
            else
            {
                return "No";
            }
        }

        private DataSet ExecuteQuery(string select_sql, string DatabaseName)
        {
            if (!DataBaseConnectMap.ContainsKey(DatabaseName))
            {
                //数据库不存在
                return null;
            }
            DataSet ds = null;
            SqlConnection sqlConn = Connect(DataBaseConnectMap[DatabaseName]);
            if (sqlConn != null)
            {
                try
                {
                    sqlConn.Open();
                    SqlCommand cmd = new SqlCommand(select_sql, sqlConn);
                    ds = new DataSet();
                    SqlDataAdapter sqlDA = new SqlDataAdapter();
                    sqlDA.SelectCommand = cmd;
                    sqlDA.Fill(ds);
                    return ds;
                }
                catch (Exception)
                {
                    Console.WriteLine("数据库连接失败!");
                    return null;
                }
                finally
                {
                    sqlConn.Close();
                }
            }
            else
            {
                return null;
            }
        }
        #endregion

        #region  执行修改接口
        /// <summary>
        /// 功能：执行更新删除插入数据库操作,成功则返回true
        /// </summary>
        /// <param name="strSql"></param>
        /// <param name="DatabaseName"></param>
        /// <returns></returns>
        /// 
        public bool ExecuteNoQueryTPH(string sql)
        {
            return ExecuteNoQuery(sql, "TPH");
        }

        public bool ExecuteNoQueryCospace(string sql)
        {
            return ExecuteNoQuery(sql, "cospace");
        }

        public bool ExecuteNoQueryEntLib_BBS(string sql)
        {
            return ExecuteNoQuery(sql, "EntLib_BBS");
        }


        public bool ExecuteNoQueryTPH_ATT(string sql)
        {
            return ExecuteNoQuery(sql, "TPH_ATT");
        }





        public bool ExecuteNoQueryPark_V1902W(string sql)
        {
            return ExecuteNoQuery(sql, "Park_V1902W");

        }

        public bool ExecuteNoQueryTPH_Consumption(string sql)
        {
            return ExecuteNoQuery(sql, "TPH_Consumption");
        }

        public bool ExecuteNoQueryXCB(string sql)
        {
            return ExecuteNoQuery(sql, "XCB");
        }

        public bool ExecuteNoQueryLSDT(string sql)
        {
            return ExecuteNoQuery(sql, "LSDT");
        }

        public bool ExecuteNoQueryTest(string sql)
        {
            return ExecuteNoQuery(sql, "test");
        }

        private bool ExecuteNoQuery(string strSql, string DatabaseName)
        {
            bool flag = false;
            if (!DataBaseConnectMap.ContainsKey(DatabaseName))
            {
                //数据库不存在
                return flag;
            }
            SqlConnection sqlConn = Connect(DataBaseConnectMap[DatabaseName]);
            if (sqlConn != null)
            {
                SqlCommand cm = new SqlCommand();
                cm.CommandText = strSql;
                try
                {
                    sqlConn.Open();
                    cm.Connection = sqlConn;
                    cm.ExecuteNonQuery();
                    flag = true;
                }
                catch (Exception ex)
                {
                    //throw new Exception(ex.Message);
                    return  flag;
                }
                finally
                {
                    sqlConn.Close();
                    
                }
            }
            return flag;

        }

        /// <summary>   
        /// 功能：执行查询数据库操作返回影响行数　   
        /// </summary>   
        /// <param name="strSql"></param>   
        public int ExecuteNonQueryCount(string strSql, string DatabaseName)
        {

            if (!DataBaseConnectMap.ContainsKey(DatabaseName))
            {
                //数据库不存在
                return (int)ErrorCode.Failed;
            }

            SqlConnection sqlConn = Connect(DataBaseConnectMap[DatabaseName]);
            if (sqlConn != null)
            {
                SqlCommand cm = new SqlCommand();
                try
                {
                    sqlConn.Open();
                    cm.CommandText = strSql;
                    cm.Connection = sqlConn;
                    int count = (int)cm.ExecuteNonQuery();
                    return count;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
                finally
                {
                    cm.Dispose();
                    sqlConn.Close();
                }
            }
            return (int)ErrorCode.Failed;

        }

        /// <summary>
        /// param_name is like '@pic'
        /// </summary>
        /// <param name="sql"></param>
        /// <param name="param_name"></param>
        /// <param name="Image"></param>
        /// <param name="DatabaseName"></param>
        /// <returns></returns>
        public int ExcuteImageNoQuery(string sql, string param_name, byte[] Image, string DatabaseName)
        {

            if (!DataBaseConnectMap.ContainsKey(DatabaseName))
            {
                //数据库不存在
                return (int)ErrorCode.Failed;
            }

            SqlConnection sqlConn = Connect(DataBaseConnectMap[DatabaseName]);
            if (sqlConn != null)
            {

                try
                {
                    sqlConn.Open();
                    SqlCommand cmd = new SqlCommand(sql, sqlConn);
                    /*二进制数据插入数据库方法1
                    cmd.CommandText=sql;
                    cmd.Parameters.Add(new SqlParameter("@pic", Image));
                    cmd.ExecuteNonQuery();
                    */
                    //二进制数据插入数据库方法2
                    cmd.Parameters.Add(param_name, SqlDbType.Image, Image.Length);
                    cmd.Parameters[param_name].Value = Image;
                    cmd.ExecuteNonQuery();
                    return (int)ErrorCode.Success;
                }
                catch
                {
                    //error;
                    return (int)ErrorCode.Exception;
                }
                finally
                {
                    sqlConn.Close();
                }
            }
            return (int)ErrorCode.Failed;
        }
        #endregion


        public bool ExecuteNoQuerySANJI(string updateSQL)
        {
            throw new NotImplementedException();
        }

        public DataSet SelectDataSANJI(string selectSQL)
        {
            throw new NotImplementedException();
        }

        public DataSet selectConsumtion(SqlParameter[] pars,string ParsName)
        {
            try
            {
                SqlCommand cmd = new SqlCommand(ParsName);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = new SqlConnection(DataBaseConnectMap["TPH_Consumption"]);
                if (pars != null)
                {
                    cmd.Parameters.AddRange(pars);
                }

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);
                return ds;
            }

            catch (Exception e)
            {
                return null;
            }
        }
   }
}

