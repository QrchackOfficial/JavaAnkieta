package bean;

import java.sql.*;

public class LoginDao {
    public static boolean validate(LoginBean bean) {
        boolean status = false;
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps = con.prepareStatement(
                    "select * from JavaAnkieta.users where email=? and password=?"
            );
            ps.setString(1,bean.getEmail());
            ps.setString(2,bean.getPassword());
            ResultSet rs = ps.executeQuery();
            status = rs.next();
            bean.setUid(rs.getInt("id"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public static int getUid(LoginBean bean) {
        return bean.getUid();
    }

    public static Integer addUser(String email, String password) {
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps = con.prepareStatement(
                    "insert into users(id,email,password) values(null,?,?)",
                    Statement.RETURN_GENERATED_KEYS
            );
            ps.setString(1, email);
            ps.setString(2, password);
            ps.execute();
            ResultSet rs = ps.getGeneratedKeys();
            int key = 0;
            if (rs.next()) {
                key = rs.getInt(1);
                return key;
            } else {
                // TODO handle this
                return -1;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
}
