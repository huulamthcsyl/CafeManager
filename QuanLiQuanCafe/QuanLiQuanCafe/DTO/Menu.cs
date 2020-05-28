using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLiQuanCafe.DTO
{
    public class Menu
    {
        private string foodName;
        private int count;
        private double totalPrice;
        private double price;

        public string FoodName { get => foodName; set => foodName = value; }
        public int Count { get => count; set => count = value; }
        public double TotalPrice { get => totalPrice; set => totalPrice = value; }
        public double Price { get => price; set => price = value; }

        public Menu(string foodName, int count, double price, double totalPrice = 0)
        {
            this.FoodName = foodName;
            this.Count = count;
            this.Price = price;
            this.TotalPrice = totalPrice;
        }

        public Menu(DataRow row)
        {
            this.FoodName = row["name"].ToString();
            this.Count = (int)row["count"];
            this.Price = (double)row["price"];
            this.TotalPrice = (double)row["totalPrice"];
        }
    }
}
