using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace Trilink.Model
{
    /// <summary>
    ///Dept 的摘要说明
    /// </summary>
    public class DeptInfo
    {
        #region
        public DeptInfo()
        {
            //
            //TODO: 在此处添加构造函数逻辑
            //
        }
        #endregion

        #region Attributes
        private string id;
        private string parentid;
        private string name;
        private string relation;
        private string description;
        private int list;
        private string code;
        private string type;
        private string appid;
        private string fullname;
        private int idmapping;
        private string external_id;
        private string members;
        #endregion

        #region Id
        public string Id
        {
            get { return id; }
            set { id = value; }
        }
        #endregion

        #region Parentid
        public string Parentid
        {
            get { return parentid; }
            set { parentid = value; }
        }
        #endregion

        #region Name
        public string Name
        {
            get { return name; }
            set { name = value; }
        }
        #endregion

        #region Relation
        public string Relation
        {
            get { return relation; }
            set { relation = value; }
        }
        #endregion

        #region Description
        public string Description
        {
            get { return description; }
            set { description = value; }
        }
        #endregion


        #region List
        public int List
        {
            get { return list; }
            set { list = value; }
        }
        #endregion


        #region Code

        public string Code
        {
            get { return code; }
            set { code = value; }
        }
        #endregion


        #region Type
        public string Type
        {
            get { return type; }
            set { type = value; }
        }
        #endregion


        #region Appid

        public string Appid
        {
            get { return appid; }
            set { appid = value; }
        }
        #endregion


        #region Fullname

        public string Fullname
        {
            get { return fullname; }
            set { fullname = value; }
        }
        #endregion


        #region Idmapping
        public int Idmapping
        {
            get { return idmapping; }
            set { idmapping = value; }
        }
        #endregion
        #region external_id;
        public string External_id
        {
            get { return external_id; }
            set { external_id = value; }
        }
        #endregion
        #region members
        public string Members
        {
            get { return members; }
            set { members = value; }
        }
        #endregion
    }
}