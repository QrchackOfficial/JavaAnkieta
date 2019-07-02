package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
        if (status) return true;
        else return false;
    }

    public static int getUid(LoginBean bean) {
        return bean.getUid();
    }
}
