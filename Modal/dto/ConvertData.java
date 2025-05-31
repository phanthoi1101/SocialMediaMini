package dto;

import org.mindrot.jbcrypt.BCrypt;

public class ConvertData {

    // Hàm mã hóa mật khẩu với BCrypt
    public String hashMatKhau(String pass) {
        if (pass == null) {
            pass = "";
        }
        return BCrypt.hashpw(pass, BCrypt.gensalt());
    }

    // Hàm kiểm tra mật khẩu người dùng nhập có đúng không
    public boolean checkMatKhau(String enteredPassword, String hashedPassword) {
        return BCrypt.checkpw(enteredPassword, hashedPassword);
    }

    public static void main(String[] args) {
        ConvertData cv = new ConvertData();
        String originalPassword = "12345";
        
        // Băm mật khẩu
        String hashed = cv.hashMatKhau(originalPassword);
        System.out.println("Mật khẩu đã mã hóa: " + hashed);
        
        // Kiểm tra mật khẩu
        boolean isMatch = cv.checkMatKhau("123456", hashed);
        System.out.println("Mật khẩu khớp: " + isMatch);
    }
}