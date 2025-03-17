/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.saving;

import context.SavingDao;
import java.util.List;
import model.Saving;

/**
 *
 * @author admin
 */
public class Main {

    private static final SavingDao dao = new SavingDao();

    public static void main(String[] args) {
        int id = 25;
        List<Saving> list = dao.getSaving(id);

        for (Saving s : list) {
            System.out.println("Mã Tiết Kiệm: " + s.getSavings_id());
            System.out.println("Khách Hàng: " + s.getCustomer_name());
            System.out.println("Số Tiền Gửi: " + s.getAmount());
            System.out.println("Lãi Suất: " + s.getInterest_rate() + "%");
            System.out.println("Kỳ Hạn: " + s.getTerm_months() + " tháng");
            System.out.println("Ngày Mở: " + s.getOpened_date());
            System.out.println("Trạng Thái: " + s.getStatus());
            System.out.println("Ngày Nhận Tiền: " + s.getMoney_get_date());
            System.out.println("Phương Thức Thanh Toán: " + s.getPayment_method());
            System.out.println("Nhân Viên Xử Lý: " + s.getStaff_id());
            System.out.println("----------------------------------");
        }
    }

}
