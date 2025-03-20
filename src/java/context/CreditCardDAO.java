package context;

import java.math.BigDecimal;
import model.CreditCard;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CreditCardDAO extends DBContext<CreditCard> {

    private static final Logger LOGGER = Logger.getLogger(CreditCardDAO.class.getName());

    public List<CreditCard> getCreditCardsByCustomerId(int customerId) {
        List<CreditCard> creditCards = new ArrayList<>();

        String getCardsSQL = "SELECT * FROM CreditCards WHERE customer_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(getCardsSQL)) {
            stmt.setInt(1, customerId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    CreditCard card = new CreditCard();
                    card.setCardId(rs.getInt("card_id"));
                    card.setCustomerId(rs.getInt("customer_id"));
                    card.setCardNumber(rs.getString("card_number"));
                    card.setCvv(rs.getString("cvv"));
                    card.setCreditLimit(rs.getBigDecimal("credit_limit"));
                    card.setAvailableBalance(rs.getBigDecimal("available_balance"));
                    card.setExpiryDate(rs.getDate("expiry_date"));
                    card.setStatus(rs.getString("status"));
                    creditCards.add(card);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy danh sách thẻ tín dụng: {0}", e.getMessage());
            return creditCards;
        }

        // Nếu khách hàng chưa có thẻ, kiểm tra điều kiện cấp thẻ
        if (creditCards.isEmpty()) {
            String checkEligibilitySQL = "SELECT COUNT(*) AS loan_count, SUM(amount) AS total_loan_amount "
                    + "FROM LoanRequests WHERE customer_id = ? AND status = 'approved' "
                    + "GROUP BY customer_id HAVING COUNT(*) >= 3 AND SUM(amount) >= 500000000";

            try (PreparedStatement checkStmt = connection.prepareStatement(checkEligibilitySQL)) {
                checkStmt.setInt(1, customerId);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next()) {
                        // Nếu đủ điều kiện, tạo một bản ghi thẻ tín dụng mới
                        createCreditCardForCustomer(customerId);
                        return getCreditCardsByCustomerId(customerId); // Gọi lại để lấy danh sách thẻ mới tạo
                    }
                }
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Lỗi khi kiểm tra điều kiện cấp thẻ tín dụng: {0}", e.getMessage());
            }
        }

        return creditCards;
    }

    // Hàm tạo thẻ tín dụng mới cho khách hàng nếu họ đủ điều kiện
    private void createCreditCardForCustomer(int customerId) {
        String insertCardSQL = "INSERT INTO CreditCards (customer_id, card_number, cvv, credit_limit, available_balance, expiry_date, status) "
                + "VALUES (?, ?, ?, ?, ?, DATEADD(YEAR, 3, GETDATE()), 'Active')";

        try (PreparedStatement stmt = connection.prepareStatement(insertCardSQL)) {
            stmt.setInt(1, customerId);
            stmt.setString(2, generateCardNumber());  // Hàm tạo số thẻ ngẫu nhiên
            stmt.setString(3, generateCVV());         // Hàm tạo CVV ngẫu nhiên
            stmt.setBigDecimal(4, new BigDecimal("100000000")); // Hạn mức 100 triệu VNĐ
            stmt.setBigDecimal(5, new BigDecimal("100000000")); // Số dư ban đầu = hạn mức
            stmt.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tạo thẻ tín dụng: {0}", e.getMessage());
        }
    }

    @Override
    public void update(CreditCard card) {
        String sql = "UPDATE CreditCards SET available_balance = ?, status = ? WHERE card_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setBigDecimal(1, card.getAvailableBalance());
            stmt.setString(2, card.getStatus());
            stmt.setInt(3, card.getCardId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi cập nhật thẻ tín dụng: {0}", e.getMessage());
        }
    }

    @Override
    public void delete(CreditCard card) {
        String sql = "DELETE FROM CreditCards WHERE card_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, card.getCardId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi xóa thẻ tín dụng: {0}", e.getMessage());
        }
    }

    @Override
    public ArrayList<CreditCard> list() {
        ArrayList<CreditCard> cards = new ArrayList<>();
        String sql = "SELECT * FROM CreditCard";
        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                cards.add(mapResultSetToCreditCard(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy danh sách thẻ tín dụng: {0}", e.getMessage());
        }
        return cards;
    }

    @Override
    public CreditCard get(int id) {
        String sql = "SELECT * FROM CreditCards WHERE card_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCreditCard(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy thông tin thẻ tín dụng: {0}", e.getMessage());
        }
        return null;
    }

    private CreditCard mapResultSetToCreditCard(ResultSet rs) throws SQLException {
        return new CreditCard(
                rs.getInt("card_id"),
                rs.getInt("customer_id"),
                rs.getString("card_number"),
                rs.getString("cvv"),
                rs.getDate("expiry_date"),
                rs.getBigDecimal("credit_limit"),
                rs.getBigDecimal("available_balance"),
                rs.getString("status")
        );
    }

    // Kiểm tra xem khách hàng đã có thẻ tín dụng chưa
    public boolean hasCreditCard(int customerId) {
        String sql = "SELECT COUNT(*) FROM CreditCards WHERE customer_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi kiểm tra thẻ tín dụng của khách hàng {0}: {1}", new Object[]{customerId, e.getMessage()});
        }
        return false;
    }

    // Cấp thẻ tín dụng cho khách hàng nếu đủ điều kiện
    public void createCreditCard(int customerId, String cardType, BigDecimal creditLimit) {
        if (hasCreditCard(customerId)) {
            LOGGER.log(Level.INFO, "Khách hàng {0} đã có thẻ tín dụng, không cần cấp thêm.", customerId);
            return;
        }

        // Kiểm tra điều kiện cấp thẻ trước khi tạo
        if (!isEligibleForCreditCard(customerId)) {
            LOGGER.log(Level.INFO, "Khách hàng {0} chưa đủ điều kiện nhận thẻ tín dụng!", customerId);
            return;
        }

        String sql = "INSERT INTO CreditCards (customer_id, card_number, cvv, expiry_date, credit_limit, available_balance, status) "
                + "VALUES (?, ?, ?, DATEADD(YEAR, 5, GETDATE()), ?, ?, 'active')";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            stmt.setString(2, generateCardNumber());
            stmt.setString(3, generateCVV());
            stmt.setBigDecimal(4, creditLimit);
            stmt.setBigDecimal(5, creditLimit); // Số dư ban đầu bằng hạn mức
            stmt.executeUpdate();
            LOGGER.log(Level.INFO, "Đã cấp thẻ tín dụng {0} với hạn mức {1} cho khách hàng {2}", new Object[]{cardType, creditLimit, customerId});
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi cấp thẻ tín dụng cho khách hàng {0}: {1}", new Object[]{customerId, e.getMessage()});
        }
    }

    // Kiểm tra điều kiện cấp thẻ tín dụng
    public boolean isEligibleForCreditCard(int customerId) {
        String sql = "SELECT COUNT(*) AS loan_count, SUM(amount) AS total_loan_amount "
                + "FROM LoanRequests WHERE customer_id = ? AND status = 'approved' "
                + "GROUP BY customer_id HAVING COUNT(*) >= 3 AND SUM(amount) >= 500000000";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // Nếu có dữ liệu trả về, nghĩa là đủ điều kiện
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi kiểm tra điều kiện cấp thẻ tín dụng: {0}", e.getMessage());
        }
        return false;
    }

    // Hàm tạo số thẻ tín dụng ngẫu nhiên (16 chữ số)
    private String generateCardNumber() {
        StringBuilder cardNumber = new StringBuilder();
        for (int i = 0; i < 16; i++) {
            cardNumber.append((int) (Math.random() * 10));
        }
        return cardNumber.toString();
    }

    // Hàm tạo CVV ngẫu nhiên (3 chữ số)
    private String generateCVV() {
        StringBuilder cvv = new StringBuilder();
        for (int i = 0; i < 3; i++) {
            cvv.append((int) (Math.random() * 10));
        }
        return cvv.toString();
    }

    @Override
    public void insert(CreditCard card) {
        if (!isEligibleForCreditCard(card.getCustomerId())) {
            LOGGER.log(Level.INFO, "Khách hàng {0} chưa đủ điều kiện nhận thẻ tín dụng!", card.getCustomerId());
            return;
        }
        createCreditCard(card.getCustomerId(), "Visa", card.getCreditLimit());
    }
}
