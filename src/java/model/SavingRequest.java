/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class SavingRequest {
//     [saving_request_id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
//    [customer_id] INT NOT NULL, -- Người dùng tạo request
//    [saving_package_id] INT NOT NULL, -- Người dùng chọn gói
//	[staff_id] INT NOT NULL, -- Nhân viên xử lý request
//    [money] DECIMAL(18,2) NOT NULL, -- Số tiền yêu cầu gửi
//    [saving_approval_status] NVARCHAR(10) NOT NULL CHECK ([saving_approval_status] IN ('pending', 'approved', 'rejected')), -- Trạng thái request
//    [saving_approval_date] DATETIME NULL, -- Ngày được duyệt
//    [money_approval_status] NVARCHAR(10) NOT NULL CHECK ([money_approval_status] IN ('pending', 'received')), -- Trạng thái tiền đã vào ngân hàng
//	[saving_date] DATETIME NULL, -- Ngày bắt đầu tính lãi
//    [amount] DECIMAL(18,2) NOT NULL, -- Số tiền thực tế được nhận

    private int customer_id;
    private int saving_package_id;
    private Integer staff_id;
    private Double money;
    private String saving_approval_status;
    private String saving_approval_date;
    private String money_approval_status;
    private Double amount;
    private String created_at;
    private String saving_package_name;
    private String customer_name;
   private String method_money;

    public SavingRequest() {
    }

    public SavingRequest(int customer_id, int saving_package_id, Integer staff_id, Double money, String saving_approval_status, String saving_approval_date, String money_approval_status, Double amount, String created_at, String saving_package_name, String customer_name, String method_money) {
        this.customer_id = customer_id;
        this.saving_package_id = saving_package_id;
        this.staff_id = staff_id;
        this.money = money;
        this.saving_approval_status = saving_approval_status;
        this.saving_approval_date = saving_approval_date;
        this.money_approval_status = money_approval_status;
        this.amount = amount;
        this.created_at = created_at;
        this.saving_package_name = saving_package_name;
        this.customer_name = customer_name;
        this.method_money = method_money;
    }

    public String getMethod_money() {
        return method_money;
    }

    public void setMethod_money(String method_money) {
        this.method_money = method_money;
    }

   
    public String getCustomer_name() {
        return customer_name;
    }

    public void setCustomer_name(String customer_name) {
        this.customer_name = customer_name;
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public int getSaving_package_id() {
        return saving_package_id;
    }

    public void setSaving_package_id(int saving_package_id) {
        this.saving_package_id = saving_package_id;
    }

    public Integer getStaff_id() {
        return staff_id;
    }

    public void setStaff_id(Integer staff_id) {
        this.staff_id = staff_id;
    }

    public Double getMoney() {
        return money;
    }

    public void setMoney(Double money) {
        this.money = money;
    }

    public String getSaving_approval_status() {
        return saving_approval_status;
    }

    public void setSaving_approval_status(String saving_approval_status) {
        this.saving_approval_status = saving_approval_status;
    }

    public String getSaving_approval_date() {
        return saving_approval_date;
    }

    public void setSaving_approval_date(String saving_approval_date) {
        this.saving_approval_date = saving_approval_date;
    }

    public String getMoney_approval_status() {
        return money_approval_status;
    }

    public void setMoney_approval_status(String money_approval_status) {
        this.money_approval_status = money_approval_status;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }

    public String getSaving_package_name() {
        return saving_package_name;
    }

    public void setSaving_package_name(String saving_package_name) {
        this.saving_package_name = saving_package_name;
    }

}
