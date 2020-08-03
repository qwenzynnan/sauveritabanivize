package com.company;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class BolumRepo {
    private Connection baglan(){
        Connection conn = null;
        try{
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/2",
                    "postgres", "zorsifre123");
            if(conn != null){
                System.out.println("Veritabanına bağlandı!");
            }
            else
                System.out.println("Bağlantı Grişimi başarısız.");
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return conn;
    }

    public void tumBolumler(){

        System.out.println("Bolumler Listeleniyor...");

        Connection conn=this.baglan();

        try{
            String sql= "SELECT \"BolumAdi\", \"FakulteNo\"  FROM \"Bolum\"";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            //***** Bağlantı sonlandırma *****
            conn.close();

            while(rs.next())
            {
                int fakulteno  = rs.getInt("FakulteNo");
                String BolumAdi = rs.getString("BolumAdi");

                System.out.print("Bölüm Adı:"+BolumAdi);
                System.out.print(",Fakülte Adı: "+ fakulteno+"\n");
            }

            rs.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
