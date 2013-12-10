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
    /// ���ݿ������
    /// </summary>
    public class DataBase
    {
        private string connectionString;
        private OleDbConnection connection;

        /// <summary>
        /// Ĭ�Ϲ��캯��
        /// </summary>
        public DataBase()
        {
            string dbPath = HttpContext.Current.Server.MapPath(ConfigurationManager.ConnectionStrings["OleDbConnectionPath"].ConnectionString);
            this.connectionString = "Provider=Microsoft.Jet.OleDb.4.0;Data Source=" + dbPath;
        }

        /// <summary>
        /// �����ݿ�����
        /// </summary>
        private void Open()
        {
            if (this.connection == null)
            {
                this.connection = new OleDbConnection(this.connectionString);//����һ������
                this.connection.Open();
            }
            //�������״̬�ǹرյ�
            if (this.connection.State.Equals(ConnectionState.Closed))
            {
                this.connection.Open();
            }
        }

        /// <summary>
        /// �ر����ݿ�����
        /// </summary>
        private void Close()
        {
            if (this.connection != null)//������Ӵ���
            {
                this.connection.Close();
            }
        }

        /// <summary>
        /// ��ȡ���ݿ�����
        /// </summary>
        /// <returns>�������ݿ�����</returns>
        private OleDbConnection GetConnection()
        {
            this.Open();
            return connection;
        }

        /// <summary>
        /// ����OleDbCommand������
        /// </summary>
        /// <param name="cmd">OleDbCommand����</param>
        /// <param name="cmdTxt">��Ҫִ�е�SQL���</param>
        /// <param name="cmdParms">��Ҫ������SQL����</param>
        private void Preparecommand(OleDbCommand cmd, string cmdTxt, OleDbParameter[] cmdParms)
        {
            this.Open();
            cmd.Connection = this.connection;//ָ�����Command�ǻ����Ѵ򿪵��������
            cmd.CommandText = cmdTxt;
            if (cmdParms != null)//���ʹ�ô洢����
            {
                foreach (OleDbParameter parm in cmdParms)
                {
                    cmd.Parameters.Add(parm);
                }
            }
        }

        /// <summary>
        /// �����ݿ������ɾ����
        /// </summary>
        /// <param name="cmdTxt">��Ҫִ�е�SQL���</param>
        /// <param name="cmdParms">��Ҫ������SQL����</param>
        /// <returns>����Ӱ������</returns>
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
        /// ��ѯ����
        /// </summary>
        /// <param name="cmdTxt">��Ҫִ�е�SQL���</param>
        /// <param name="cmdParms">��Ҫ������SQL����</param>
        /// <returns>����DataTable</returns>
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
        /// ��ѯ����
        /// </summary>
        /// <param name="cmdText">��Ҫִ�е�SQL���</param>
        /// <returns>����DataTable</returns>
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
