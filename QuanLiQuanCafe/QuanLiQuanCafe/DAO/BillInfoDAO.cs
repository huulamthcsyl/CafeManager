using QuanLiQuanCafe.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLiQuanCafe.DAO
{
    public class BillInfoDAO
    {
        private static BillInfoDAO instance;

        public static BillInfoDAO Instance
        {
            get { if (instance == null) instance = new BillInfoDAO(); return BillInfoDAO.instance; }
            private set { BillInfoDAO.instance = value; }
        }

        private BillInfoDAO() { }
        
        public List<BillInfo> GetBillInfo(int id)
        {
            List<BillInfo> listBillInfo = new List<BillInfo>();

            DataTable data = DataProvider.Instance.ExcuteQuery("SELECT * FROM dbo.BillInfo WHERE idBill = " + id);

            foreach(DataRow row in data.Rows)
            {
                BillInfo info = new BillInfo(row);
                listBillInfo.Add(info);
            }

            return listBillInfo;
        }

        public void InsertBilInfo(int idTable, int idBill, int count)
        {
            DataProvider.Instance.ExcuteNonQuery("EXEC USP_InsertBillInfo @idTable , @idBill , @count", new object[] { idTable, idBill, count });
        }
    }
}
