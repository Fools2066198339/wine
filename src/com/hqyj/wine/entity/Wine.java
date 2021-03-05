package com.hqyj.wine.entity;

public class Wine {
    private int id;
    private String wineName;
    private String price;
    private String produceAddress;
    private String wineType;
    private String bouquet;
    private String wineSale;

    public Wine(){

    }

    public Wine(int id, String wineName, String price, String produceAddress, String wineType, String bouquet, String wineSale) {
        this.id = id;
        this.wineName = wineName;
        this.price = price;
        this.produceAddress = produceAddress;
        this.wineType = wineType;
        this.bouquet = bouquet;
        this.wineSale = wineSale;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getWineName() {
        return wineName;
    }

    public void setWineName(String wineName) {
        this.wineName = wineName;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getProduceAddress() {
        return produceAddress;
    }

    public void setProduceAddress(String produceAddress) {
        this.produceAddress = produceAddress;
    }

    public String getWineType() {
        return wineType;
    }

    public void setWineType(String wineType) {
        this.wineType = wineType;
    }

    public String getBouquet() {
        return bouquet;
    }

    public void setBouquet(String bouquet) {
        this.bouquet = bouquet;
    }

    public String getWineSale() {
        return wineSale;
    }

    public void setWineSale(String wineSale) {
        this.wineSale = wineSale;
    }

    @Override
    public String toString() {
        return "Wine{" +
                "id=" + id +
                ", wineName='" + wineName + '\'' +
                ", price='" + price + '\'' +
                ", produceAddress='" + produceAddress + '\'' +
                ", wineType='" + wineType + '\'' +
                ", bouquet='" + bouquet + '\'' +
                ", wineSale='" + wineSale + '\'' +
                '}';
    }
}
