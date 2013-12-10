using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Configuration;
using System.Data.OleDb;
using System.Data;

namespace Trilink.Common
{
    /// <summary>
    /// 数据库操作类
    /// </summary>
    public class DataBase
    {
        private string connectionString;
        private OleDbConnection connection;

        /// <summary>
        /// 默认构造函数
        /// </summary>
        public DataBase()
        {
            string dbPath = HttpContext.Current.Server.MapPath(ConfigurationManager.ConnectionStrings["OleDbConnectionPath"].ConnectionString);
            this.connectionString = "Provider=Microsoft.Jet.OleDb.4.0;Data Source=" + dbPath;
        }

        /// <summary>
        /// 打开数据库连接
        /// </summary>
        private void Open()
        {
            if (this.connection == null)
            {
                this.connection = new OleDbConnection(this.connectionString);//建立一个连接
                this.connection.Open();
            }
            //如果连接状态是关闭的
            if (this.connection.State.Equals(ConnectionState.Closed))
            {
                this.connection.Open();
            }
        }

        /// <summary>
        /// 关闭数据库连接
        /// </summary>
        private void Close()
        {
            if (this.connection != null)//如果连接存在
            {
                this.connection.Close();
            }
        }

        /// <summary>
        /// 获取数据库连接
        /// </summary>
        /// <returns>返回数据库连接</returns>
        private OleDbConnection GetConnection()
        {
            this.Open();
            return connection;
        }

        /// <summary>
        /// 设置OleDbCommand的属性
        /// </summary>
        /// <param name="cmd">OleDbCommand对象</param>
        /// <param name="cmdTxt">需要执行的SQL语句</param>
        /// <param name="cmdParms">需要操作的SQL参数</param>
        private void Preparecommand(OleDbCommand cmd, string cmdTxt, OleDbParameter[] cmdParms)
        {
            this.Open();
            cmd.Connection = this.connection;//指明这个Command是基于已打开的这个连接
            cmd.CommandText = cmdTxt;
            if (cmdParms != null)//如果使用存储过程
            {
                foreach (OleDbParameter parm in cmdParms)
                {
                    cmd.Parameters.Add(parm);
                }
            }
        }

        /// <summary>
        /// 对数据库进行增删操作
        /// </summary>
        /// <param name="cmdTxt">需要执行的SQL语句</param>
        /// <param name="cmdParms">需要操作的SQL参数</param>
        /// <returns>返回影响行数</returns>
        public int ExecuteNonQuery(string cmdTxt, OleDbParameter[] cmdParms)
        {
            int i = 0;
            OleDbCommand cmd = new OleDbCommand();
            this.Preparecommand(cmd, cmdTxt, cmdParms);
            i = cmd.ExecuteNonQuery();
            cmd.Parameters.Clear();
            this.Close();
            return i;
        }

        /// <summary>
        /// 查询数据
        /// </summary>
        /// <param name="cmdTxt">需要执行的SQL语句</param>
        /// <param name="cmdParms">需要操作的SQL参数</param>
        /// <returns>返回DataTable</returns>
        public DataTable ExecuteDataReader(string cmdTxt, OleDbParameter[] cmdParms)
        {
            OleDbCommand cmd = new OleDbCommand();
            this.Preparecommand(cmd, cmdTxt, cmdParms);
            DataTable dt = new DataTable();
            OleDbDataAdapter rda = new OleDbDataAdapter(cmd);
            rda.Fill(dt);
            this.Close();
            return dt;
        }

        /// <summary>
        /// 查询数据
        /// </summary>
        /// <param name="cmdText">需要执行的SQL语句</param>
        /// <returns>返回DataTable</returns>
        public DataTable ExecuteDataReader(string cmdText)
        {
            OleDbConnection conn = new OleDbConnection(this.connectionString);
            conn.Open();
            DataTable dt = new DataTable();
            OleDbDataAdapter rda = new OleDbDataAdapter(cmdText, conn);
            rda.Fill(dt);
            conn.Close();
            return dt;
        }
    }
}
