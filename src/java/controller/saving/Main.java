/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.saving;

import context.SavingDao;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;
import model.Saving;
import model.auth.Staff;

/**
 *
 * @author admin
 */
public class Main {

    private static final SavingDao dao = new SavingDao();

    public static void main(String[] args) {
        int savings_id = 24;
        int customer_id = dao.selectCustomer_id_by_savings_id(savings_id);

        int saving_request_id = dao.selectSavingRequest_Id_(savings_id);
        int saving_package_id = dao.selectSaving_package_id_by_SavingRequest(saving_request_id);
        int term_months = dao.selectSaving_term(savings_id);
        String opened_date = dao.selectSavingOpendate(savings_id);
        double money = dao.selectMoney(saving_request_id);

        double money_getted;

        double rate1 = dao.selectSavingPackageOver_haft(saving_package_id);
        double rate2 = dao.selectSavingPackageUnder_haft(saving_package_id);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate openedDateLocal = LocalDate.parse(opened_date, formatter);

        LocalDate todayLocalDate = LocalDate.now();
        long monthsElapsed = ChronoUnit.MONTHS.between(todayLocalDate, openedDateLocal);

        money_getted = money;
        double take = (monthsElapsed / (double) term_months);
        if (take > 0.5) {
            money_getted = money + money * rate1 / 100 * monthsElapsed / 24;
        } else {
            money_getted = money + money * rate2 / 100 * monthsElapsed / 24;
        }

        int staff_id = 1;

        String selectPayment_method= dao.selectPayment_method(savings_id);
        String payment_method= dao.selectPayment_method(savings_id);
//        dao.SavingCancel(savings_id, staff_id, money_getted);
        System.out.println(payment_method);
    }

}
//2.0E8 1.8E9
