package com.company;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class OgrenciRepo {
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

    public Ogrenci ara(int ogrenciNo){
        System.out.println("Ogrenci Numarası Kontrol Ediliyor...");
        Ogrenci ogrenci= null;

        String sql= "SELECT * FROM \"Ogrenci\" WHERE \"ogrenciNo\"="+ogrenciNo;
        Connection conn = this.baglan();
        try{
            Statement stmt  = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            conn.close();
            int no;
            while(rs.next())
            {
                String isim = rs.getString("isim");
                String soyisim = rs.getString("soyisim");
                int danisman = rs.getInt("Danışman");
                int maxkredi = rs.getInt("maksimumKredi");
                int notOrt = rs.getInt("notOrtalaması");


                ogrenci  = new Ogrenci(isim,soyisim,danisman,maxkredi,notOrt);
            }
            rs.close();
            stmt.close();
        }
        catch (Exception e ){
            e.printStackTrace();
        }
        return ogrenci;
    }

    public void kaydet(Ogrenci ogrenci){
        String sql= "INSERT INTO  \"Ogrenci\" (\"isim\",\"soyisim\",\"Danışman\",\"maksimumKredi\",\"notOrtalaması\") VALUES(\'"+ogrenci.getIsim()+"\',\'"+ogrenci.getSoyisim()+"\',\'"+ogrenci.getDanisman()+"\',\'"+ogrenci.getMaxkredi()+"\',\'"+ogrenci.getNotort()+"\')";
        Connection conn=this.baglan();
        try
        {
            Statement stmt = conn.createStatement();
            stmt.executeUpdate(sql);
            //***** Bağlantı sonlandırma *****
            conn.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void sil(int ogrenciNo){
        System.out.println("Öğrenci siliniyor...");

        String sql= "DELETE FROM \"Ogrenci\" WHERE \"ogrenciNo\"="+ogrenciNo;

        Connection conn=this.baglan();
        try{
            Statement stmt = conn.createStatement();
            stmt.executeUpdate(sql);
            //***** Bağlantı sonlandırma *****
            conn.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void degistir(Ogrenci ogrenci,int no) {

        String sql= "UPDATE \"Ogrenci\" SET \"isim\"=\'"+ogrenci.getIsim()+ "\', \"soyisim\"=\'"+ogrenci.getSoyisim()+ "\',\"maksimumKredi\"=\'"+ogrenci.getMaxkredi()+ "\',\"Danışman\"=\'"+ogrenci.getDanisman()+ "\',\"notOrtalaması\"=\'"+ogrenci.getNotort()+ "\' WHERE \"ogrenciNo\"=\'"+no+"\'";

        Connection conn=this.baglan();

        try
        {
            Statement stmt = conn.createStatement();
            stmt.executeUpdate(sql);
            //***** Bağlantı sonlandırma *****
            conn.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
