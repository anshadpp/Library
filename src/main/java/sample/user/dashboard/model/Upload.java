package sample.user.dashboard.model;

import java.util.Base64;

public class Upload {
    private int id;
    private String username;
    private String bookName;
    private String authorName;
    private byte[] pdfFileData;
    private byte[] imageData;
    private String description;
    private String category;
    private double price;

    // Constructors
    public Upload() {
    }

    public Upload(String username, String bookName, String authorName, byte[] pdfFileData, byte[] imageData, String description, double price, String category) {
        this.username = username;
        this.bookName = bookName;
        this.authorName = authorName;
        this.pdfFileData = pdfFileData;
        this.imageData = imageData;
        this.description = description;
        this.category = category;
        this.price = price;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }
    public String getDescription() {
    	return description;
    }
    public String getCategory() {
    	return category;
    }
    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    public void setDescription(String description) {
    	this.description = description;
    }
    public void setCategory(String category) {
    	this.category = category;
    }
    public void setUsername(String username) {
        this.username = username;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public byte[] getPdfFileData() {
        return pdfFileData;
    }

    public void setPdfFileData(byte[] pdfFileData) {
        this.pdfFileData = pdfFileData;
    }

    public byte[] getImageData() {
        return imageData;
    }

    public void setImageData(byte[] imageData) {
        this.imageData = imageData;
    }

    public String getImageDataAsBase64() {
        if (imageData != null) {
            return Base64.getEncoder().encodeToString(imageData);
        }
        return null;
    }

    public String getPdfFileDataAsBase64() {
        if (pdfFileData != null) {
            return Base64.getEncoder().encodeToString(pdfFileData);
        }
        return null;
    }
}
