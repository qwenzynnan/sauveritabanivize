package com.company;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class OgretimUyesiRepo {
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

    public void tumOgretimUyeleri() {

        System.out.println("Öğretim Üyeleri Listeleniyor...");

        Connection conn = this.baglan();

        try {
            String sql = "SELECT \"sicilNo\",\"isim\",\"soyisim\",\"bolumNo\"  FROM \"Ogretim Uyesi\"";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            //***** Bağlantı sonlandırma *****
            conn.close();

            while (rs.next()) {
                int sicilNo = rs.getInt("sicilNo");
                String isim = rs.getString("isim");
                String soyİsim = rs.getString("soyisim");
                int bolumNo = rs.getInt("bolumNo");

                System.out.print("Sicil Numarası: " + sicilNo);
                System.out.print(" ,İsim: " + isim);
                System.out.print(" ,Soyisim: " + soyİsim);
                System.out.print(" ,Bölüm Numarası: " + bolumNo+"\n");

            }

            rs.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
