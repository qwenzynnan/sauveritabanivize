package com.company;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {

        OgrenciRepo ogrenciRepo = new OgrenciRepo();
        BolumRepo bolumRepo = new BolumRepo();
        DersRepo dersRepo = new DersRepo();
        OgretimUyesiRepo ogretimUyesiRepo = new OgretimUyesiRepo();
        Ogrenci ogrenci = null;

        Scanner get = new Scanner(System.in);
        int no=0;
        String index;

        System.out.println("Sakarya Üniversitesi Öğrenci Bilgi Sistemine Hoşgeldiniz. \n1- Öğrenciyim\n2- Öğrenci Olmak İstiyorum.");
        index = get.next();
        if (index.equals("1")) {
            System.out.print("Öğrenci Numaranız:");
            no = get.nextInt();
            ogrenci = ogrenciRepo.ara(no);
            System.out.println("Hoşgeldiniz " + ogrenci.isim + " " + ogrenci.soyisim);
        } else if (index.equals("2")) {
            System.out.println("Merhabalar. Okulumuzu seçtiğiniz için teşekkürler. Gerekli bilgileri lütfen giriniz");
            System.out.print("İsim:");
            String isim = get.next();
            System.out.print("\nSoyisim:");
            String soyisim = get.next();
            System.out.print("\nDanışman no:");
            int danisman = get.nextInt();
            System.out.print("\nMaksimum Kredi:");
            int maxkredi = get.nextInt();
            System.out.print("\nNot ortalaması:");
            int notort = get.nextInt();
            ogrenci = new Ogrenci(isim, soyisim, danisman, maxkredi, notort);
            ogrenciRepo.kaydet(ogrenci);
            System.out.println("Başarı ile kayıt oldunuz. Daha kaliteli bir sonuç için sistemden çıkıp tekrar giriş yapmanızı öneririz.");
        } else {
            System.out.println("Hatalı giriş yaptınız! Çıkış yapılıyor.");
            System.exit(0);
        }

        while (true) {
            System.out.println("1- Bolumleri Listele");
            System.out.println("2- Dersleri Listele");
            System.out.println("3- Öğretim Üyelerini Listele");
            System.out.println("4- Öğrenciliğimi Sil");
            System.out.println("5- Öğrencilik Bilgilerimi Güncelle");
            System.out.println("6- Seçtiğim İlçedeki Kampüsleri Listele");
            System.out.println("7- Çıkış");
            index = get.next();
            if (index.equals("1")) {
                bolumRepo.tumBolumler();
            }
            else if (index.equals("2")) {
                dersRepo.tumDersler();
            }
            else if (index.equals("3")) {
                ogretimUyesiRepo.tumOgretimUyeleri();
            }
            else if (index.equals("4")) {
                System.out.println("İşleminiz geri alınamaz! Devam Etmek istiyorsanız 'Onaylıyorum' yazınız.");
                String kontrol = get.next();
                if (kontrol.equals("onaylıyorum")||kontrol == "Onaylıyorum" || kontrol == "ONAYLIYORUM"){
                    if(no == 0) System.out.println("Sistemden Çıkıp tekrar girmeniz gerekmektedir");
                    else ogrenciRepo.sil(no);
                    System.out.println("Sakaryada Tekrar Görüşmek Üzere");
                    break;
                }
                else System.out.println("Onaylama işlemi başarısız :(");
            }
            else if (index.equals("5")) {
                if(no != 0){
                    System.out.print("\nİsim:");
                    String isim = get.next();
                    System.out.print("\nSoyisim:");
                    String soyisim = get.next();
                    System.out.print("\nDanışman no:");
                    int danisman = get.nextInt();
                    System.out.print("\nMaksimum Kredi:");
                    int maxkredi = get.nextInt();
                    System.out.print("\nNot ortalaması:");
                    int notort = get.nextInt();
                    ogrenci = new Ogrenci(isim, soyisim, danisman, maxkredi, notort);
                    ogrenciRepo.degistir(ogrenci,no);
                    System.out.println("Bilgilierinizi Başarı ile Güncellediniz!");
                }
                else System.out.println("Üyeliğiniz yeni olduğu için tekrar giriş yapmanız gerekmektedir.");
            }
            else if (index.equals("6")) {
                System.out.println("İlçe Kodunuzu Giriniz.");
                index = get.next();
                try {
                    Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/2",
                            "postgres", "zorsifre123");
                    if (conn != null)
                        System.out.println("Veritabanına bağlandı!");
                    else
                        System.out.println("Bağlantı girişimi başarısız!");


                    String sql = "SELECT \"kampusAdi\" FROM \"Kampus\" INNER JOIN \"ilce\" ON \"Kampus\".\"ilceNo\"=\"ilce\".\"ilceNo\" WHERE \"Kampus\".\"ilceNo\"=\'"+Integer.parseInt(index)+"\'";


                    // Sorgu çalıştırma //
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(sql);

                    // Bağlantı sonlandırma //
                    conn.close();

                    while (true) {
                        while (rs.next()) {
                            // Kayda ait alan değerlerini değişkene ata //
                            String kampusAdi = rs.getString("kampusAdi");

                            // Ekrana yazdır //
                            System.out.print("Kampüs Adı: " + kampusAdi+"\n");
                        }
                        rs.close();
                        stmt.close();
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            else if (index.equals("7")) {
                System.out.print("SABİS'i kullandığınız için teşekkür eder, iyi günler dileriz.");
                break;
            }
        }

    }
}
