package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Survey {
    public static ResultSet getLastSurveys(Integer uid) {
        ResultSet rs;
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps = con.prepareStatement(
                    "select * from JavaAnkieta.surveys where owner_uid=?"
            );
            ps.setString(1, uid.toString());
            rs = ps.executeQuery();
            return rs;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
