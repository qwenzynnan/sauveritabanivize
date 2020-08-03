package com.company;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DersRepo {
    private Connection baglan() {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/2",
                    "postgres", "zorsifre123");
            if (conn != null) {
                System.out.println("Veritabanına bağlandı!");
            } else
                System.out.println("Bağlantı Grişimi başarısız.");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    public void tumDersler() {

        System.out.println("Dersler Listeleniyor...");

        Connection conn = this.baglan();

        try {
            String sql = "SELECT \"dersKodu\",\"dersKresisi\",\"OgretmenSicilNo\",\"BinaNo\"  FROM \"Ders\"";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            //***** Bağlantı sonlandırma *****
            conn.close();

            while (rs.next()) {
                int dersKodu = rs.getInt("dersKodu");
                int dersKresisi = rs.getInt("dersKresisi");
                int OgretmenSicilNo = rs.getInt("OgretmenSicilNo");
                int BinaNo = rs.getInt("BinaNo");

                System.out.print("Ders Kodu: " + dersKodu);
                System.out.print(" ,Ders Kredisi: " + dersKresisi);
                System.out.print(" ,Öğretmen Sicil No: " + OgretmenSicilNo);
                System.out.print(" ,Bina No: " + BinaNo+"\n");

            }

            rs.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
