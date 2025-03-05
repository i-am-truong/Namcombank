package model;

public class SavingPackage {

//        [saving_package_id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
//    [staff_id] INT NOT NULL,
//    [saving_package_name] NVARCHAR(255) NOT NULL,
//    [saving_package_description] NVARCHAR(MAX) NOT NULL,
//    [saving_package_interest_rate] DECIMAL(5,2) NOT NULL,
//    [saving_package_term_months] INT NOT NULL,
//    [saving_package_min_deposit] DECIMAL(18,2) NOT NULL,
//    [saving_package_max_deposit] DECIMAL(18,2) NULL,
//    [saving_package_status] NVARCHAR(10) NOT NULL CHECK ([saving_package_status] IN ('active', 'inactive')),
//    [saving_package_created_at] DATETIME NOT NULL DEFAULT GETDATE(),
//    [saving_package_updated_at] DATETIME NULL,
//    [saving_package_withdrawable] BIT NOT NULL DEFAULT 1,
//	[saving_package_approval_status] NVARCHAR(10) NOT NULL CHECK ([saving_package_approval_status] IN ('pending', 'approved')),
    
    private int staff_id;
    private String saving_package_name;
    private String saving_package_description;
    private double saving_package_interest_rate;
    private int saving_package_term_months;
    private Double saving_package_min_deposit;
    private Double saving_package_max_deposit;
    private String saving_package_status;
    private String saving_package_created_at;
    private String saving_package_updated_at;
    private boolean saving_withdrawable;
    private String saving_package_approval_status;

    public SavingPackage() {
    }

    public int getStaff_id() {
        return staff_id;
    }

    public void setStaff_id(int staff_id) {
        this.staff_id = staff_id;
    }

    public String getSaving_package_name() {
        return saving_package_name;
    }

    public void setSaving_package_name(String saving_package_name) {
        this.saving_package_name = saving_package_name;
    }

    public String getSaving_package_description() {
        return saving_package_description;
    }

    public void setSaving_package_description(String saving_package_description) {
        this.saving_package_description = saving_package_description;
    }

    public double getSaving_package_interest_rate() {
        return saving_package_interest_rate;
    }

    public void setSaving_package_interest_rate(double saving_package_interest_rate) {
        this.saving_package_interest_rate = saving_package_interest_rate;
    }

    public int getSaving_package_term_months() {
        return saving_package_term_months;
    }

    public void setSaving_package_term_months(int saving_package_term_months) {
        this.saving_package_term_months = saving_package_term_months;
    }

    public Double getSaving_package_min_deposit() {
        return saving_package_min_deposit;
    }

    public void setSaving_package_min_deposit(Double saving_package_min_deposit) {
        this.saving_package_min_deposit = saving_package_min_deposit;
    }

    public Double getSaving_package_max_deposit() {
        return saving_package_max_deposit;
    }

    public void setSaving_package_max_deposit(Double saving_package_max_deposit) {
        this.saving_package_max_deposit = saving_package_max_deposit;
    }

    public String getSaving_package_status() {
        return saving_package_status;
    }

    public void setSaving_package_status(String saving_package_status) {
        this.saving_package_status = saving_package_status;
    }

    public String getSaving_package_created_at() {
        return saving_package_created_at;
    }

    public void setSaving_package_created_at(String saving_package_created_at) {
        this.saving_package_created_at = saving_package_created_at;
    }

    public String getSaving_package_updated_at() {
        return saving_package_updated_at;
    }

    public void setSaving_package_updated_at(String saving_package_updated_at) {
        this.saving_package_updated_at = saving_package_updated_at;
    }

    public boolean isSaving_withdrawable() {
        return saving_withdrawable;
    }

    public void setSaving_withdrawable(boolean saving_withdrawable) {
        this.saving_withdrawable = saving_withdrawable;
    }

    public String getSaving_package_approval_status() {
        return saving_package_approval_status;
    }

    public void setSaving_package_approval_status(String saving_package_approval_status) {
        this.saving_package_approval_status = saving_package_approval_status;
    }

}
