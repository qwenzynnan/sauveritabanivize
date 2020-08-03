package com.company;

public class Ogrenci {
    String isim;
    String soyisim;
    int danisman;
    int maxkredi;
    int notort;

    public Ogrenci(String Isim,String Soyisim, int Danisman,int Maxkredi,int Notort){
        this.isim = Isim;
        this.soyisim = Soyisim;
        this.danisman = Danisman;
        this.maxkredi = Maxkredi;
        this.notort = Notort;
    }

    public String getIsim(){return isim;}
    public String getSoyisim(){return soyisim;}
    public int getDanisman(){return danisman;}
    public int getMaxkredi(){return maxkredi;}
    public int getNotort(){return notort;}
}
