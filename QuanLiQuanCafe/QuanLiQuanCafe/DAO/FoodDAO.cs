using QuanLiQuanCafe.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLiQuanCafe.DAO
{
    public class FoodDAO
    {
        private static FoodDAO instance;

        public static FoodDAO Instance
        {
            get { if (instance == null) instance = new FoodDAO(); return FoodDAO.instance; }
            private set { FoodDAO.instance = value; }
        }

        public FoodDAO() { }

        public List<Food> GetFoodByCategoryID(int id)
        {
            List<Food> list = new List<Food>();

            string query = "SELECT * FROM dbo.Food WHERE idCategory = " + id;

            DataTable data = DataProvider.Instance.ExcuteQuery(query);

            foreach(DataRow row in data.Rows)
            {
                Food food = new Food(row);

                list.Add(food);
            }

            return list;
        }

        public List<Food> GetListFood()
        {
            List<Food> list = new List<Food>();

            string query = "SELECT * FROM dbo.Food";

            DataTable data = DataProvider.Instance.ExcuteQuery(query);

            foreach (DataRow row in data.Rows)
            {
                Food food = new Food(row);

                list.Add(food);
            }

            return list;
        }

        public bool InsertFood(string name, int id, double price)
        {
            string query = String.Format("INSERT dbo.Food (name, idCategory, price) VALUES(N'{0}', {1}, {2})", name, id, price);
            int result = DataProvider.Instance.ExcuteNonQuery(query);

            return result > 0;
        }

        public bool UpdateFood(int idFood, string name, int id, double price)
        {
            string query = String.Format("UPDATE dbo.Food SET name = N'{0}', idCategory = {1}, price = {2} WHERE id = {3}", name, id, price, idFood);
            int result = DataProvider.Instance.ExcuteNonQuery(query);

            return result > 0;
        }

        public bool DeleteFood(int id)
        {
            BillInfoDAO.Instance.DeleteBillInfoByFoodID(id);
            string query = String.Format("DELETE dbo.Food WHERE id = {0}", id);
            int result = DataProvider.Instance.ExcuteNonQuery(query);

            return result > 0;
        }

        public List<Food> SearchFood(string name)
        {
            List<Food> list = new List<Food>();

            string query = String.Format("SELECT * FROM dbo.Food WHERE dbo.GetUnsignString(name) LIKE N'%' + dbo.GetUnsignString(N'{0}') + N'%'", name);

            DataTable data = DataProvider.Instance.ExcuteQuery(query);

            foreach (DataRow row in data.Rows)
            {
                Food food = new Food(row);

                list.Add(food);
            }

            return list;
        }
    }
}
