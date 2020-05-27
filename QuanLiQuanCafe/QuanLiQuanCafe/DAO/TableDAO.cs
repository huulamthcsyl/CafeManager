using QuanLiQuanCafe.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLiQuanCafe.DAO
{
    public class TableDAO
    {
        private static TableDAO instance;

        public static int TableWidth = 100;
        public static int TableHeight = 100;

        public static TableDAO Instance
        {
            get { if (instance == null) instance = new TableDAO(); return TableDAO.instance; }
            private set { TableDAO.instance = value; }
        }

        private TableDAO() { }

        public List<Table> LoadTableList()
        {
            List<Table> tableList = new List<Table>();

            DataTable data = DataProvider.Instance.ExcuteQuery("USP_GetTableList");

            foreach(DataRow row in data.Rows)
            {
                Table table = new Table(row);
                tableList.Add(table);
            }

            return tableList;
        }
    }
}
