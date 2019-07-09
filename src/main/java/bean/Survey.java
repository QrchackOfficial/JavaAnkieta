package bean;

import org.ocpsoft.prettytime.PrettyTime;

import java.sql.*;

public class Survey {
    static PrettyTime p = new PrettyTime();

    public static ResultSet getLastSurveys(Integer uid) {
        ResultSet rs;
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps = con.prepareStatement(
                    "select * from JavaAnkieta.surveys where owner_uid=?"
            );
            ps.setInt(1, uid);
            rs = ps.executeQuery();
            return rs;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static ResultSet getSurveyById(Integer uid, Integer survey_id) {
        ResultSet rs;
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps = con.prepareStatement(
                    "select * from JavaAnkieta.surveys where owner_uid=? and id=?"
            );
            ps.setInt(1, uid);
            ps.setInt(2, survey_id);
            rs = ps.executeQuery();
            return rs;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String getTitleBySurveyId(Integer survey_id) {
        ResultSet rs;
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps = con.prepareStatement(
                    "select * from JavaAnkieta.surveys where id=?"
            );
            ps.setInt(1, survey_id);
            rs = ps.executeQuery();
            rs.next();
            return rs.getString("name");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void addResponseCounter(Integer surveyid) {
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps = con.prepareStatement(
                    "select answers from surveys where id=?"
            );
            ps.setInt(1, surveyid);
            ResultSet rs = ps.executeQuery();
            rs.next();
            Integer answers = rs.getInt("answers");
            ps = con.prepareStatement(
                    "update JavaAnkieta.surveys set answers=? where id=?"
            );
            ps.setInt(1, answers + 1);
            ps.setInt(2, surveyid);
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void clearSurvey(Integer survey_id) {
        ResultSet rs;
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps = con.prepareStatement(
                    "delete from JavaAnkieta.questions where survey_id=?"
            );
            ps.setInt(1, survey_id);
            ps.executeUpdate();
            return;
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void deleteSurvey(Integer survey_id) {
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps = con.prepareStatement(
                    "delete from JavaAnkieta.questions where survey_id=?"
            );
            ps.setInt(1, survey_id);
            ps.executeUpdate();
            ps = con.prepareStatement(
                    "delete from JavaAnkieta.surveys where id=?"
            );
            ps.setInt(1, survey_id);
            ps.executeUpdate();
            return;
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static ResultSet getQuestionsBySurveyId(Integer survey_id) {
        ResultSet rs;
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps = con.prepareStatement(
                    // TODO join with userid
                    "select * from JavaAnkieta.questions where survey_id=?"
            );
            ps.setInt(1, survey_id);
            rs = ps.executeQuery();
            return rs;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String datePrint(Timestamp d) {
        return p.format(d);
    }
}
