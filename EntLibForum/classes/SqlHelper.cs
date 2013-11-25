using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;



namespace yaf
{
    public abstract class SqlHelper
    {
        public static readonly string ConnectionStringLocal = Config.ConnectionString;

        public static object ExecuteScalar(string cmdText)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = cmdText;
            return ExecuteScalar(SqlHelper.ConnectionStringLocal, CommandType.Text, cmd);
        }

        public static object ExecuteScalar(SqlCommand cmd)
        {
            return ExecuteScalar(SqlHelper.ConnectionStringLocal, CommandType.Text, cmd);
        }

        public static object ExecuteScalar(string connectionString, CommandType cmdType, SqlCommand cmd)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                if (conn.State != ConnectionState.Open)
                    conn.Open();

                cmd.Connection = conn;
                cmd.CommandType = cmdType;

                return cmd.ExecuteScalar();
            }
        }

        public static int ExecuteNonQuery(string cmdText)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = cmdText;
            return ExecuteNonQuery(SqlHelper.ConnectionStringLocal, CommandType.Text, cmd);
        }

        public static int ExecuteNonQuery(SqlCommand cmd)
        {
            return ExecuteNonQuery(SqlHelper.ConnectionStringLocal, CommandType.Text, cmd);
        }

        public static int ExecuteNonQuery(string connectionString, SqlCommand cmd)
        {
            return ExecuteNonQuery(connectionString, CommandType.Text, cmd);
        }


        public static int ExecuteNonQuery(string connectionString, CommandType cmdType, SqlCommand cmd)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                if (conn.State != ConnectionState.Open)
                    conn.Open(); 

                cmd.Connection = conn;
                cmd.CommandType = cmdType;

                int rowsAffected = cmd.ExecuteNonQuery();
                cmd.Parameters.Clear();
                return rowsAffected;
            }
        }

        public static int ExecuteNonQuery(SqlCommand cmd, out int sysno)
        {
            return ExecuteNonQuery(SqlHelper.ConnectionStringLocal, CommandType.Text, cmd, out sysno);
        }

        public static int ExecuteNonQuery(string connectionString, SqlCommand cmd, out int sysno)
        {
            return ExecuteNonQuery(connectionString, CommandType.Text, cmd, out sysno);
        }

        public static int ExecuteNonQuery(string connectionString, CommandType cmdType, SqlCommand cmd, out int sysno)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {

                if (conn.State != ConnectionState.Open)
                    conn.Open();

                cmd.Connection = conn;
                cmd.CommandType = cmdType;

                int rowsAffected = cmd.ExecuteNonQuery();

                //必须符合下面的条件
                if (cmd.Parameters.Contains("@SysNo") && cmd.Parameters["@SysNo"].Direction == ParameterDirection.Output)
                    sysno = (int)cmd.Parameters["@SysNo"].Value;
                else
                {
                    throw new Exception("SqlHelper: Does not contain SysNo or ParameterDirection is Not Output");
                }

                cmd.Parameters.Clear();
                return rowsAffected;
            }
        }

        public static DataSet ExecuteDataSet(string cmdText)
        {
            return ExecuteDataSet(SqlHelper.ConnectionStringLocal, cmdText, null);
        }

        public static DataSet ExecuteDataSet(string connectionString, string cmdText)
        {
            return ExecuteDataSet(connectionString, cmdText, null);
        }

        public static DataSet ExecuteDataSet(string cmdText, SqlParameter[] paras)
        {
            return ExecuteDataSet(SqlHelper.ConnectionStringLocal, cmdText, paras);
        }

        public static DataSet ExecuteDataSet(string connectionString, string cmdText, SqlParameter[] paras)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                if (conn.State != ConnectionState.Open)
                    conn.Open();

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = cmdText;
                cmd.CommandType = CommandType.Text;
                if (paras != null && paras.Length > 0)
                    cmd.Parameters.AddRange(paras);

                SqlDataAdapter sqlDA = new SqlDataAdapter();
                sqlDA.SelectCommand = cmd;
                DataSet dataSet = new DataSet();
                sqlDA.Fill(dataSet, "Anonymous");

                return dataSet;
            }
        }
    }
}
